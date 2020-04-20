RegisterServerEvent('skills:onSpawn')
AddEventHandler('skills:onSpawn', function(source)
	TriggerEvent('b:getPlayer', source, function(user)
		if (user ~= nil) then
			local skills = user.GetSkills()
			local weight = user.GetItemsWeight()
			TriggerClientEvent('skills:onSpawn', source, skills, weight)
		end
	end)
end)

RegisterServerEvent('skills:update')
AddEventHandler('skills:update', function(skills)
	TriggerEvent('b:getPlayer', source, function(user)
		if (user ~= nil) then
			user.SetSkills(skills)
			
			local weight = user.GetItemsWeight()
			TriggerClientEvent('skills:onSpawn', source, skills, weight)
		end
	end)
end)