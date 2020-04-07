local hide = hideHud

RegisterNetEvent('hud:hide')
AddEventHandler('hud:hide', function(hide)
	hideHud = hide
	SendNUIMessage({
    	action = 'hideHud',
    	hide = hideHud
  	})
end)

RegisterNetEvent('hud:toggle')
AddEventHandler('hud:toggle', function()
	hideHud = not hideHud
	SendNUIMessage({
    	action = 'hideHud',
    	hide = hideHud
  	})
end)