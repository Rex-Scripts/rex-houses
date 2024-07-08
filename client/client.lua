local RSGCore = exports['rsg-core']:GetCoreObject()
local doorLockPrompt = GetRandomIntInRange(0, 0xffffff)
local lockPrompt = nil
local DoorID = nil
local HouseID = nil
local myhouse = nil
local HouseBlip = nil
local blipchecked = false
local checked = false
local doorStatus = '~e~Locked~q~'
local createdEntries = {}
local doorLists = {}
local currenthouseshop = nil

---------------------------------------
-- door lock / unlock animation
---------------------------------------
local UnlockAnimation = function()
    local ped = PlayerPedId()
    local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_Finger12")
    local dict = "script_common@jail_cell@unlock@key"

    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)

        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(10)
        end
    end

    local prop = CreateObject("P_KEY02X", GetEntityCoords(ped) + vec3(0, 0, 0.2), true, true, true)

    TaskPlayAnim(ped, "script_common@jail_cell@unlock@key", "action", 8.0, -8.0, 2500, 31, 0, true, 0, false, 0, false)
    Wait(750)
    AttachEntityToEntity(prop, ped, boneIndex, 0.02, 0.0120, -0.00850, 0.024, -160.0, 200.0, true, true, false, true, 1, true)

    while IsEntityPlayingAnim(ped, "script_common@jail_cell@unlock@key", "action", 3) do
        Wait(100)
    end

    DeleteObject(prop)
end

---------------------------------------
-- door prompt
---------------------------------------
local DoorLockPrompt = function()
    local str = 'Use'
    local stra = CreateVarString(10, 'LITERAL_STRING', str)

    lockPrompt = PromptRegisterBegin()
    PromptSetControlAction(lockPrompt, RSGCore.Shared.Keybinds['ENTER'])
    PromptSetText(lockPrompt, stra)
    PromptSetEnabled(lockPrompt, 1)
    PromptSetVisible(lockPrompt, 1)
    PromptSetHoldMode(lockPrompt, true)
    PromptSetGroup(lockPrompt, doorLockPrompt)
    PromptRegisterEnd(lockPrompt)

    createdEntries[#createdEntries + 1] = {type = "nPROMPT", handle = lockPrompt}
    createdEntries[#createdEntries + 1] = {type = "nPROMPT", handle = doorLockPrompt}
end

---------------------------------------
-- real estate agent blips
-----------------------------------------
local EstateAgentBlips = function()
    for i = 1, #Config.EstateAgents do
        local agent = Config.EstateAgents[i]
        if agent.showblip then
            local AgentBlip = BlipAddForCoords(1664425300, agent.coords)
            local blipSprite = joaat(Config.Blip.blipSprite)
            SetBlipSprite(AgentBlip, blipSprite, true)
            SetBlipScale(AgentBlip, Config.Blip.blipScale)
            SetBlipName(AgentBlip, Config.Blip.blipName)
            createdEntries[#createdEntries + 1] = {type = "BLIP", handle = AgentBlip}
        end
    end
end

-----------------------------------------------------------------------
-- house my house blip
-----------------------------------------------------------------------
local SetHouseBlips = function()

    for i = 1, #createdEntries do
        if createdEntries[i].type == "BLIP" then
            RemoveBlip(createdEntries[i].handle)
        end
    end

    RSGCore.Functions.TriggerCallback('rex-houses:server:GetOwnedHouseInfo', function(result)
        if result == 'nohouse' then
            for i = 1, #Config.Houses do
                local house = Config.Houses[i]
                local HouseBlip = BlipAddForCoords(1664425300, house.blipcoords)
                SetBlipSprite(HouseBlip, joaat('blip_proc_home'), true)
                SetBlipScale(HouseBlip, 0.4)
                SetBlipName(HouseBlip, house.name)
                createdEntries[#createdEntries + 1] = {type = "BLIP", handle = HouseBlip}
            end
        else
            local houseid = result[1].houseid
            myhouse = houseid
            
            for i = 1, #Config.Houses do

                local house = Config.Houses[i]

                if house.houseid == myhouse then
                    local HouseBlip = BlipAddForCoords(1664425300, house.blipcoords)
                    SetBlipSprite(HouseBlip, joaat('blip_proc_home_locked'), true)
                    SetBlipScale(HouseBlip, 0.4)
                    SetBlipName(HouseBlip, Lang:t('client.home_sweet_home'))
                    BlipAddModifier(HouseBlip, joaat('BLIP_MODIFIER_MP_COLOR_8'))
                    createdEntries[#createdEntries + 1] = {type = "BLIP", handle = HouseBlip}
                end
            end
        end
    end)

end

--------------------------------------
-- set house blips on player load
--------------------------------------
RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
    SetHouseBlips()
end)

---------------------------------
-- update blips every min
---------------------------------
CreateThread(function()
    while true do
        SetHouseBlips()
        EstateAgentBlips()
        Wait(60000) -- every min
    end       
end)

---------------------------------------
-- get door state from database and set
---------------------------------------
CreateThread(function()
    while true do
        checked = false

        RSGCore.Functions.TriggerCallback('rex-houses:server:GetDoorState', function(results)
            for i = 1, #results do
                local door = results[i]
                Citizen.InvokeNative(0xD99229FE93B46286, tonumber(door.doorid), 1, 1, 0, 0, 0, 0) -- AddDoorToSystemNew
                Citizen.InvokeNative(0x6BAB9442830C7F53, tonumber(door.doorid), door.doorstate) -- DoorSystemSetDoorState
            end
        end)

        Wait(10000)
    end
end)

---------------------------------------
-- get specific door state from database
---------------------------------------
CreateThread(function()
    local ped = PlayerPedId()
    DoorLockPrompt()
    while true do
        ped = PlayerPedId()
        local playerCoords = GetEntityCoords(ped)
        local t = 1000
        for i = 1, #Config.HouseDoors do
            local house = Config.HouseDoors[i]
            local distance = #(playerCoords - house.doorcoords)
            if distance < 2.0 then
                t = 4
                HouseID = house.houseid
                DoorID = house.doorid

                if Config.Debug then
                    print("")
                    print("House ID: "..HouseID)
                    print("Door ID: "..DoorID)
                    print("")
                end
                if not checked then
                    TriggerServerEvent('rex-houses:server:GetSpecificDoorState', DoorID)
                    checked = true
                end

                 local label = CreateVarString(10, 'LITERAL_STRING', house.name..': '..doorStatus)

                PromptSetActiveGroupThisFrame(doorLockPrompt, label)

                if PromptHasHoldModeCompleted(lockPrompt) then
                    TriggerEvent("rex-houses:client:toggledoor", DoorID, HouseID)
                    t = 1000
                    checked = false
                end
            end
        end
        Wait(t)
    end
end)

---------------------------------------
-- house menu prompt
---------------------------------------
CreateThread(function()
    for i = 1, #Config.Houses do
        local house = Config.Houses[i]

        exports['rsg-core']:createPrompt(house.houseprompt, house.menucoords, RSGCore.Shared.Keybinds['J'], Lang:t('client.owners_menu'),
        {
            type = 'client',
            event = 'rex-houses:client:housemenu',
            args = {house.houseid},
        })

        createdEntries[#createdEntries + 1] = {type = "PROMPT", handle = house.houseprompt}
    end
end)

---------------------------------------
-- get door state
---------------------------------------
RegisterNetEvent('rex-houses:client:GetSpecificDoorState', function(id, state)
    DoorID = id
    local doorstate = state

    if doorstate == 1 then
        doorStatus = '~e~Locked~q~'
    else
        doorStatus = '~t6~Unlocked~q~'
    end
end)

---------------------------------------
-- real estate agent menu
---------------------------------------
RegisterNetEvent('rex-houses:client:agentmenu', function(location)
    lib.registerContext({
        id = "estate_agent_menu",
        title = Lang:t('client.estate_agent'),
        options = {
                {   title = Lang:t('client.buy_property'),
                    icon = 'fa-solid fa-user',
                    description = Lang:t('client.buy_property_desc'),
                    event = 'rex-houses:client:buymenu',
                    arrow = true,
                    args = { 
                        isServer = false,
                        agentlocation = location }
                },
                {   title = Lang:t('client.sell_property'),
                    icon = 'fa-solid fa-user',
                    description = Lang:t('client.sell_property_desc'),
                    event = 'rex-houses:client:sellmenu',
                    arrow = true,
                    args = { 
                        isServer = false,
                        agentlocation = location }
                },
                {
                    title = Lang:t('client.view_property_tax'),
                    description = Lang:t('client.money_from_properties'),
                    icon = 'fa-solid fa-sack-dollar',
                    event = 'rsg-bossmenu:client:mainmenu',
                    arrow = true
                },
            }
        })
    lib.showContext("estate_agent_menu")
end)

---------------------------------------
-- buy house menu
---------------------------------------
RegisterNetEvent('rex-houses:client:buymenu', function(data)
    local houseContextOptions = {
        {
            title = Lang:t('buymenu.buy_house'),
            isMenuHeader = true,
            icon = "fas fa-home"
        }
    }

    RSGCore.Functions.TriggerCallback('rex-houses:server:GetHouseInfo', function(cb)
        for i = 1, #cb do
            local house = cb[i]
            local agent = house.agent
            local houseid = house.houseid
            local owned = house.owned
            local price = house.price

            if agent == data.agentlocation and owned == 0 then
                houseContextOptions[#houseContextOptions + 1] = {
                    title = Lang:t(('property.')..houseid),
                    icon = "fas fa-home",
                    description = Lang:t('buymenu.buy_price')..house.price..Lang:t('buymenu.tax')..Config.LandTaxPerCycle,
                    onSelect = function()
                        TriggerServerEvent('rex-houses:server:buyhouse', {
                            house = houseid,
                            price = price,
                            blip = HouseBlip
                        })
                    end
                }
            end
        end

        lib.registerContext({
            id = "context_buy_house_Id",
            title = Lang:t('buymenu.buy_house'),
            options = houseContextOptions
        })

        lib.showContext("context_buy_house_Id")
    end)
end)

---------------------------------------
-- sell house menu
---------------------------------------
RegisterNetEvent('rex-houses:client:sellmenu', function(data)
    local sellContextOptions = {
        {
            title = Lang:t('sellmenu.sell_house'),
            isMenuHeader = true,
            icon = "fas fa-home"
        }
    }

    RSGCore.Functions.TriggerCallback('rex-houses:server:GetOwnedHouseInfo', function(cb)

        if cb == 'nohouse' then
            RSGCore.Functions.Notify(Lang:t('sellmenu.sell_nohouse'), 'error')
        else
            for i = 1, #cb do
                local house = cb[i]
                local agent = house.agent
                local houseid = house.houseid
                local owned = house.owned
                local sellprice = (house.price * Config.SellBack)

                if agent == data.agentlocation and owned == 1 then
                    sellContextOptions[#sellContextOptions + 1] = {
                        title = Lang:t(('property.')..houseid),
                        icon = "fas fa-home",
                        description = Lang:t('sellmenu.sell_price')..sellprice,
                        onSelect = function()
                            TriggerServerEvent('rex-houses:server:sellhouse', {
                                house = houseid,
                                price = sellprice,
                                blip = HouseBlip
                            })
                        end
                    }
                end
            end
        lib.registerContext({
            id = "context_sell_house_Id",
            title = Lang:t('sellmenu.sell_house'),
            options = sellContextOptions
        })
        lib.showContext("context_sell_house_Id")
        end
    end)
end)

---------------------------------------
-- lock / unlock door
---------------------------------------
RegisterNetEvent('rex-houses:client:toggledoor', function(door, house)
    RSGCore.Functions.TriggerCallback('rex-houses:server:GetHouseKeys', function(results)
        for i = 1, #results do
            local housekey = results[i]
            local playercitizenid = RSGCore.Functions.GetPlayerData().citizenid
            local resultcitizenid = housekey.citizenid
            local resulthouseid = housekey.houseid

            if resultcitizenid == playercitizenid and resulthouseid == house then
                RSGCore.Functions.TriggerCallback('rex-houses:server:GetCurrentDoorState', function(cb)
                    local doorstate = cb

                    if doorstate == 1 then
                        UnlockAnimation()

                        Citizen.InvokeNative(0xD99229FE93B46286, door, 1, 1, 0, 0, 0, 0) -- AddDoorToSystemNew
                        Citizen.InvokeNative(0x6BAB9442830C7F53, door, 0) -- DoorSystemSetDoorState
                        TriggerServerEvent('rex-houses:server:UpdateDoorState', door, 0)
                        RSGCore.Functions.Notify('Unlocked!', 'success')
                                    
                        doorStatus = '~t6~Unocked~q~'
                    end

                    if doorstate == 0 then
                        UnlockAnimation()

                        Citizen.InvokeNative(0xD99229FE93B46286, door, 1, 1, 0, 0, 0, 0) -- AddDoorToSystemNew
                        Citizen.InvokeNative(0x6BAB9442830C7F53, door, 1) -- DoorSystemSetDoorState
                        TriggerServerEvent('rex-houses:server:UpdateDoorState', door, 1)
                        RSGCore.Functions.Notify(Lang:t('sellmenu.locked'), 'error')

                        doorStatus = '~e~Locked~q~'
                    end
                end, door)
            end

            createdEntries[#createdEntries + 1] = {type = "DOOR", handle = door}
        end
    end)
end)

---------------------------------------
-- house menu
---------------------------------------
RegisterNetEvent('rex-houses:client:housemenu', function(houseid)
    RSGCore.Functions.TriggerCallback('rex-houses:server:GetHouseKeys', function(results)
        for i = 1, #results do
            local housekey = results[i]
            local playercitizenid = RSGCore.Functions.GetPlayerData().citizenid
            local citizenid = housekey.citizenid
            local houseids = housekey.houseid
            local guest = housekey.guest

            if citizenid == playercitizenid and houseids == houseid and guest == 0 then
                lib.registerContext(
                    {   id = 'house_menu',
                    title = string.format(Lang:t('housemenu.owner')..(' \n\"')..Lang:t(('property.')..houseid)..('\"')),
                    position = 'top-right',
                    options = {
                        {   title = Lang:t('housemenu.storage'),
                            description = Lang:t('housemenu.safe_and_organized'),
                            icon = 'fas fa-box',
                            event = 'rex-houses:client:storage',
                            arrow = true,
                            args = { house = houseid },
                        },
                        {   title = Lang:t('housemenu.house_guests'),
                            description = Lang:t('housemenu.access_control'),
                            icon = 'fas fa-glass-cheers',
                            event = 'rex-houses:client:guestmenu',
                            arrow = true,
                            args = { house = houseid },
                        },
                        {   title = Lang:t('housemenu.property_tax'),
                            description = Lang:t('housemenu.financial_contribution'),
                            icon = 'fas fa-dollar-sign',
                            event = 'rex-houses:client:creditmenu',
                            arrow = true,
                            args = { house = houseid },
                        },
                    }
                })
                lib.showContext('house_menu')
            elseif citizenid == playercitizenid and houseids == houseid and guest == 1 then
                lib.registerContext(
                {   id = 'house_guest_menu',
                    title = Lang:t('housemenu.guest_in')..(' \n\"')..Lang:t(('property.')..houseid)..('\"'),
                    position = 'top-right',
                    options = {
                        {   title = Lang:t('housemenu.storage'),
                            description = Lang:t('housemenu.safe_and_organized'),
                            icon = 'fas fa-box',
                            event = 'rex-houses:client:storage',
                            args = { house = houseid },
                        },
                    }
                })
                lib.showContext('house_guest_menu')
            end
        end
    end)
end)

---------------------------------------
-- house credit menu
---------------------------------------
RegisterNetEvent('rex-houses:client:creditmenu', function(data)
    RSGCore.Functions.TriggerCallback('rex-houses:server:GetOwnedHouseInfo', function(result)
        local housecitizenid = result[1].citizenid
        local houseid = result[1].houseid
        local credit = result[1].credit
        local playercitizenid = RSGCore.Functions.GetPlayerData().citizenid

        if housecitizenid ~= playercitizenid then
            RSGCore.Functions.Notify(Lang:t('credit.non_owner'), 'error')
            return
        end

        if housecitizenid == playercitizenid then
            lib.registerContext({
                id = 'house_credit_menu',
                title = Lang:t('credit.property_credit'),
                menu = "house_menu",
                icon = 'fas fa-home',
                position = 'top-right',
                options = {
                    {
                        title = Lang:t('credit.current_credit') .. credit,
                        description = Lang:t('credit.current_property_credit'),
                        icon = 'fas fa-dollar-sign',
                        args =
                            {   isServer = false,
                                houseid = houseid,
                                credit = credit
                            }
                    },
                    {
                        title = Lang:t('credit.add_credit'),
                        description =  Lang:t('credit.add_credit_desc'),
                        icon = 'fas fa-dollar-sign',
                        event = 'rex-houses:client:addcredit',
                        args =
                            {   isServer = false,
                                houseid = houseid,
                                credit = credit
                            }
                    },
                    {
                        title = Lang:t('credit.withdraw_credit'),
                        description =  Lang:t('credit.withdraw_credit_desc'),
                        icon = 'fas fa-dollar-sign',
                        event = 'rex-houses:client:removecredit',
                        args = {
                            isServer = false,
                            houseid = houseid,
                            credit = credit
                        }
                    }
                }
            })

            lib.showContext('house_credit_menu')
        end
    end)
end) 

---------------------------------------
-- credit form
---------------------------------------
RegisterNetEvent('rex-houses:client:addcredit', function(data)
    local input = lib.inputDialog(Lang:t('credit.property_credit'), {
        { 
            type = 'number',
            title = Lang:t('credit.amount'),
            description = Lang:t('credit.amount_add_desc'),
            required = true,
            default = 50,
        },
    }, {
        allowCancel = true,
    })

    if input then
        local amount = tonumber(input[1])

        if Config.Debug == true then
            print(amount)
            print(data.houseid)
        end

        local newcredit = data.credit + amount
        TriggerServerEvent('rex-houses:server:addcredit', newcredit, amount, data.houseid)
    else
        if Config.Debug == true then
            print("input dialog was cancelled")
        end
    end
end)

---------------------------------------
-- remove house credit
---------------------------------------
RegisterNetEvent('rex-houses:client:removecredit', function(data)
    local input = lib.inputDialog(Lang:t('credit.property_credit'), {
        { 
            type = 'number',
            title = Lang:t('credit.amount'),
            description = Lang:t('credit.amount_withdraw_desc'),
            required = true,
            default = 50,
        },
    }, {
        allowCancel = true,
    })

    if input then
        local amount = tonumber(input[1])

        if Config.Debug == true then
            print(amount)
            print(data.houseid)
        end

        local newcredit = data.credit - amount
        TriggerServerEvent('rex-houses:server:removecredit', newcredit, amount, data.houseid)
    else
        if Config.Debug == true then
            print("input dialog was cancelled")
        end
    end
end)

---------------------------------------
-- guest menu
---------------------------------------
RegisterNetEvent('rex-houses:client:guestmenu', function(data)
    RSGCore.Functions.TriggerCallback('rex-houses:server:GetOwnedHouseInfo', function(result)
        local housecitizenid = result[1].citizenid
        local houseid = result[1].houseid
        local playercitizenid = RSGCore.Functions.GetPlayerData().citizenid

        if housecitizenid ~= playercitizenid then
            RSGCore.Functions.Notify(Lang:t('lang_26'), 'error')
            return
        end

        if housecitizenid == playercitizenid then
            lib.registerContext(
            {   id = 'house_addguest_menu',
                title = Lang:t('housemenu.property')..(' \n\"')..Lang:t(('property.')..houseid)..('\"'),
                menu = "house_menu",
                position = 'top-right',
                options = {
                    {   title = Lang:t('housemenu.add_guests'),
                        description = Lang:t('housemenu.add_guests_desc'),
                        icon = 'fas fa-house',
                        event = 'rex-houses:client:addguest',
                        arrow = true,
                        args = { houseid = houseid, isServer = false, },
                    },
                    {   title = Lang:t('housemenu.remove_guests'),
                        description = Lang:t('housemenu.remove_guests_desc'),
                        icon = 'fas fa-book',
                        event = 'rex-houses:client:removeguest',
                        arrow = true,
                        args = { houseid = houseid, isServer = false, },
                    },
                }
            })
            lib.showContext('house_addguest_menu')
        end
    end)
end)

---------------------------------------
-- Add House Guest
---------------------------------------
RegisterNetEvent('rex-houses:client:addguest', function(data)
    local upr = string.upper

    local input = lib.inputDialog('Add House Guest', {
        {   type = 'input', 
            label = Lang:t('housemenu.citizen_id'), 
            required = true },
    })

    if not input then return end

    local addguest = input[1]
    local houseid = data.houseid

    if Config.Debug then
        print("")
        print("House ID: " .. houseid)
        print("Add Guest: " .. addguest)
        print("")
    end

    TriggerServerEvent('rex-houses:server:addguest', upr(addguest), houseid)
end)

---------------------------------------
-- Remove House Guest
---------------------------------------
RegisterNetEvent('rex-houses:client:removeguest', function(data)
    RSGCore.Functions.TriggerCallback('rex-houses:server:GetGuestHouseKeys', function(cb)
        local option = {}

        for i = 1, #cb do
            local guest = cb[i]
            local houseid = guest.houseid
            local citizenid = guest.citizenid

            if houseid == data.houseid then
                local content = { 
                    value = citizenid,
                    label = citizenid }
                option[#option + 1] = content
            end
        end

        if #option == 0 then
            RSGCore.Functions.Notify(Lang:t('housemenu.remove_error'), 'error')
            return
        end

        local input = lib.inputDialog(Lang:t('housemenu.remove_house_guest'), {
            {   type = 'select', 
                options = option, 
                required = true, 
                default = option[1].value }
        })

        if not input then return end

        local citizenid = input[1]

        if citizenid then
            local houseid = data.houseid
            TriggerServerEvent('rex-houses:server:removeguest', citizenid, houseid)
        end
    end)
end)

---------------------------------------
-- house storage
---------------------------------------
RegisterNetEvent('rex-houses:client:storage', function(data)
    local house = data.house

    TriggerServerEvent("inventory:server:OpenInventory", "stash", data.house,
    {   
        maxweight = Config.StorageMaxWeight,
        slots = Config.StorageMaxSlots,
    })

    TriggerEvent("inventory:client:SetCurrentStash", house)
end)

---------------------------------------
-- update door state on restart
---------------------------------------
AddEventHandler('onResourceStart', function(resource)
    TriggerServerEvent('rex-houses:server:UpdateDoorStateRestart')
end)

---------------------------------------
-- cleanup system
---------------------------------------
AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end

    for i = 1, #createdEntries do
        if createdEntries[i].type == "BLIP" then
            RemoveBlip(createdEntries[i].handle)
        end

        if createdEntries[i].type == "PROMPT" then
            exports['rsg-core']:deletePrompt(createdEntries[i].handle)
        end

        if createdEntries[i].type == "nPROMPT" then
            PromptDelete(createdEntries[i].handle)
            PromptDelete(createdEntries[i].handle)
        end

        if createdEntries[i].type == "DOOR" then
            Citizen.InvokeNative(0xD99229FE93B46286, createdEntries[i].handle, 1, 1, 0, 0, 0, 0) -- AddDoorToSystemNew
            Citizen.InvokeNative(0x6BAB9442830C7F53, createdEntries[i].handle, 1) -- DoorSystemSetDoorState

            TriggerServerEvent('rex-houses:server:UpdateDoorState', createdEntries[i].handle, 1)
        end
    end
end)
