description 'Blurr Core'

client_scripts {
	'cl/main.lua',
	'cl/character.lua',
	'cl/other.lua',
	'cl/removenpc.lua',
	'cl/voicechat.lua'
}

server_scripts {
	'sv/main.lua',
	'sv/user.lua',
	'sv/bans.lua',
	'sv/character.lua',
	'sv/defaults.lua',
	'sv/util.lua',
}

server_exports {
	'getPlayer',
	'getPlayers',
}

fx_version 'adamant'
games { 'gta5' }