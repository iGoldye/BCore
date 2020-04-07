RegisterServerEvent("b:getCharacterData")
AddEventHandler("b:getCharacterData",function()
	local source = tonumber(source)
	TriggerEvent('b:getPlayer', source, function(user)
		if (user ~= nil) then
			local characters = user.GetCharacters()

			if (#characters <= 0) then
				TriggerClientEvent('b:createCharacterUi', source, characters)
			else
				TriggerClientEvent('b:selectCharacterUi', source, characters)
			end
		else
			DropPlayer(source, "Your character data could not be loaded. [610]")
		end
	end)
end)

RegisterServerEvent('b:createCharacter')
AddEventHandler('b:createCharacter', function(name, dob, gender)
	local source = tonumber(source)
	
	TriggerEvent('b:getPlayer', source, function(user)
		if (user ~= nil) then
			if (user.AddCharacter(name, dob, gender)) then
				local coords = user.GetCoords()
				local model = user.GetModel()
				TriggerClientEvent('b:unfreeze', source, coords, model)
			else
				DropPlayer(source, "Your character could not be created... [620]")
			end
		else
			DropPlayer(source, "Your character data could not be loaded. [611]")
		end
	end)
end)


RegisterServerEvent("b:selectCharacter")
AddEventHandler("b:selectCharacter",function(characterId)
	local source = tonumber(source)

	TriggerEvent('b:getPlayer', source, function(user)
		if (user ~= nil) then
			if (user.ChangeCharacter(characterId)) then
				local coords = user.GetCoords()
				local model = user.GetModel()
				TriggerClientEvent('b:unfreeze', source, coords, model)
			else
				DropPlayer(source, "Your character data could not be loaded. [613]")
			end
		else
			DropPlayer(source, "Your character data could not be loaded. [612]")
		end
	end)
end)

RegisterServerEvent("b:updateLastCoords")
AddEventHandler("b:updateLastCoords",function(x, y, z, h)
	local source = tonumber(source)

	TriggerEvent('b:getPlayer', source, function(user)
		if (user ~= nil) then
			if (user.UpdateLastCoords(x, y, z, h)) then
			end
		end
	end)
end)