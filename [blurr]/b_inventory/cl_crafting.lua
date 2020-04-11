local location = ""

Citizen.CreateThread(function()
	while true do
		canOpenCrafting = false

		for i,v in pairs(crafting_locations) do
			local coords = GetEntityCoords(GetPlayerPed(-1))
			local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, v.x, v.y, v.z, true)

			if (distance <= 3.0) then
				canOpenCrafting = true
				location = v.name
				DrawText3D(v.x, v.y, v.z, 255, 255, 255, "Press 'E' to open crafting...")
			end
		end

		if (canOpenCrafting) then
			if (IsDisabledControlJustPressed(1, 51)) then
				if (inv_ui == false and trade_ui == false and craft_ui == false and vehicle_ui == false) then
					TriggerServerEvent('craft:update')
  					SetCursorLocation(0.5,0.1)
  					craft_ui = true
  				end
			end
		end

		Citizen.Wait(1)
	end
end)

RegisterNetEvent('craft:open')
AddEventHandler('craft:open', function(inventory)
	inv = inventory

	SendNUIMessage({
    	action = 'open_crafting',
    	items = inv
    	location = location
  	})

  	SetNuiFocus(true, true)
end)

RegisterNUICallback('closeCrafting', function()
	SetNuiFocus(false, false)
	craft_ui = false
end)