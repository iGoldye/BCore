RegisterServerEvent("b:beginPlay")
AddEventHandler("b:beginPlay",function()
	local source = tonumber(source)

	TriggerEvent('b:getPlayer', source, function(user)
		if (user ~= nil) then
			TriggerEvent('spawns:onSpawn', source) -- Update all vehicles for client on join
			TriggerEvent('events:onSpawn', source) -- Update all events for client on join
			TriggerClientEvent('hud:updateHunger', source, 100, 100)
		end
	end)
end)

-----------------------------------------------------

Users = {}
Players = {}

RegisterServerEvent('b:firstJoin')
RegisterServerEvent('b:spawn')

AddEventHandler('b:firstJoin', function()
	local id = tonumber(source)
	local identifiers = {name=GetPlayerName(id), discord=tonumber(GetID("discord", id)), ip=GetID("ip", id), license=GetID("license", id), steam=GetID("steam", id)}

	if (identifiers.discord) then
		local user = loadUser(identifiers.discord)
		if (user ~= nil) then
    		print("[B-Core] "..GetPlayerName(id).." is an existing user.")
			user["identifiers"] = identifiers
			user["info"].newUser = false
			user["info"].online = true
			user["info"].isChanged = false
        	saveUser(identifiers.discord, user)
    	else
    		print("[B-Core] "..GetPlayerName(id).." is a new user.")
        	user = DEFAULT_USER;
        	user["identifiers"] = identifiers
        	saveUser(identifiers.discord, user)
    	end

    	Users[id] = CreateUser(id, user)
		Players[id] = user["identifiers"]

		TriggerEvent('b:loaded', source, Users[source])

		Citizen.Wait(2000) -- Make sure everything is ready in time
		TriggerClientEvent('b:ready', id)
		TriggerClientEvent('b:pvp', id)

		if (IsGroup(user["info"].group, "mod")) then
			TriggerClientEvent('b:isAdmin', id)
			print("An admin has joined the server!")
		end

		local playerList = {}
		for index,_ in pairs(Users) do
			if (Users[index] ~= nil) then
				local d = Users[index].GetIdentifiers()
				table.insert(playerList, {source=index, identifiers=d})
			end
		end
		TriggerClientEvent('b:updatePlayerList', -1, playerList)
	else
		DropPlayer(id, "Reason: Your player data failed to load (Discord ID).")
	end
end)

AddEventHandler('playerDropped', function(reason)
	local source = tonumber(source)
	local discord = tonumber(GetID("discord", source))

	print("[B-Core] User "..GetPlayerName(source).." is disconnecting...")
	if(Users[source]) or Users[source] ~= nil then
		if (Users[source].HasUserChanged()) then 

			Users[source].UpdateCoords()
			Users[source].SetUserChanged()

			local user = Users[source]
			local sUser = {
				["identifiers"] = user.GetIdentifiers(),
				["info"] = user.GetInfo(),
				["selectedCharacter"] = user.GetSelectedCharacter(),
				["characters"] = user.GetCharacters(),
			}
			sUser["info"].newUser = false
			sUser["info"].online = false
			saveUser(discord, sUser)
			print("[B-Core] User "..GetPlayerName(source).." has been saved. Disconnected: "..reason)
		else
			print("[B-Core] User "..GetPlayerName(source).." disconnected: "..reason)
		end
	end

	Users[source] = nil

	local playerList = {}
	for index,_ in pairs(Users) do
		if (Users[index] ~= nil) then
			local d = Users[index].GetIdentifiers()
			table.insert(playerList, {source=index, identifiers=d})
		end
	end
	TriggerClientEvent('b:updatePlayerList', -1, playerList)
end)

function SaveAll()
	SetTimeout(60000, function()
		for i,v in pairs(Users) do
			if (Users[i] ~= nil) then
				if (v.HasUserChanged() == true) then
					v.UpdateCoords()
					v.SetUserChanged()

					local sUser = {
						["identifiers"] = v.GetIdentifiers(),	
						["info"] = v.GetInfo(),
						["selectedCharacter"] = v.GetSelectedCharacter(),
						["characters"] = v.GetCharacters(),
					}

					saveUser(sUser.identifiers.discord, sUser)
				end
			end
		end
		SaveAll()
	end)
end
SaveAll()

AddEventHandler('b:getPlayers', function(cb)
    cb(Users)
end)

AddEventHandler('b:getDirectory', function(t, cb)
	if (t == "bans") then
		cb(bansDir)
    elseif (t == "users") then
    	cb(usersDir)
    elseif (t == "groups") then
    	cb(groupsDir)
    else
    	cb(mainDir)
    end
end)

AddEventHandler("b:getPlayer", function(source, cb)
    if(Users)then
        if(Users[source] ~= nil)then
            cb(Users[source])
        else
            cb(nil)
        end
    else
        cb(nil)
    end
end)

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