local hideStats = false
local hideOxygen = false

Citizen.CreateThread(function()
  while true do
	  Citizen.Wait(0)
	
		local playerPed = GetPlayerPed(-1)
		local playerVeh = GetVehiclePedIsIn(playerPed, false)

    local sizeX = 0.055
    local spacing = 0.002
    local sizeY = (sizeX * (16/9)) / 14
    local x = spacing + (sizeX/2)
    local y = ((0.99 - spacing) - sizeY)

    --RestorePlayerStamina(PlayerId(), GetPlayerSprintStaminaRemaining(PlayerId()))

    local health = GetEntityHealth(GetPlayerPed(-1)) / 2
    local stamina = (100 - GetPlayerSprintStaminaRemaining(PlayerId()))
    local timeUnderWater = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10

		if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) and not isBike(playerVeh) then
			DisplayRadar(true)
      hideStats = true
		else
			DisplayRadar(false)
      hideStats = false
      --DrawStatBar(x, y, spacing, sizeX, sizeY, health, 0, 0, 0, 11, 92, 31)
      --DrawStatBar(x + ((sizeX + spacing) * 1), y, spacing, sizeX, sizeY, stamina, 0, 0, 0, 38, 153, 199)
      
      if (IsPedSwimmingUnderWater(GetPlayerPed(-1))) then
        hideOxygen = false
        --DrawStatBar(x + ((sizeX + spacing) * 2), y, spacing, sizeX, sizeY, timeUnderWater, 0, 0, 0, 45, 140, 199)
      else
        hideOxygen = true
      end
		end
    UpdateStats(health, stamina, timeUnderWater)
  end
end)

function UpdateStats(health, stamina, oxygen)
  SendNUIMessage({
      action = 'updateStats',
      health = health,
      stamina = stamina,
      oxygen = oxygen,
      hideHealth = hideStats,
      hideStamina = hideStats,
      hideOxygen = hideOxygen
  })
end

local bikes = {
  "bmx",
  "scorcher",
  "tribike",
  "tribike2",
  "tribike3",
  "cruiser",
  "fixter",
}

function isBike(veh)
    model = GetEntityModel(veh)

    for i = 1, #bikes do
        if model == GetHashKey(bikes[i]) then
            return true
        end
    end
    return false
end

function DrawStatBar(x, y, padding, sizeX, sizeY, percentage, r, g, b, r1, g1, b1)
  DrawRect(x, y, sizeX, (sizeY + padding), r, g, b, 255)
  DrawRect((x - (sizeX / 2)) + (((sizeX / 2) / 100) * percentage), y, (sizeX / 100) * percentage, sizeY, r1, g1, b1, 255)
end