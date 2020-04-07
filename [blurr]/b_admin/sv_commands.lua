AddEventHandler('chatMessage', function(source, name, message)
	local args = stringSplit(message, " ")

	if (stringStartsWith(args[1], "/")) then
		TriggerEvent('b:getPlayer', source, function(user)
			if (user ~= nil) then
				local group = user.GetGroup()
				local command = string.lower(args[1])

				if (command == "/kick") then 
					CancelEvent()
					KickCommand(source, group, args)
				elseif (command == "/ban") then 
					CancelEvent()
					BanCommand(source, group, args)
				elseif (command == "/coords") then 
					CancelEvent()
					CoordsCommand(source, group, args)
				elseif (command == "/respawn") then 
					CancelEvent()
					RespawnCommand(source, group, args)
				elseif (command == "/revive") then 
					CancelEvent()
					ReviveCommand(source, group, args)
				elseif (command == "/spawn") then 
					CancelEvent()
					SpawnCommand(source, group, args)
				elseif (command == "/noclip") then 
					CancelEvent()
					NoClipCommand(source, group)
				elseif (command == "/goto") then 
					CancelEvent()
					GotoCommand(source, group, args)
				elseif (command == "/bring") then 
					CancelEvent()
					BringCommand(source, group, args)
				elseif (command == "/tp") then 
					CancelEvent()
					TeleportCommand(source, group, args)
				elseif (command == "/dv") then 
					CancelEvent()
					DeleteVehicleCommand(source, group, args)
				elseif (command == "/give") then 
					CancelEvent()
					GiveCommand(source, group, args)

				-- User Commands
				elseif (command == "/hidehud") then 
					CancelEvent()
					TriggerClientEvent('hud:toggle', source)
				end
			end
		end)
	end
end)