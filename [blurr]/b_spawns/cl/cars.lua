local spawnDistance = 500
cars = {}
keys = {}

RegisterNetEvent('spawns:updateKeys')
AddEventHandler('spawns:updateKeys', function(k)
	keys = k

	if (DEBUG == true) then
		print("keys: "..#keys)
	end
end)

RegisterNetEvent('spawns:updateCars')
AddEventHandler('spawns:updateCars', function(c)
	cars = c

	if (DEBUG == true) then
		print("C: "..#c)
		print("Cars: "..#cars)
	end
end)

RegisterNetEvent('spawns:spawnNeeded')
AddEventHandler('spawns:spawnNeeded', function(c)
	Citizen.CreateThread(function()
		cars = c
		local nearbyCars = CountNearbyVehicles()

		if (DEBUG == true) then
			print("Spawning new vehicle.")
			print("Cars: "..#cars)
			print("NearbyCars: "..nearbyCars)
		end
		
		if #cars < maxOverallCars and nearbyCars < maxNearbyCars then
			repeat
				Wait(1)
				
				local onRoad = false
				local notUnderWater = false
				repeat
					Wait(1)
					repeat
						Wait(1)
						x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

						NewVehicleX = x + math.random((spawnDistance*-1), spawnDistance)
						NewVehicleY = y + math.random((spawnDistance*-1), spawnDistance)
						_,NewVehicleZ = GetGroundZFor_3dCoord(NewVehicleX+.0,NewVehicleY+.0,z+999.0, 1)
					until NewVehicleZ ~= 0

					onRoad = IsPointOnRoad(NewVehicleX, NewVehicleY, NewVehicleZ)
					notUnderWater, _ =  GetWaterHeight(NewVehicleX, NewVehicleY, NewVehicleZ)
				until onRoad and notUnderWater
				canSpawn = true
			until canSpawn
			
			choosenCar = spawnableCars[math.random(1, #spawnableCars)]
			RequestModel(choosenCar)
			while not HasModelLoaded(choosenCar) or not HasCollisionForModelLoaded(choosenCar) do
				Wait(1)
			end
			
			car = CreateVehicle(choosenCar, NewVehicleX, NewVehicleY, NewVehicleZ, math.random(), true, true)
			SetVehicleEngineHealth(car, math.random(0,800)+0.0)

			local poppedTyres = math.random(0, 100)

			if (poppedTyres < 25) then
				if (poppedTyres < 10) then
					SetVehicleTyreBurst(car, 0, true, math.random(0, 1000))
					SetVehicleTyreBurst(car, 1, true, math.random(0, 1000))
					SetVehicleTyreBurst(car, 4, true, math.random(0, 1000))
					SetVehicleTyreBurst(car, 5, true, math.random(0, 1000))
				else
					SetVehicleTyreBurst(car, math.random(0, 1), true, math.random(0, 1000))
					SetVehicleTyreBurst(car, math.random(4, 5), true, math.random(0, 1000))
				end
			end

			PlaceObjectOnGroundProperly(car)
			if not NetworkGetEntityIsNetworked(car) then
				NetworkRegisterEntityAsNetworked(car)
			end

			local p = GetVehicleNumberPlateText(car)

			local newCar = {vehicle=car, key=math.random(1000, 9999), plate=p, inventory={}}
			TriggerServerEvent('spawns:addCar', newCar)
			
			if (DEBUG == true) then
				print("Spawned new vehicle.")
			end
		else
			if (DEBUG == true) then
				print("No need to spawn new vehicle.")
			end
			TriggerServerEvent('spawns:noCar')
		end
		
		for i, car in pairs(cars) do
			--[[if not DoesEntityExist(car.vehicle) or GetEntityHealth(car.vehicle) == 0 then
				SetEntityAsNoLongerNeeded(car.vehicle)
				TriggerServerEvent('spawns:removeCar', car)

				if (DEBUG == true) then
					print("Removed old vehicle.")
				end
			end]]
		end
	end)
end)

function CountNearbyVehicles()
	local vehicles = EnumerateVehicles()
	local playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
	local nearbyCars = 0

	for vehicle in vehicles do
		local carX, carY, carZ = table.unpack(GetEntityCoords(vehicle, false))
		local distance = GetDistanceBetweenCoords(playerX, playerY, playerZ, carX, carY, carZ, false)

		if (distance <= (spawnDistance + (spawnDistance / 2))) then
			nearbyCars = nearbyCars + 1
		end
	end

	return nearbyCars
end

function WipeAllVehicles()
	local vehicles = EnumerateVehicles()

	for vehicle in vehicles do
		if (vehicle ~= nil) then
	  		SetEntityAsMissionEntity(vehicle, true, true)
	  		DeleteVehicle(vehicle)
	  	end
	end
end

-- [[ DEBUG ]] --

Citizen.CreateThread(function()
	--WipeAllVehicles()
	--TriggerEvent('spawns:spawnNeeded', {})

	while true do
		Citizen.Wait(0)
		if (CAR_DEBUG) then
			for i, car in pairs(cars) do
				if (car ~= nil) then
					playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
					carX, carY, carZ = table.unpack(GetEntityCoords(car.vehicle, false))
					local distance = GetDistanceBetweenCoords(playerX, playerY, playerZ, carX, carY, carZ, false)

					DrawLine(playerX,playerY, playerZ, carX, carY, carZ, 255.0,0.0,0.0,255.0)
					DrawText3D(carX, carY, carZ, "Vehicle ("..distance..")")
				end
			end
		end
	end
end)

function GetVehicleInDirection(coordFrom, coordTo)
    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.34, 0.34)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end