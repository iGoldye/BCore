Citizen.CreateThread(function()
    while true do
        SetVehicleDensityMultiplierThisFrame(0.0)
		SetPedDensityMultiplierThisFrame(0.0)
		SetRandomVehicleDensityMultiplierThisFrame(0.0)
		SetParkedVehicleDensityMultiplierThisFrame(0.0)
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
		SetGarbageTrucks(0)
        SetRandomBoats(0)
        SetIgnoreLowPriorityShockingEvents(PlayerPedId(), true)
        SetPoliceIgnorePlayer(PlayerPedId(), true)
        SetDispatchCopsForPlayer(PlayerPedId(), false)
        SetMaxWantedLevel(0)
        SetPlayerWantedLevel(PlayerPedId(), 0, false)
        SetPlayerWantedLevelNow(PlayerPedId(), false)
        RemovePeskyVehicles(PlayerPedId(), 5000.0)

        Citizen.Wait(1)
	end
end)

function RemovePeskyVehicles(player, range)
    local pos = GetEntityCoords(GetPlayerPed(-1)) 

    RemoveVehiclesFromGeneratorsInArea(
        pos.x - range, pos.y - range, pos.z - range, 
        pos.x + range, pos.y + range, pos.z + range
    );
end