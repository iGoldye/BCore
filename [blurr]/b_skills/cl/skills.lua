skills = {
	{skill="butchering", lvl=0, exp=0},
	{skill="cooking", lvl=0, exp=0},
	{skill="crafting", lvl=0, exp=0},
	{skill="farming", lvl=0, exp=0},
	{skill="firearms", lvl=0, exp=0},
	{skill="fishing", lvl=0, exp=0},
	{skill="looting", lvl=0, exp=0},
	{skill="repair", lvl=0, exp=0},
	{skill="running", lvl=0, exp=0},
}

levels = {}

Citizen.CreateThread(function()
	local total = 0
	for i = 1, 11 do
		total = total + ((i * expPerLevel) + ((i * expPerLevel) * expDiffPerLevel))
		levels[i] = total
	end
end)

RegisterNetEvent('skills:onSpawn')
AddEventHandler('skills:onSpawn', function(s)
	skills = s
end)