fx_version 'adamant'

game 'gta5'

author '2fast4u#1337'
description 'Carwipes by the bad dev'
version '1.3.3.7'

shared_script 'shared/config.lua'

client_scripts {
	'client/main.lua',
	'locales.lua'
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	'server/main.lua'
}
