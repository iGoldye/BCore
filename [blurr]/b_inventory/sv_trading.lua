RegisterServerEvent('trade:requestTrade')
AddEventHandler('trade:requestTrade', function(target)
	TriggerEvent('b:getPlayer', source, function(user)
		if (user ~= nil) then
			local inventory = user.GetItemInventory()
			local weight = user.GetItemsWeight()
			local count = user.GetItemsCount()
			local name = user.GetCharacterName()
			
			TriggerEvent('b:getPlayer', target, function(otherUser)
				if (otherUser ~= nil) then
					local otherInventory = otherUser.GetItemInventory()
					local otherWeight = otherUser.GetItemsWeight()
					local otherCount = otherUser.GetItemsCount()
					local otherName = otherUser.GetCharacterName()

					TriggerClientEvent('trade:open', source, inventory, weight, count, otherInventory, otherName)
					TriggerClientEvent('trade:open', target, otherInventory, otherWeight, otherCount, inventory, name)
				else
					TriggerClientEvent('trade:fail', source)
				end
			end)
		else
			TriggerClientEvent('trade:fail', source)
		end
	end)
end)

RegisterServerEvent('trade:update')
AddEventHandler('trade:update', function(target, cancel, accept, itemToAdd)
	TriggerClientEvent('trade:update', target, cancel, accept, itemToAdd)
end)