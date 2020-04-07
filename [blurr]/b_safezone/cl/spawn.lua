local traderSpawns = {
	{t="locknkeep", coords={x=0.0, y=0.0, z=0.0, h=0.0}, model=""},
	{t="guard", coords={x=0.0, y=0.0, z=0.0, h=0.0}, model=""},
	{t="guard", coords={x=0.0, y=0.0, z=0.0, h=0.0}, model=""},
}
local traders = {}

RegisterNetEvent('spawn:spawnTraders')
AddEventHandler('spawn:spawnTraders', function()
	traders = {}
	for i,v in pairs(traders) do
		RequestModel(GetHashKey(v.model))
		while (HasModelLoaded(GetHashKey(v.model)) == false) do
    		Citizen.Wait(1)
		end


		local ped = CreatePed(4, GetHashKey(v.model), v.coords.x, v.coords.y, v.coords.z, 0, false, true)
		SetEntityHeading(ped, v.coords.h)
		SetEntityInvincible(ped, true)
		table.insert(traders, {t=v.t, ped=ped})
		TriggerServerEvent('spawn:updateTraders', traders)
	end	
end

RegisterNetEvent('spawn:updateTraders')
AddEventHandler('spawn:updateTraders', function(t)
	traders = t
end)

Citizen.CreateThread(function()
	while (#traders == 0) do
		Citizen.Wait(100)
	end
	
	while true do
		Citizen.Wait(1)

		for i,v in pairs(traders) do
			local plyCoords = GetEntityCoords(GetPlayerPed(-1))
			local traCoords = GetEntityCoords(v.ped)
			local distance = GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, traCoords.x, traCoords.y, traCoords.z, true)

			if (distance <= 3.0) then
				-- We are next to a trader..
			end
		end
	end
end)