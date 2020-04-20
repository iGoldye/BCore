function CloseVehicleInventory()
	SetNuiFocus(false, false)
	vehicle_ui = false
	TriggerEvent('hud:hide', false)

	SendNUIMessage({
    	action = 'close_all',
  	})
end