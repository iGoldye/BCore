RegisterServerEvent('craft:update')
AddEventHandler('craft:update', function()
	TriggerEvent('b:getPlayer', source, function(user)
		if (user ~= nil) then
			local inventory = user.GetItemInventory()
			local weight = user.GetItemsWeight()
			local count = user.GetItemsCount()

			TriggerClientEvent('craft:open', source, inventory, weight, count)
		end
	end)
end)