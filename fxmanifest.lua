fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'
lua54 'yes'

description 'rex-houses'
version '1.0.4'

client_scripts {
    'client/client.lua',
    'client/npcs.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua',
    'server/versionchecker.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    '@rsg-core/shared/locale.lua',
    'locales/en.lua', -- preferred language
    'config.lua'
}

dependencies {
    'ox_lib',
    'rsg-core',
    'rsg-npcs',
    'rsg-bossmenu'
}
