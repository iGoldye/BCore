RegisterNUICallback('requestTrading', function()
	SetNuiFocus(false, false)
	inv_ui = false
	TriggerEvent('hud:hide', false)

	ResetTradeVars()

	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		otherId = GetPlayerServerId(t)
		TriggerServerEvent("trade:requestTrade", otherId)
	else
		print("Oopsie, I made a poopsie.")
	end
end)

RegisterNetEvent('trade:fail')
AddEventHandler('trade:fail', function()
	print("Oopsie, I made a poopsie.")
end)

RegisterNetEvent('trade:open')
AddEventHandler('trade:open', function(inventory, weight, count, otherInventory, name)
	inv = inventory
	invWeight = weight
	invCount = count

	otherInv = otherInventory
	tradeName = name

	SendNUIMessage({
    	action = 'open_trading',
    	items = inv,
    	otherInv = otherInv,
    	tradeName = tradeName,
    	itemsW = invWeight,
    	itemsC = invCount,
  	})

	TriggerEvent('hud:hide', true)
	trade_ui = true
  	SetNuiFocus(true, true)
end)

RegisterNUICallback('updateTrading', function(data)
	TriggerServerEvent('trade:update', otherId, data.cancel, data.accept, data.offeredItem)

	SetNuiFocus(false, false)
	trade_ui = false
	ResetTradeVars()
end)

RegisterNetEvent('trade:update')
AddEventHandler('trade:update', function(cancel, accept, itemToAdd)
	if cancel then
		SendNUIMessage({
    		action = 'cancel_trading',
  		})
	elseif accept then
		SendNUIMessage({
    		action = 'accept_trading',
  		})
	else
		SendNUIMessage({
    		action = 'update_trading',
    		itemAdd = itemToAdd,
  		})
	end
end)

RegisterNUICallback('closeTrading', function()
	SetNuiFocus(false, false)
	trade_ui = false
	TriggerEvent('hud:hide', false)
	ResetTradeVars()
end)

RegisterNUICallback('completeTrading', function(data)
	SetNuiFocus(false, false)
	trade_ui = false
	TriggerEvent('hud:hide', false)
	ResetTradeVars()

	TriggerServerEvent('trade:completeTrade', data.outgoing, data.ingoing)
end)

function ResetTradeVars()
	otherInv = {}
	tradeName = "Other Players Name"
	otherId = 0
end

function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)
	
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end
	
	return closestPlayer, closestDistance
end

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end