local Translations = {
    --client
	client = {
        open_house_day = 'Open huis, praat met ',
        home_sweet_home = 'Home sweet home',
        owners_menu = 'Eigenaarsmenu',
        estate_agent = 'Makelaar',
        buy_property = 'Koop een Eigendom',
        buy_property_desc = 'Open huis, welke vind je leuk?',
        sell_property = 'Verkoop een Eigendom',
        sell_property_desc = 'Niet meer geïnteresseerd, zal ik het kopen?',
        view_property_tax = 'Bekijk Grondlasten',
        money_from_properties = 'controleer en haal het geld van de eigendommen',
	},
	
	-- oud koopmenu
	buymenu = {
        buy_house = 'Koop Huis',
        buy_price = 'Prijs: $',
        tax = ' | Grondlasten: $',
	},
	
	-- sellmenu
	sellmenu = {
        sell_house = 'Verkoop huis',
        sell_price = 'Verkoopprijs $',
	sell_nohouse = 'Je hebt geen huis!',
        locked = 'Vergrendeld!',
	},
	
	--housemenu
	housemenu = {
        owner = 'Eigenaar van ',
        wardrobe = 'Kledingkast',
        custom_wardrobe = 'Je eigen gepersonaliseerde kledingkast',
        storage = 'Opslag',
        safe_and_organized = 'Een veilige en georganiseerde ruimte',
        house_guests = 'Huisgasten',
        access_control = 'Volledige controle over wie toegang heeft',
        property_tax = 'Grondlasten',
        financial_contribution = 'Een financiële bijdrage om je eigendom te behouden',
        guest_in = 'Gast in',
        
        property = 'Eigendom ',
        add_guests = 'Voeg Gasten toe',
        add_guests_desc = '',
        remove_guests = 'Verwijder Gasten',
        remove_guests_desc = '',
        
        -- addguest
        add_house_guest = 'Gast toevoegen aan huis',
        add = "Toevoegen",
        citizen_id = 'CitizenID',
    
        -- removeguest
        remove_house_guest = 'Gast verwijderen',
        remove_error = '',
        quit = 'Sluiten',

        stash = "schuilplaats",
	},
	
	--creditmenu
	credit = {
        non_owner = 'Je bent niet de eigenaar van dit huis!',
        property_credit = 'Territoriaal Krediet',
        current_credit = 'Huidig krediet: $',
        current_property_credit = 'Status van je huidige territoriaal krediet',
        add_credit = 'Voeg Krediet toe',
        add_credit_desc = 'Zorgt ervoor dat je in perfecte staat kunt blijven',
        withdraw_credit = 'Verwijder Krediet',
        withdraw_credit_desc = 'Haal het geld eruit, voor een verkoop',
    
        amount = 'Bedrag',
        amount_add_desc = 'Voeg een bedrag toe om toe te voegen:',
        amount_withdraw_desc = 'Voeg een bedrag toe om te verwijderen:',
	},
	
	--server
	server = {
        u_already_have = 'Je hebt al een huis!',
        purchased = 'Huis gekocht!',
        sold = 'Huis verkocht!',
        added_property_tax = 'Je hebt de Grondlasten toegevoegd van ',
        property_credit_now = 'Je krediet voor het eigendom is nu $',
        not_enough_money = 'Je hebt niet genoeg geld!',
        cannot_withdraw = 'Je kunt niet meer krediet opnemen dan je hebt!',
        withdrawn_property_tax = 'Je hebt geld opgenomen van de Grondlasten van ',
        target_person_has_key = 'De doelpersoon heeft al een sleutel van een ander huis!',
        added_guest = ' toegevoegd als gast in je huis!',
        removed_guest = ' verwijderd van de gastenlijst van je huis!'
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

if GetConvar('rsg_locale', 'en') == 'nl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
