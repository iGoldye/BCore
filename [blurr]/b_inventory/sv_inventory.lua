RegisterServerEvent('inv:update')
AddEventHandler('inv:update', function()
	TriggerEvent('b:getPlayer', source, function(user)
		if (user ~= nil) then
			local inventory = user.GetItemInventory()
			TriggerClientEvent('inv:open', source, inventory)
		end
	end)
end)

RegisterServerEvent('inv:giveItemById')
AddEventHandler('inv:giveItemById', function(player, itemId, qty)
	TriggerEvent('b:getPlayer', tonumber(player), function(user)
		if (user ~= nil) then
			local inventory = user.GetItemInventory()

			-- If is melee, we only need one of them
			if (itemId >= 40 and itemId < 50) then
				if (user.HasItem(itemId) < 1) then
					if (user.GiveItem(itemId, 1)) then
						print("Item given.")
					else
						print("Item not given...")
					end
				end
			else
				if (user.GiveItem(itemId, qty)) then
					print("Item given.")
				else
					print("Item not given...")
				end
			end
		end
	end)
end)

RegisterServerEvent('inv:removeItem')
AddEventHandler('inv:removeItem', function(itemId, qty)
	TriggerEvent('b:getPlayer', tonumber(source), function(user)
		if (user ~= nil) then
			if (user.HasItem(itemId) >= qty) then
				if (user.RemoveItem(itemId, qty)) then
					print("Item removed!")
				end
			end
		end
	end)
end)

local DroppedItems = {}
RegisterServerEvent('inv:dropItem')
AddEventHandler('inv:dropItem', function(itemName, itemUse, itemId, qty, coords)
	TriggerEvent('b:getPlayer', tonumber(source), function(user)
		if (user ~= nil) then
			if (user.HasItem(itemId) >= qty) then
				local item = user.GetItem(itemId)
					if (item ~= nil) then
					local objectName = item.prop
					if (item.prop == nil) then objectName = "hei_prop_heist_cash_bag_01" end

					if (user.RemoveItem(itemId, qty)) then
						local item = {n=itemName, id=itemId, count=qty, location=coords, object=nil}
						TriggerClientEvent('inv:placeDroppedItem', source, coords, 30, item, objectName)
					end
				end
			end
		end
	end)
end)

RegisterServerEvent('inv:broadcastItem')
AddEventHandler('inv:broadcastItem', function(item)
	table.insert(DroppedItems, item)
	TriggerClientEvent('inv:syncDroppedItems', -1, DroppedItems)
end)

RegisterServerEvent('inv:pickupItem')
AddEventHandler('inv:pickupItem', function(item)
	TriggerEvent('b:getPlayer', tonumber(source), function(user)
		if (user ~= nil) then
			local inventory = user.GetItemInventory()
			local pickup = false

			for i,v in pairs(DroppedItems) do
				if (v.id == item.id and v.location == item.location) then
					if (user.GiveItem(v.id, v.count)) then
						TriggerClientEvent('inv:removeDroppedItem', source, v, inventory)

						table.remove(DroppedItems, i)
						TriggerClientEvent('inv:syncDroppedItems', -1, DroppedItems)
					end
				end
			end
		end
	end)
end)

