RegisterServerEvent("clothes:save")
AddEventHandler("clothes:save",function(player_data)
	local source = source
	TriggerEvent('b:getPlayer', source, function(user)
		if (user ~= nil) then
			if (user.SetModel(player_data)) then
				-- saved
			end
		end
	end)
end)

RegisterServerEvent("b:spawned")
AddEventHandler("b:spawned",function()
	local source = source
	TriggerEvent('b:getPlayer', source, function(user)
		if (user ~= nil) then
			local model = user.GetModel()

			TriggerClientEvent('clothes:spawn', source, model)
		end
	end)
end)