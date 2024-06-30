local Translations = {
    --client
	client = {
		open_house_day = 'Open House Day, talk to ',
		home_sweet_home = 'Home Sweet Home',
		owners_menu = 'Owners Menu',
		estate_agent = 'Estate Agent',
		buy_property = 'Buy a Property',
		buy_property_desc = 'Open House Day, which one do you like?',
		sell_property = 'Sell a Property',
		sell_property_desc = 'Not interested anymore, shall I buy it from you?',
		view_property_tax = 'View Property Tax',
		money_from_properties = 'Check and withdraw money from properties',
	},
	
	-- buymenu
	buymenu = {
		buy_house = 'Buy House',
		buy_price = 'Price $',
		tax = ' : Land Tax $',
	},
	
	-- sellmenu
	sellmenu = {
		sell_house = 'Sell House',
		sell_price = 'Sell Price $',
		sell_nohouse = 'You are not owning a house!',
		locked = 'Locked!',
	},
	
	--housemenu
	housemenu = {
		owner = 'Owner of ',
		wardrobe = 'Wardrobe',
		custom_wardrobe = 'Your custom wardrobe',
		storage = 'Storage',
		safe_and_organized = 'A safe and organized space', 
		house_guests = 'House Guests',
		access_control = 'Total control over who has access',
		property_tax = 'Property Tax',
		financial_contribution = 'Financial contribution to maintain your property',
		guest_in = 'Guest in ',

		property = 'Property ',
		add_guests = 'Add Guests',
		add_guests_desc = '',
		remove_guests = 'Remove Guests',
		remove_guests_desc = '',
		
		-- addguest
		add_house_guest = 'Add House Guest',
		add = 'Add',
		citizen_id = 'Citizen ID',
		
		-- removeguest
		remove_house_guest = 'Remove Guest',
		remove_error = '',
		quit = 'Close',

		stash = 'stash',
	},
	
	--creditmenu
	credit = {
		non_owner = 'You are not the owner of this house!',
		property_credit = 'Property Credit',
		current_credit = 'Current Credit: $',
		current_property_credit = 'Status of your current property credit',
		add_credit = 'Add Credit',
		add_credit_desc = 'Ensure you can stay in perfect condition',
		withdraw_credit = 'Withdraw Credit',
		withdraw_credit_desc = 'Withdraw money for a sale',

		amount = 'Amount',
		amount_add_desc = 'Add an amount to add:',
		amount_withdraw_desc = 'Add an amount to withdraw:',
	},
	
	--server
	server = {
		u_already_have = 'You already have a house!',
		purchased = 'House purchased!',
		sold = 'House sold!',
		added_property_tax = 'You have added Property Tax of ',
		property_credit_now = 'Your property credit is now $',
		not_enough_money = 'You dont have enough money!',
		cannot_withdraw = 'You cannot withdraw more credit than you have!',
		withdrawn_property_tax = 'You have withdrawn money from Property Tax of ',
		target_person_has_key = 'The target person already has a key to another house!',
		added_guest = ' added as a Guest in your house!',
		removed_guest = ' removed from your house\'s Guest list!',
	},
	
	--propertyname *User defined names are possible*
	property = {
		house1 = 'House 1',
		house2 = 'House 2',
		house3 = 'House 3',
		house4 = 'House 4',
		house5 = 'House 5',
		house6 = 'House 6',
		house7 = 'House 7',
		house8 = 'House 8',
		house9 = 'House 9',
		house10 = 'House 10',
		house11 = 'House 11',
		house12 = 'House 12',
		house13 = 'House 13',
		house14 = 'House 14',
		house15 = 'House 15',
		house16 = 'House 16',
		house17 = 'House 17',
		house18 = 'House 18',
		house19 = 'House 19',
		house20 = 'House 20',
		house21 = 'House 21',
		house22 = 'House 22',
		house23 = 'House 23',
		house24 = 'House 24',
		house25 = 'House 25',
		house26 = 'House 26',
		house27 = 'House 27',
		house28 = 'House 28',
		house29 = 'House 29',
		house30 = 'House 30',
		house31 = 'House 31',
		house32 = 'House 32',
		house33 = 'House 33',
		house34 = 'House 34',
		house35 = 'House 35',
		house36 = 'House 36',
		house37 = 'House 37',
		house38 = 'House 38',
		house39 = 'House 39',
		house40 = 'House 40',
		house41 = 'House 41', --spare
		house42 = 'House 42',
		house43 = 'House 43',
		house44 = 'House 44',
		house45 = 'House 45',
		house46 = 'House 46',
	},
	
}

-- Lang:t('lang_0')

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
