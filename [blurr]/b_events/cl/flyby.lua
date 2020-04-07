local ODDS = 0 --1:50

Citizen.CreateThread(function()
	while true do
		if (not IsPedInAnyVehicle(GetPlayerPed(-1), false)) then
			if (math.random(0, 100) < ODDS) then
				InitiateFlyBy(math.random(3, 5))
			end

			Citizen.Wait(60000) 
		end

		Citizen.Wait(0)
	end
end)

local flybyDist = 500
local flybyTime = (35*1000)
local flybyMinZ = 10.0
local flybyMaxZ = 25.0

function InitiateFlyBy(amount)
	local coords = GetEntityCoords(GetPlayerPed(-1))
	local z = coords.z + 35.0
	local startY = coords.y - flybyDist
	local endY = coords.y + (flybyDist * 2)

	Citizen.CreateThread(function()
		for i = 1, amount do
			CallFlyBy(coords.x, startY, endY, z)

			Citizen.Wait(1000)
		end
	end)
end

function CallFlyBy(x, startY, endY, z)
	local pedHash = GetHashKey("a_f_m_salton_01")
	local vehHash = GetHashKey("LAZER")

	RequestModel(pedHash)
	RequestModel(vehHash)

	while not HasModelLoaded(pedHash) do
		RequestModel(pedHash)
		Citizen.Wait(1)
	end
	while not HasModelLoaded(vehHash) do
		RequestModel(vehHash)
		Citizen.Wait(1)
	end

	local veh = CreateVehicle(vehHash, x, startY, z + 30, 0.0, true, true)
	local ped = CreatePedInsideVehicle(veh, 11, pedHash, -1, true, true)
	FreezeEntityPosition(veh, true)
	SetEntityVisible(veh, false, 0)

	--SetEntityAsMissionEntity(veh, true, true)
	SetEntityAsMissionEntity(ped, true, true)

	SetVehicleEngineOn(veh, true, true, true)
	SetVehicleJetEngineOn(veh, true)
	ControlLandingGear(veh, 3)
	SetVehicleCheatPowerIncrease(veh, 1.8)

	SetVehicleCustomPrimaryColour(veh, 11, 92, 31)
	SetVehicleCustomSecondaryColour(veh, 11, 92, 31)

	--SetDriveTaskCruiseSpeed(ped, 100)
	Citizen.Wait(3000)

	FreezeEntityPosition(veh, false)
	TaskVehicleDriveToCoord(ped, veh, x, endY, z, 100.0, 1.0, veh, 16777216, 1.0, true)
	SetEntityVisible(veh, true, 0)
	--TaskVehicleDriveToCoordLongrange(ped, veh, x, y, z - 10.0, 30.0, 16777216, 1.0)

	Citizen.CreateThread(function()
		Citizen.Wait(30000)
		DeleteVehicle(veh)
		DeleteEntity(ped)
	end)
end
