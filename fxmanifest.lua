fx_version 'cerulean'
game 'gta5'
lua54 "yes"
name "NT FormCreator"
description "Create Interactive Forms"
author "Ticker"
version "1.0.0"

ui_page 'ui/dist/index.html'
files {
	'ui/dist/index.html',
	'ui/dist/assets/*.css',
	'ui/dist/assets/*.js',
}
shared_scripts {
	'@ox_lib/init.lua',
	'configs/config.lua'
}

client_scripts {
	'client/*.lua',
	'bridge/**/**/client.lua',
	'bridge/**/client.lua',
}
server_scripts {
	'server/*.lua',
	'bridge/**/**/server.lua',
	'bridge/**/server.lua',
}

dependencies {
	"ox_lib"
}
