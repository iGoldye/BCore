RegisterNUICallback('requestTrading', function()
	SetNuiFocus(false, false)
	inv_ui = false

	otherInv = {}
	tradeName = "Other Players Name"

	local t, distance = GetClosestPlayer()
	if(distance ~= -1 and distance < 3) then
		TriggerServerEvent("trade:requestTrade", GetPlayerServerId(t))
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
    	action = 'open_inventory',
    	items = inv
  	})

	trade_ui = true
  	SetNuiFocus(true, true)
end)

RegisterNUICallback('closeTrading', function()
	SetNuiFocus(false, false)
	trade_ui = false
	otherInv = {}
	tradeName = "Other Players Name"
end)