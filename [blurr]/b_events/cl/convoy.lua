local vehicles = {}

local spawns = {
	{model="Crusader", x=-1546.32, y=2749.29, z=17.29, h=226.0, seats={0, 1, 2}},
	{model="Barracks3", x=-1554.480, y=2755.81, z=17.39, h=226.0, seats={0, 1, 2, 3, 5, 6, 7}},
	{model="Barracks3", x=-1562.75, y=2763.12, z=17.15, h=226.0, seats={0, 1, 2, 3, 6, 8}},
	{model="Halftrack", x=-1569.17, y=2769.94, z=16.93, h=226.0, seats={1}},
}
local dest = {x=486.417, y=-3339.692, z=6.070}

RegisterNetEvent('events:updateConvoysClient')
AddEventHandler('events:updateConvoysClient', function(vehs)
	vehicles = vehs
end)

RegisterNetEvent('events:beginConvoy')
AddEventHandler('events:beginConvoy', function()
	-- reset all vars
	vehicles = {}

	-- spawn vehicles and peds
	for i,v in pairs(spawns) do
		-- spawn vehicle
		local hash = GetHashKey(v.model)
		RequestModel(hash)
		while not HasModelLoaded(hash) do
			RequestModel(hash)
			Citizen.Wait(1)
		end

		local veh = CreateVehicle(hash, v.x, v.y, v.z, v.h, true, true)
		FreezeEntityPosition(veh, true)
		SetEntityVisible(veh, false, 0)

		-- spawn ped
		local model = "csb_mweather"
		hash = GetHashKey(model)
		RequestModel(hash)
		while not HasModelLoaded(hash) do
			RequestModel(hash)
			Citizen.Wait(1)
		end

		local ped = CreatePedInsideVehicle(veh, 11, hash, -1, true, true)
		SetEntityAsMissionEntity(ped, true, true)

		local gunners = {}
		for i,seat in pairs(v.seats) do
			local gunner = CreatePedInsideVehicle(veh, 11, hash, seat, true, true)
			SetEntityAsMissionEntity(ped, true, true)
			table.insert(gunners, gunner)
		end

		local vehicle = {v=veh, p=ped, g=gunners}
		table.insert(vehicles, vehicle)
	end

	-- task to follow route to destination
	for i,veh in pairs(vehicles) do
		if (i == 1) then
			FreezeEntityPosition(veh.v, false)
			TaskVehicleDriveToCoordLongrange(veh.p, veh.v, dest.x, dest.y, dest.z, 30.0, 2883621, 1.0)
			SetEntityVisible(veh.v, true, 0)
		else
			FreezeEntityPosition(veh.v, false)
			--TaskVehicleFollow(veh.p, veh.v, vehicles[i-1].v, 100.0, 2883621, 1.0)
			TaskVehicleEscort(veh.p, veh.v, vehicles[i-1].v, -1, 30.0, 2883621, 1.0, 1, 10.0)
			SetEntityVisible(veh.v, true, 0)
		end
	end

	TriggerServerEvent('events:updateConvoys', vehicles)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		-- check if reached destination
		for i,veh in pairs(vehicles) do
			local coords = GetEntityCoords(veh.p)
			local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, dest.x, dest.y, dest.z, true)

			-- Have they reached their destination or died?
			if (distance < 50) then
				-- ped exit vehicle, wander and remove when fit
				TaskLeaveVehicle(veh.p, veh.v, 0)
				Citizen.Wait(200)
				TaskWanderStandard(veh.p, 10.0, 10)
				RemovePedElegantly(veh.p)

				for i,g in pairs(veh.g) do
					TaskLeaveVehicle(g, veh.v, 0)
					Citizen.Wait(200)
					TaskWanderStandard(g, 10.0, 10)
					RemovePedElegantly(g)
				end

				-- mark vehicle as no longer needed
				SetVehicleAsNoLongerNeeded(veh.v)
			end

			-- check if died

		end
	end
end)