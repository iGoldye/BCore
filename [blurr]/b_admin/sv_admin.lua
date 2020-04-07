admins = {}

RegisterServerEvent('admin:teleport')

local errors = {
	[1] = "Not yet implemented.",
	[2] = "You do not have permission to use this command.",
	[3] = "Wrong use of command.",
	[4] = "Could not find player with that id.",
	[5] = "Could not find an item with that id.",
	[6] = "Must enter an amount above 0.",
}

local successes = {
	[1] = "You successfully kicked the player.",
	[2] = "You successfully banned the player.",
	[3] = "You successfully toggled coords.",
	[4] = "You successfully respawned/revived player.",
	[5] = "You successfully spawned a vehicle.",
	[6] = "You successfully teleported to a player.",
	[7] = "You successfully teleported a player to you.",
	[8] = "You successfully teleported to the coords.",
	[9] = "You successfully deleted a vehicle.",
	[10] = "You successfully spawned a weapon.",
	[11] = "You successfully toggled noclip.",
	[12] = "You successfully gave an item.",
}

function KickCommand(source, group, arguments)
	local target = tonumber(arguments[2])
	local reason = "Reason: "..stringJoin(arguments, 3)

	if (IsGroup(group, "mod")) then
		if (#arguments >= 3) then
			if (GetPlayerName(target)) then
				DropPlayer(target, reason)
				SuccessMessage(source, 1)
			else
				ErrorMessage(source, 4)
			end
		else
			ErrorMessage(source, 3)
		end
	else
		ErrorMessage(source, 2)
	end
end

function BanCommand(source, group, arguments)
	local target = tonumber(arguments[2])
	local reason = "Reason: "..stringJoin(arguments, 3)

	if (IsGroup(group, "admin")) then
		if (#arguments >= 3) then
			if (GetPlayerName(target)) then
				ErrorMessage(source, 1)
			else
				ErrorMessage(source, 4)
			end
		else
			ErrorMessage(source, 3)
		end
	else
		ErrorMessage(source, 2)
	end
end

function CoordsCommand(source, group, arguments)
	if (IsGroup(group, "mod")) then
		SuccessMessage(source, 3)
		TriggerClientEvent('admin:toggleCoords', source)
	else
		ErrorMessage(source, 2)
	end
end

function RespawnCommand(source, group, arguments)
	if (IsGroup(group, "admin")) then
		if (#arguments >= 2) then
			if (GetPlayerName(tonumber(arguments[2]))) then
				SuccessMessage(source, 4)
				TriggerClientEvent('admin:respawn', tonumber(arguments[2]))
			else
				SuccessMessage(source, 4)
				TriggerClientEvent('admin:respawn', tonumber(source))
			end
		else
			SuccessMessage(source, 4)
			TriggerClientEvent('admin:respawn', tonumber(source))
		end
	else
		ErrorMessage(source, 2)
	end
end

function ReviveCommand(source, group, arguments)
	if (IsGroup(group, "admin")) then
		if (#arguments >= 2) then
			if (GetPlayerName(tonumber(arguments[2]))) then
				SuccessMessage(source, 4)
				TriggerClientEvent('admin:revive', tonumber(arguments[2]))
			else
				SuccessMessage(source, 4)
				TriggerClientEvent('admin:revive', tonumber(source))
			end
		else
			SuccessMessage(source, 4)
			TriggerClientEvent('admin:revive', tonumber(source))
		end
	else
		ErrorMessage(source, 2)
	end
end

function SpawnCommand(source, group, arguments)
	if (IsGroup(group, "owner")) then
		if (#arguments >= 2) then
			local r = 255
			local g = 179
			local b = 195
			if (tonumber(arguments[3])) then r = tonumber(arguments[3]) end
			if (tonumber(arguments[4])) then g = tonumber(arguments[4]) end
			if (tonumber(arguments[5])) then b = tonumber(arguments[5]) end

			SuccessMessage(source, 5)
			TriggerClientEvent('admin:spawnVehicle', source, arguments[2], r, g, b)
		else
			ErrorMessage(source, 3)
		end
	else
		ErrorMessage(source, 2)
	end
end

function NoClipCommand(source, group)
	if (IsGroup(group, "owner")) then
		TriggerClientEvent('admin:noclip', source)
		SuccessMessage(source, 11)
	else
		ErrorMessage(source, 2)
	end
end

function GotoCommand(source, group, arguments)
	if (IsGroup(group, "admin")) then
		if (#arguments >= 2) then
			if (GetPlayerName(tonumber(arguments[2]))) then
				TriggerClientEvent('admin:teleportToMe', tonumber(arguments[2]), source)
				SuccessMessage(source, 6)
			else
				ErrorMessage(source, 4)
			end
		else
			ErrorMessage(source, 3)
		end
	else
		ErrorMessage(source, 2)
	end
end

function BringCommand(source, group, arguments)
	if (IsGroup(group, "admin")) then
		if (#arguments >= 2) then
			if (GetPlayerName(tonumber(arguments[2]))) then
				TriggerClientEvent('admin:teleportToMe', source, tonumber(arguments[2]))
				SuccessMessage(source, 7)
			else
				ErrorMessage(source, 4)
			end
		else
			ErrorMessage(source, 3)
		end
	else
		ErrorMessage(source, 2)
	end
end

function TeleportCommand(source, group, arguments)
	if (IsGroup(group, "owner")) then
		if (#arguments >= 4) then
			TriggerClientEvent('admin:teleportMe', source, {x=tonumber(arguments[2] + 0.0), y=tonumber(arguments[3] + 0.0), z=tonumber(arguments[4] + 0.0)})
			SuccessMessage(source, 8)
		else
			ErrorMessage(source, 3)
		end
	else
		ErrorMessage(source, 2)
	end
end

function DeleteVehicleCommand(source, group, arguments)
	if (IsGroup(group, "mod")) then
		TriggerClientEvent('admin:deleteVehicle', source)
		--SuccessMessage(source, 9)
	else
		ErrorMessage(source, 2)
	end
end

function GiveCommand(source, group, arguments)
	if (IsGroup(group, "admin")) then
		if (#arguments >= 4) then
			if (GetPlayerName(tonumber(arguments[2]))) then
				local itemId = tonumber(arguments[3])
				if (itemId) then
					local itemAmount = tonumber(arguments[4])
					if (itemAmount > 0) then
						TriggerEvent('inv:giveItemById', tonumber(arguments[2]), itemId, itemAmount)
						SuccessMessage(source, 12)
					else
						ErrorMessage(source, 6)
					end
				else
					ErrorMessage(source, 5)
				end
			else
				ErrorMessage(source, 4)
			end
		else
			ErrorMessage(source, 3)
		end
	else
		ErrorMessage(source, 2)
	end
end

function ErrorMessage(source, id)
	--TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, errors[id])
	TriggerClientEvent('pNotify:SendNotification', source, {text = errors[id],type = "error",timeout = 2000,layout = "centerLeft",queue = "left"})
end

function SuccessMessage(source, id)
	--TriggerClientEvent('chatMessage', Source, 'SYSTEM', {255, 0, 0}, successes[id])
	TriggerClientEvent('pNotify:SendNotification', source, {text = successes[id],type = "error",timeout = 2000,layout = "centerLeft",queue = "left"})
end

function IsGroup(playerGroup, requiredGroup)
	local group = string.lower(playerGroup)
	local rGroup = string.lower(requiredGroup)

	if (rGroup == "user") then return true end
	local power = 0
	local canDo = false

	if (group == "mod") then power = 1
	elseif (group == "admin") then power = 2
	elseif (group == "owner") then power = 3
	elseif (group == "developer") then power = 4
	end

	if (rGroup == "mod") then 
		if (power >= 1) then 
			canDo = true 
		end
	elseif (rGroup == "admin") then 
		if (power >= 2) then 
			canDo = true 
		end
	elseif (rGroup == "owner") then 
		if (power >= 3) then 
			canDo = true 
		end
	elseif (rGroup == "developer") then 
		if (power >= 4) then 
			canDo = true 
		end
	else
		print("The group "..rGroup.." was not found...")
		canDo = false
	end
	return canDo
end

function PromoteToAdmin(source, group)
	TriggerEvent('b:getPlayer', source, function(user)
		if (user ~= nil) then
			if (string.lower(group) == "user" or string.lower(group) == "mod" or string.lower(group) == "admin" or string.lower(group) == "owner" or string.lower(group) == "developer") then
				if (user.SetGroup(group)) then
					RconPrint(GetPlayerName(tonumber(source)).." set to "..group.." successfully.")
				end
			end
		end
	end)
end

AddEventHandler('admin:teleport', function(coords, id)
	TriggerClientEvent('admin:teleportMe', id, coords)
end)

AddEventHandler('rconCommand', function(commandName, args)
	if commandName:lower() == 'setgroup' then
        if #args < 2 then
        	RconPrint("Not enough arguments.")
            RconPrint("Usage: setgroup [id] [group]\n")
            CancelEvent()
            return
        end
        if GetPlayerName(tonumber(args[1])) == nil then
        	RconPrint("User not found.")
        	RconPrint("Usage: setgroup [id] [group]\n")
            CancelEvent()
            return
        end

        PromoteToAdmin(tonumber(args[1]), args[2])

        CancelEvent()
    end
end)