local Translations = {
    --client
	client = {
        open_house_day = 'Dia de puertas abiertas, habla con ',
        home_sweet_home =  'Hogar dulce hogar',
        owners_menu = 'Menu de Propietario',
        estate_agent =  'Agente inmobiliario',
        buy_property = 'Compra una Propiedad',
        buy_property_desc = 'Día de puertas abiertas, cual te gusta?',
        sell_property = 'Vende una Propiedad',
        sell_property_desc = 'Ya no te interesa, te la compro?',
        view_property_tax = 'Ver Contribucion territorial',
        money_from_properties = 'verificar y retirar el dinero de las propiedades',
	},
	
	-- antiguo buymenu
	buymenu = {
        buy_house = 'Comprar Casa',
        buy_price = 'Precio: $',
        tax = ' | Contribucion territorial: $',
	},
	
	-- sellmenu
	sellmenu = {
        sell_house = 'Vender casa',
        sell_price = 'Precio de venta $',
		
        locked = '¡Bloqueado!',
	},
	
	--housemenu
	housemenu = {
        owner = 'Propietario de ',
        wardrobe = 'Armario',
        custom_wardrobe = 'Tu propio armario personalizado',
        storage = 'Almacen',
        safe_and_organized = 'Un espacio seguro y organizado',
        house_guests = 'Invitados de la casa',
        access_control = 'Control total sobre quien tiene acceso',
        property_tax = 'Contribución territorial',
        financial_contribution = 'Un aporte financiero para mantener tu propiedad',
        guest_in = 'Invitado en',
		
        property = 'Propiedad ',
        add_guests = 'Añadir Invitados',
        add_guests_desc = '',
        remove_guests = 'Eliminar Invitados',
        remove_guests_desc = '',
		
        -- addguest
        add_house_guest = 'Agregar invitado a la casa',
        add = "Agregar",
        citizen_id = 'Identificación del citizenid',
        -- removeguest
        remove_house_guest = 'Eliminar invitado',
        remove_error = '',
        quit = 'Cerrar',

        stash = "escondite",
	
	--creditmenu
	credit = {
        non_owner = '¡No eres el dueño de esta casa!',
        property_credit = 'Crédito Territorial',
        current_credit = 'Crédito actual: $',
        current_property_credit = 'Estado de tu credito territorial actual',
        add_credit = 'Añadir Credito',
        add_credit_desc = 'Garantiza que puedas seguir en perfecto estado',
        withdraw_credit = 'Quitar Credito',
        withdraw_credit_desc = 'Retira el dinero, para una venta',
    
        amount = 'Importe',
        amount_add_desc = 'Añade una cantidad para añadir:',
        amount_withdraw_desc = 'Añade una cantidad para retirar:',
	},
	
	--server
	server = {
        u_already_have = '¡Ya tienes una casa!',
        purchased = '¡Casa comprada!',
        sold = '¡Casa vendida!',
        added_property_tax = 'Has añadido la Contribución territorial de ',
        property_credit_now = 'Tu crédito sobre la propiedad es ahora $',
        not_enough_money = 'No tienes suficiente dinero!',
        cannot_withdraw = 'No puedes retirar más crédito del que tienes!',
        withdrawn_property_tax = 'Has retirado dinero de la Contribución territorial de ',
        target_person_has_key = '¡La persona objetivo ya tiene una llave de otra casa!',
        added_guest = ' agregado como invitado en tu casa!',
        removed_guest = ' eliminado de la lista de invitados de tu casa!'
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

if GetConvar('rsg_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
