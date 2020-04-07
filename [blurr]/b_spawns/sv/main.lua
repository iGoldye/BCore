cars = {}

RegisterServerEvent('spawns:onSpawn')
AddEventHandler('spawns:onSpawn', function(source)
	TriggerClientEvent('spawns:updateCars', source, cars)
end)

RegisterServerEvent('spawns:addCar')
AddEventHandler('spawns:addCar', function(newCar)
	local source = tonumber(source)

	table.insert(cars, newCar)
	TriggerClientEvent('spawns:updateCars', -1, cars)
	CheckSpawnCar()
end)
RegisterServerEvent('spawns:noCar')
AddEventHandler('spawns:noCar', function()
	local source = tonumber(source)
	TriggerClientEvent('spawns:updateCars', -1, cars)
	CheckSpawnCar()
end)

RegisterServerEvent('spawns:removeCar')
AddEventHandler('spawns:removeCar', function(oldCar)
	local source = tonumber(source)

	for i,v in pairs(cars) do
		if (v.plate == oldCar.plate) and (v.key == oldCar.key) then
			table.remove(cars, i)
			TriggerClientEvent('spawns:updateCars', -1, cars)
		end
	end
end)

local lastPlayer = 0
function CheckSpawnCar()
	local spawned = false
	while not spawned do
		TriggerEvent('b:getPlayers', function(Users)
			if (#Users > 0) then
				local nextPlayer = lastPlayer + 1
				if (nextPlayer > #Users) then nextPlayer = 1 end
				if (nextPlayer > 0) then
					local target = Users[nextPlayer].GetSource()
					TriggerClientEvent('spawns:spawnNeeded', target, cars)
					lastPlayer = nextPlayer
					spawned = true
				end
			end
		end)
	end
end

Citizen.CreateThread(function()
	local waiting = true
	while waiting do
		TriggerEvent('b:getPlayers', function(Users)
			if (#Users > 0) then
				waiting = false
			end
		end)
		Citizen.Wait(5000)
	end

	print("Start spawning cars...")
	CheckSpawnCar()
end)