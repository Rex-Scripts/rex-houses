local RSGCore = exports['rsg-core']:GetCoreObject()

-- get house keys
RSGCore.Functions.CreateCallback('rex-houses:server:GetHouseKeys', function(source, cb)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local housekeys = MySQL.query.await('SELECT * FROM rex_housekeys WHERE citizenid=@citizenid', { ['@citizenid'] = citizenid })

    if housekeys[1] == nil then return end
    cb(housekeys)
end)

-- get house keys (guests)
RSGCore.Functions.CreateCallback('rex-houses:server:GetGuestHouseKeys', function(source, cb)
    local guestinfo = MySQL.query.await('SELECT * FROM rex_housekeys WHERE guest=@guest', {['@guest'] = 1})

    if guestinfo[1] == nil then return end
    cb(guestinfo)
end)

-- get house info
RSGCore.Functions.CreateCallback('rex-houses:server:GetHouseInfo', function(source, cb)
    local houseinfo = MySQL.query.await('SELECT * FROM rex_houses', {})

    if houseinfo[1] == nil then 
        return
    end

    cb(houseinfo)
end)

-- get owned house info
RSGCore.Functions.CreateCallback('rex-houses:server:GetOwnedHouseInfo', function(source, cb)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    if Player == nil then return end
    local citizenid = Player.PlayerData.citizenid
    local houseinfo = MySQL.query.await('SELECT * FROM rex_houses WHERE citizenid=@citizenid AND owned=@owned', { ['@citizenid'] = citizenid, ['@owned'] = 1 })

    if houseinfo[1] == nil then 
        cb('nohouse')
    end

    cb(houseinfo)
end)

-- buy house
RegisterServerEvent('rex-houses:server:buyhouse', function(data)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local firstname = Player.PlayerData.charinfo.firstname
    local lastname = Player.PlayerData.charinfo.lastname
    local fullname = (firstname..' '..lastname)
    local housecount = MySQL.prepare.await('SELECT COUNT(*) FROM rex_houses WHERE citizenid = ?', {citizenid})

    if housecount >= 1 then
        RSGCore.Functions.Notify(src, Lang:t('server.u_already_have'), 'error')
        return
    end

    if (Player.PlayerData.money.cash < data.price) then
        RSGCore.Functions.Notify(src, 'You don\'t have enough cash!', 'error')
        return
    end

    MySQL.update('UPDATE rex_houses SET citizenid = ?, fullname = ?, owned = ?, credit = ? WHERE houseid = ?',
    {   citizenid,
        fullname,
        1,
        Config.StartCredit,
        data.house
    })

    MySQL.insert('INSERT INTO rex_housekeys(citizenid, houseid) VALUES(@citizenid, @houseid)',
    {   ['@citizenid']  = citizenid,
        ['@houseid']    = data.house
    })

    Player.Functions.RemoveMoney('cash', data.price)
    RSGCore.Functions.Notify(src, Lang:t('server.purchased'), 'success')
    TriggerClientEvent('rex-houses:client:BlipsOnSpawn', src, data.blip)
    TriggerEvent('rsg-log:server:CreateLog', 'rexhouses', 'House Purchased', 'green', fullname..' purchased '..data.house..' for $'..data.price)

end)

-- sell house
RegisterServerEvent('rex-houses:server:sellhouse', function(data)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local citizenid = Player.PlayerData.citizenid
    local firstname = Player.PlayerData.charinfo.firstname
    local lastname = Player.PlayerData.charinfo.lastname
    local fullname = (firstname..' '..lastname)

    MySQL.update('UPDATE rex_houses SET citizenid = 0, fullname = 0, credit = 0, owned = 0 WHERE houseid = ?', {data.house})
    MySQL.update('UPDATE rex_doors SET doorstate = 1 WHERE houseid = ?', {data.house})
    MySQL.update('DELETE FROM rex_housekeys WHERE houseid = ?', {data.house})
    Player.Functions.AddMoney('cash', data.price, "house-sale")
    RSGCore.Functions.Notify(src, Lang:t('server.sold'), 'success')
    TriggerClientEvent('rex-houses:client:BlipsOnSpawn', src, data.blip)
    TriggerEvent('rsg-log:server:CreateLog', 'rexhouses', 'House Sold', 'red', fullname..' sold '..data.house..' for $'..data.price)

end)

-- add house credit
RegisterNetEvent('rex-houses:server:addcredit', function(newcredit, removemoney, houseid)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local cashBalance = Player.PlayerData.money["cash"]
        
    if cashBalance >= removemoney then
        Player.Functions.RemoveMoney("cash", removemoney, "land-tax-credit")
        MySQL.update('UPDATE rex_houses SET credit = ? WHERE houseid = ?', {newcredit, houseid})
        RSGCore.Functions.Notify(src, Lang:t('server.added_property_tax')..houseid, 'success')
        Wait(3000)
        RSGCore.Functions.Notify(src, Lang:t('server.property_credit_now')..newcredit, 'primary')
    else
        RSGCore.Functions.Notify(src,  Lang:t('server.not_enough_money'), 'error')
    end
end)

-- remove house credit
RegisterNetEvent('rex-houses:server:removecredit', function(newcredit, removemoney, houseid)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)
    local cashBalance = Player.PlayerData.money["cash"]
        
    if cashBalance >= removemoney then
        local updatedCredit = newcredit

        if updatedCredit < 0 then
            RSGCore.Functions.Notify(src, Lang:t('server.cannot_withdraw'), 'error')
            return
        end

        Player.Functions.AddMoney("cash", removemoney, "land-tax-credit")
        MySQL.update('UPDATE rex_houses SET credit = ? WHERE houseid = ?', {updatedCredit, houseid})
        RSGCore.Functions.Notify(src, Lang:t('server.withdrawn_property_tax')..houseid, 'success')
        Wait(3000)
        RSGCore.Functions.Notify(src, Lang:t('server.property_credit_now')..updatedCredit, 'primary')
    else
        RSGCore.Functions.Notify(src, Lang:t('server.not_enough_money'), 'error')
    end
end)

--------------------------------------------------------------------------------------------------

-- get all door states
RSGCore.Functions.CreateCallback('rex-houses:server:GetDoorState', function(source, cb)
    local doorstate = MySQL.query.await('SELECT * FROM rex_doors', {})
    if doorstate[1] == nil then return end
    cb(doorstate)
end)

-- get current door state
RSGCore.Functions.CreateCallback('rex-houses:server:GetCurrentDoorState', function(source, cb, door)
    local result = MySQL.query.await('SELECT doorstate FROM rex_doors WHERE doorid = ?', {door})
    if result[1] == nil then return end
    cb(result[1].doorstate)
end)

-- get specific door state
RegisterNetEvent('rex-houses:server:GetSpecificDoorState', function(door)
    local src = source
    local result = MySQL.query.await('SELECT * FROM rex_doors WHERE doorid = ?', {door})

    if result[1] == nil then return end

    local doorid = result[1].doorid
    local doorstate = result[1].doorstate

    if Config.Debug then
        print("")
        print("Door ID: "..doorid)
        print("Door State: "..doorstate)
        print("")
    end

    TriggerClientEvent('rex-houses:client:GetSpecificDoorState', src, doorid, doorstate)
end)

-- update door state
RegisterNetEvent('rex-houses:server:UpdateDoorState', function(doorid, doorstate)
    local src = source

    MySQL.update('UPDATE rex_doors SET doorstate = ? WHERE doorid = ?', {doorstate, doorid})

    TriggerClientEvent('rex-houses:client:GetSpecificDoorState', src, doorid, doorstate)
end)

RegisterNetEvent('rex-houses:server:UpdateDoorStateRestart', function()
    local result = MySQL.query.await('SELECT * FROM rex_doors WHERE doorstate=@doorstate', {['@doorstate'] = 1})
    
    if not result then
        MySQL.update('UPDATE rex_doors SET doorstate = 1')
    end
end)

--------------------------------------------------------------------------------------------------

-- land tax billing loop
BillingInterval = function()
    local result = MySQL.query.await('SELECT * FROM rex_houses WHERE owned=@owned', {['@owned'] = 1})

    if not result then goto continue end

    for i = 1, #result do
        local row = result[i]

        if Config.Debug then
            print(row.agent, row.houseid, row.citizenid, row.fullname, row.owned, row.price, row.credit)
        end

        if row.credit >= Config.LandTaxPerCycle then
            local creditadjust = (row.credit - Config.LandTaxPerCycle)

            MySQL.update('UPDATE rex_houses SET credit = ? WHERE houseid = ? AND citizenid = ?',
            {   creditadjust,
                row.houseid,
                row.citizenid
            })

            local creditwarning = (Config.LandTaxPerCycle * Config.CreditWarning)

            if row.credit < creditwarning then
                MySQL.insert('INSERT INTO telegrams (citizenid, recipient, sender, sendername, subject, sentDate, message) VALUES (?, ?, ?, ?, ?, ?, ?)',
                {   row.citizenid,
                    row.fullname,
                    '22222222',
                    'Land Tax Office',
                    'Land Tax Credit Due to Run Out!',
                    os.date("%x"),
                    'Your land tax credit for your house is due to run out!',
                })
            end
        else
            MySQL.insert('INSERT INTO telegrams (citizenid, recipient, sender, sendername, subject, sentDate, message) VALUES (?, ?, ?, ?, ?, ?, ?)',
            {   row.citizenid,
                row.fullname,
                '22222222',
                'Land Tax Office',
                'Land Tax Credit Ran Out!',
                os.date("%x"),
                'Due to lack of tax credit, your house has been repossessed!',
            })

            Wait(1000)

            MySQL.update('UPDATE rex_houses SET citizenid = 0, fullname = 0, owned = 0 WHERE houseid = ?', {row.houseid})
            MySQL.update('DELETE FROM rex_housekeys WHERE houseid = ?', {row.houseid})
            if Config.PurgeStorage then
                MySQL.update('DELETE FROM stashitems WHERE stash = ?', {row.houseid})
            end
            TriggerEvent('rsg-log:server:CreateLog', 'rexhouses', 'House Lost', 'red', row.fullname..' house '..row.houseid..' has been lost due to non payment of tax!')
        end

        if row.agent == 'newhanover' then
           exports['rsg-bossmenu']:AddMoney('govenor1', Config.LandTaxPerCycle)
        end

        if row.agent == 'westelizabeth' then
            exports['rsg-bossmenu']:AddMoney('govenor2', Config.LandTaxPerCycle)
        end

        if row.agent == 'newaustin' then
            exports['rsg-bossmenu']:AddMoney('govenor3', Config.LandTaxPerCycle)
        end

        if row.agent == 'ambarino' then
            exports['rsg-bossmenu']:AddMoney('govenor4', Config.LandTaxPerCycle)
        end

        if row.agent == 'lemoyne' then
            exports['rsg-bossmenu']:AddMoney('govenor5', Config.LandTaxPerCycle)
        end
    end

    ::continue::

    print('Land Tax Billing Cycle Complete')

    SetTimeout(Config.BillingCycle * (60 * 60 * 1000), BillingInterval) -- hours
    -- SetTimeout(Config.BillingCycle * (60 * 1000), BillingInterval) -- mins (for testing)
end

SetTimeout(Config.BillingCycle * (60 * 60 * 1000), BillingInterval) -- hours
-- SetTimeout(Config.BillingCycle * (60 * 1000), BillingInterval) -- mins (for testing)

--------------------------------------------------------------------------------------------------

-- add house guest
RegisterNetEvent('rex-houses:server:addguest', function(cid, houseid)
    local src = source
    local keycount = MySQL.prepare.await('SELECT COUNT(*) FROM rex_housekeys WHERE citizenid = ? AND houseid = ?', {cid, houseid})

    if keycount >= 1 then
        RSGCore.Functions.Notify(src, Lang:t('server.target_person_has_key'), 'error')
        return
    end

    MySQL.insert('INSERT INTO rex_housekeys(citizenid, houseid, guest) VALUES(@citizenid, @houseid, @guest)',
    {   ['@citizenid']  = cid,
        ['@houseid']    = houseid,
        ['@guest']      = 1,
    })
    RSGCore.Functions.Notify(src, cid..Lang:t('server.added_guest'), 'success')
end)

RegisterNetEvent('rex-houses:server:removeguest', function(houseid, guestcid)
    local src = source
    MySQL.update('DELETE FROM rex_housekeys WHERE houseid = ? AND citizenid = ?', { houseid, guestcid })
    RSGCore.Functions.Notify(src, guestcid..Lang:t('server.removed_guest'), 'success')
end)
