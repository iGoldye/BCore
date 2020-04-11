local currentVehicle = nil
local currentVehicleSeats = 0
local currentVehicleSeat = -2
local currentVehicleAvailableSeats = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if (IsPedInAnyVehicle(GetPlayerPed(-1), false)) then
			currentVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			currentVehicleSeats = GetVehicleModelNumberOfSeats(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))) - 2
			currentVehicleAvailableSeats = {}

			for i = -1, currentVehicleSeats do
				if (GetPedInVehicleSeat(currentVehicle, i) == PlayerPedId()) then
					currentVehicleSeat = i
					currentVehicleAvailableSeats[i+2] = true
				elseif (GetPedInVehicleSeat(currentVehicle, i) == 0) then
					currentVehicleAvailableSeats[i+2] = false
				else
					currentVehicleAvailableSeats[i+2] = true
				end
			end

			SendNUIMessage({
    			action = 'updateSeats',
    			seats = currentVehicleAvailableSeats,
    			seat = currentVehicleSeat,
    			hide = false,
  			})
			Citizen.Wait(150)
		else
			currentVehicle = nil
			currentVehicleSeats = 0
			currentVehicleSeat = -2
			currentVehicleAvailableSeats = {}

			SendNUIMessage({
    			action = 'updateSeats',
    			seats = currentVehicleAvailableSeats,
    			seat = 0,
    			hide = true,
  			})
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if (IsPedInAnyVehicle(GetPlayerPed(-1), false)) then
			if (IsControlPressed(1, 60) and IsControlJustPressed(1, 42)) then
				Citizen.CreateThread(function()
					local requestedSeat = currentVehicleSeat

					while not IsVehicleSeatFree(currentVehicle, requestedSeat) do
						requestedSeat = requestedSeat + 1

						if requestedSeat < -1 then requestedSeat = currentVehicleSeats end
						if requestedSeat > currentVehicleSeats then requestedSeat = -1 end

						Citizen.Wait(10)
					end

					SetPedIntoVehicle(GetPlayerPed(-1), currentVehicle, requestedSeat)
					currentVehicleSeat = requestedSeat
					SendNUIMessage({
    					action = 'updateSeats',
    					seats = currentVehicleAvailableSeats,
    					seat = currentVehicleSeat,
    					hide = false,
  					})
				end)

			elseif (IsControlPressed(1, 60) and IsControlJustPressed(1, 43)) then
				Citizen.CreateThread(function()
					local requestedSeat = currentVehicleSeat

					while not IsVehicleSeatFree(currentVehicle, requestedSeat) do
						requestedSeat = requestedSeat - 1

						if requestedSeat < -1 then requestedSeat = currentVehicleSeats end
						if requestedSeat > currentVehicleSeats then requestedSeat = -1 end

						Citizen.Wait(10)
					end

					SetPedIntoVehicle(GetPlayerPed(-1), currentVehicle, requestedSeat)
					currentVehicleSeat = requestedSeat
					SendNUIMessage({
    					action = 'updateSeats',
    					seats = currentVehicleAvailableSeats,
    					seat = currentVehicleSeat,
    					hide = false,
  					})
				end)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
				if GetIsTaskActive(GetPlayerPed(-1), 165) then
					SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
				end
			end
		end
	end
end)