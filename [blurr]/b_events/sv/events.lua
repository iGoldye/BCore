local vehicles = {}

RegisterServerEvent('events:onSpawn')
AddEventHandler('events:onSpawn', function(source)
	TriggerClientEvent('events:updateConvoysClient', source, vehicles)
end)

RegisterServerEvent('events:updateConvoys')
AddEventHandler('events:updateConvoys', function(v)
	vehicles = v

	local source = tonumber(source)
	TriggerClientEvent('events:updateConvoysClient', source, vehicles)
end)