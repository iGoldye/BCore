local levelCount = 10
local expPerLevel = 200
local expDiffPerLevel = 0.3

skills = {
	{skill="butchering", lvl=0, exp=0},
	{skill="cooking", lvl=0, exp=0},
	{skill="crafting", lvl=0, exp=0},
	{skill="farming", lvl=0, exp=0},
	{skill="firearms", lvl=0, exp=0},
	{skill="fishing", lvl=0, exp=0},
	{skill="looting", lvl=0, exp=0},
	{skill="repair", lvl=0, exp=0},
}

local levels = {}

Citizen.CreateThread(function()
	local total = 0
	for i = 1, 10 do
		total = total + ((i * expPerLevel) + ((i * expPerLevel) * expDiffPerLevel))
		levels[i] = total
	end
end)

RegisterNetEvent('skills:onSpawn')
AddEventHandler('skills:onSpawn', function(s)
	skills = s
end)

-- Leveling up
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		-- Level shooting
		if (IsPedShooting(GetPlayerPed(-1))) then
			--skills[5].exp = skills[5].exp + 2.5
			skills[5].exp = skills[5].exp + 100

			level = 0
			for j,_ in pairs(levels) do
				if (skills[5].exp > levels[j]) then 
					level = j
				end
			end
			skills[5].lvl = level
		end
	end
end)

-- Leveling down
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15000)

		-- Level shooting
		if (IsPedShooting(GetPlayerPed(-1))) then
			skills[5].exp = skills[5].exp - 0.5

			level = 0
			for j,_ in pairs(levels) do
				if (skills[5].exp > levels[j]) then 
					level = j
				end
			end
			skills[5].lvl = level
		end

		-- Update server
		print("Firearms: "..skills[5].lvl)
		TriggerServerEvent('skills:update', skills)
	end
end)