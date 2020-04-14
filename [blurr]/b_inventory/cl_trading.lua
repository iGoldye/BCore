RegisterNUICallback('requestTrading', function()
	SetNuiFocus(false, false)
	inv_ui = false

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
    	itemsW = invWeight,
    	itemsC = invCount,
  	})

	trade_ui = true
  	SetNuiFocus(true, true)
end)

RegisterNUICallback('updateTrade', function(data)
	TriggerServerEvent('trade:update', otherId, data.cancel, data.accept, data.offeredItem)
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
	ResetTradeVars()
end)

RegisterNUICallback('completeTrading', function(data)
	SetNuiFocus(false, false)
	trade_ui = false
	ResetTradeVars()

	TriggerServerEvent('trade:completeTrade', data.outgoing, data.ingoing)
end)

function ResetTradeVars()
	otherInv = {}
	tradeName = "Other Players Name"
	otherId = 0
end