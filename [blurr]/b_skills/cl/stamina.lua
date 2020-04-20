local minSpeed = 3.0
local maxSpeed = 7.0

Citizen.CreateThread(function()
	while true do
		if (weight >= weightBeforeAffected) then
			local speedLossPerPound = (maxSpeed - minSpeed) / (maxWeight - weightBeforeAffected)
			local speedLoss = (weight - weightBeforeAffected) * speedLossPerPound
			local myRunSpeed = maxSpeed - speedLoss
			SetEntityMaxSpeed(GetPlayerPed(-1), myRunSpeed)
		else
			SetEntityMaxSpeed(GetPlayerPed(-1), 10.0)
		end
		Citizen.Wait(1000)
	end
end)

local hasRan = false
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)

		local regen = 0.003

		if (staminaMultipliers[skills[9].lvl + 1] ~= nil) then
			regen = regen * staminaMultipliers[skills[9].lvl + 1]
		else
			regen = regen * staminaMultipliers[1]
		end

		if IsPedSprinting(GetPlayerPed(-1)) == false then
			if IsPedWalking(GetPlayerPed(-1)) == false then
				RestorePlayerStamina(PlayerId(),regen)
			else
				RestorePlayerStamina(PlayerId(),regen/2)
			end
		else
			hasRan = true
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15000)

		-- Level shooting
		if (hasRan == false) and (skills[9].lvl > 0) then
			skills[9].exp = skills[9].exp - staminaDrain
		elseif (hasRan == true) then
			skills[9].exp = skills[9].exp + staminaGain
		end
		hasRan = false

		oldLvl = skills[9].lvl
		level = 0
		for j,_ in pairs(levels) do
			if (skills[9].exp > levels[j]) then 
				level = j
			end
		end
		skills[9].lvl = level
		if (oldLvl ~= level) then 
			TriggerEvent('pNotify:SendNotification', {text = "Stamina - Level "..level,type = "success",timeout = 2000,layout = "centerLeft",queue = "left"})
		end

		-- Update server
		TriggerServerEvent('skills:update', skills)
	end
end)
