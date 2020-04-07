local currentVehicle = nil
local currentVehicleSeats = 0
local currentVehicleSeat = -2
local currentVehicleAvailableSeats = {}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		if (IsPedInAnyVehicle(GetPlayerPed(-1), false)) then
			currentVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			currentVehicleSeats = GetVehicleModelNumberOfSeats(GetEntityModel(GetVehiclePedIsIn(PlayerPedId()))) - 2

			for i = -1, currentVehicleSeats do
				if (GetPedInVehicleSeat(currentVehicle, i) == PlayerPedId()) then
					currentVehicleSeat = i
					currentVehicleAvailableSeats[i] = true
				elseif (GetPedInVehicleSeat(currentVehicle, i) == 0) then
					currentVehicleAvailableSeats[i] = false
				else
					currentVehicleAvailableSeats[i] = true
				end
			end
		else
			currentVehicle = nil
			currentVehicleSeats = 0
			currentVehicleSeat = -2
			currentVehicleAvailableSeats = {}
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local sizeX = 0.03135
		local spacing = 0.002

		local sizeY = (sizeX * (16/9)) / 10
		local x = (spacing * 2) + (sizeX/2) + sizeX
		local y = ((1.0 - spacing) - sizeY)

		if (IsPedInAnyVehicle(GetPlayerPed(-1), false)) and (currentVehicleSeat ~= -2) then
			for i = -1, currentVehicleSeats do
				if (i == currentVehicleSeat) then
					DrawRect(x + ((sizeX + spacing) * i), y, sizeX, sizeY, 38, 153, 199, 255)
				elseif (currentVehicleAvailableSeats[i] == true) then
					DrawRect(x + ((sizeX + spacing) * i), y, sizeX, sizeY, 135, 14, 14, 255)
				elseif (currentVehicleAvailableSeats[i] == false) then
					DrawRect(x + ((sizeX + spacing) * i), y, sizeX, sizeY, 11, 92, 31, 255)
				end
			end
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