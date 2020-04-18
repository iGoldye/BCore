local hide = hideHud
local hungerPercent = 0
local thirstPercent = 0

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

RegisterNetEvent('hud:updateHunger')
AddEventHandler('hud:updateHunger', function(hunger, thirst)
  hungerPercent = hunger
  thirstPercent = thirst

  SendNUIMessage({
      action = 'updatehunger',
      hunder = hunger,
      thirst = thirst,
    })
end)