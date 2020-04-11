RegisterServerEvent('craft:update')
AddEventHandler('craft:update', function()
	TriggerEvent('b:getPlayer', source, function(user)
		if (user ~= nil) then
			local inventory = user.GetItemInventory()
			TriggerClientEvent('craft:open', source, inventory)
		end
	end)
end)