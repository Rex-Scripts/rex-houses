local Translations = {
    --client
	client = {
		open_house_day = 'Tag der offenen Tür, sprich mit dem ',
		home_sweet_home = 'Home Sweet Home',
		owners_menu = 'Besitzer Menü',
		estate_agent = 'Immobilienmakler',
		buy_property = 'Eine Immobilie kaufen',
		buy_property_desc = 'Tag der offenen Tür, welche Immobillie gefällt Ihnen?',
		sell_property = 'Eine Immobilie verkaufen',
		sell_property_desc = 'Kein Interesse mehr, soll ich es Ihnen abkaufen?',
		view_property_tax = 'Grundstückssteuer anzeigen',
		money_from_properties = 'Prüfen und Abheben von Geldern aus Immobilien',
	},
	
	-- buymenu
	buymenu = {
		buy_house = 'Haus kaufen',
		buy_price = 'Preis $',
		tax = ' : Grundstückssteuer $',
	},
	
	-- sellmenu
	sellmenu = {
		sell_house = 'Haus verkaufen',
		sell_price = 'Verklaufspreis $',
		
		locked = 'Verschlossen!',
	},
	
	--housemenu
	housemenu = {
		owner = 'Besitzer von ',
		wardrobe = 'Kleiderschrank',
		custom_wardrobe = 'Ihr individueller Kleiderschrank',
		storage = 'Lager',
		safe_and_organized = 'Ein sicherer und gut organisierter Raum',
		house_guests = 'Gäste des Hauses',
		access_control = 'Vollständige Kontrolle darüber, wer Zugang hat',
		property_tax = 'Immobiliensteuer',
		financial_contribution = 'Finanzieller Beitrag zum Erhaltung Ihres Eigentums',
		guest_in = 'Zu Gast im ',
		
		property = 'Immobilie ',
		add_guests = 'Gäste einladen',
		add_guests_desc = '',
		remove_guests = 'Gäste entfernen',
		remove_guests_desc = '',
		
		-- addguest
		add_house_guest = 'Gast hinzufügen',
		add = 'Hinzufügen',
		citizen_id = 'Citizen ID',

		-- removeguest
		remove_house_guest = 'Gast entfernen',
		remove_error = '',
		quit = 'Abschließen',

		stash = 'verbergen',
	},
	
	--creditmenu
	credit = {
		non_owner = 'Sie sind nicht der Eigentümer dieses Hauses!',
		property_credit = 'Immobilien Guthaben',
		current_credit = 'Aktuelles Guthaben: $',
		current_property_credit = 'Status Ihres derzeitigen Immobilien Guthaben',
		add_credit = 'Guthaben hinzufügen',
		add_credit_desc = 'Sicherstellen, dass Sie in perfekter Kondition bleiben.',
		withdraw_credit = 'Guthaben abheben',
		withdraw_credit_desc = 'Geld für einen Handel abheben',

		amount = 'Betrag',
		amount_add_desc = 'Betrag hinzufügen:',
		amount_withdraw_desc = 'Füge einen Betrag hinzu, der abgehoben werden soll:',
	},
	
	--server
	server = {
		u_already_have = 'Du hast bereits ein Haus!',
		purchased = 'Haus erworben!',
		sold = 'Haus verkauft!',
		added_property_tax = 'Du hast die Grundstückssteuer hinzugefügt. In Höhe von ',
		property_credit_now = 'Dein Immobilien Guthaben beträgt jetzt $',
		not_enough_money = 'Du hast nicht genug Geld!',
		cannot_withdraw = 'Du kannst nicht mehr Geld abheben, als du hast!',
		withdrawn_property_tax = 'Du hast Geld aus der Grundstückssteuer entnommen. In Höhe von ',
		target_person_has_key = 'Die Zielperson hat bereits einen Schlüssel zu einem anderen Haus!',
		added_guest = ' als Gast zu Ihrem Haus hinzugefügt!',
		removed_guest = ' von der Gästeliste deines Hauses gestrichen!',
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

if GetConvar('rsg_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
