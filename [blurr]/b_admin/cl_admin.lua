local _displayCoords = false

RegisterNetEvent('admin:spawnVehicle')
RegisterNetEvent('admin:deleteVehicle')
RegisterNetEvent('admin:noclip')
RegisterNetEvent('admin:teleportMe')
RegisterNetEvent('admin:teleportToMe')
RegisterNetEvent('admin:toggleCoords')
RegisterNetEvent('admin:respawn')
RegisterNetEvent('admin:revive')
RegisterNetEvent('admin:gun')

AddEventHandler('admin:spawnVehicle', function(model, r, g, b)
	local hash = GetHashKey(model)
	local coords = GetEntityCoords(GetPlayerPed(-1))
	local h = GetEntityHeading(GetPlayerPed(-1))

	RequestModel(hash)

	while not HasModelLoaded(hash) do
		RequestModel(hash)
		Citizen.Wait(0)
	end

	local existingveh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	SetEntityAsMissionEntity(existingveh, true, true)

	if (existingveh) then 
		DeleteVehicle(existingveh) 
	end

	local veh = CreateVehicle(hash, coords.x, coords.y, coords.z, h, true, true)
	SetPedIntoVehicle(GetPlayerPed(-1), veh, -1)
	SetVehicleCustomPrimaryColour(veh, r, g, b)
	SetVehicleCustomSecondaryColour(veh, r, g, b)
	SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
end)

AddEventHandler('admin:deleteVehicle', function()
	local existingveh = nil

	if (IsPedSittingInAnyVehicle(GetPlayerPed(-1))) then
		local veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		if (GetPedInVehicleSeat(veh, -1) == GetPlayerPed(-1)) then
			existingveh = veh
		else
			TriggerEvent('pNotify:SendNotification', {text = "You must be in the driver seat to delete a vehicle.",type = "error",timeout = 2000,layout = "centerLeft",queue = "left"})
		end
	else
		local playerPos = GetEntityCoords(GetPlayerPed(-1), 1)
        local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 5.0, 0.0)
        local vehicle = GetVehicleInDirection(playerPos, inFrontOfPlayer)

        if(DoesEntityExist(vehicle)) then
            existingveh = vehicle
        else
            TriggerEvent('pNotify:SendNotification', {text = "Could not find the vehicle to delete, there may be a player inside or the entity is bugged.",type = "error",timeout = 2000,layout = "centerLeft",queue = "left"})
        end 
	end
	

	if (existingveh ~= nil) then 
		SetEntityAsMissionEntity(existingveh, true, true)
		DeleteVehicle(existingveh) 
		TriggerEvent('pNotify:SendNotification', {text = "You successfully deleted a vehicle.",type = "success",timeout = 2000,layout = "centerLeft",queue = "left"})
	end
end)
function GetVehicleInDirection(coordFrom, coordTo)
    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end

local noclip = false
local noclip_pos = nil
local noclip_speed = 1.0
AddEventHandler('admin:noclip', function()
	local msg = "disabled"
	if(noclip == false)then
		noclip_pos = GetEntityCoords(GetPlayerPed(-1), false)
	end

	noclip = not noclip

	if(noclip)then
		msg = "enabled"
	end

	TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Noclip has been ^2^*" .. msg)
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(noclip == true)then
        	if (IsControlJustPressed(1, 24)) then
				noclip_speed = 5.0
        	elseif (IsControlJustReleased(1, 24)) then
				noclip_speed = 1.0
        	end
	    end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(noclip == true)then
        	local x,y,z = getPosition()
        	local dx,dy,dz = getCamDirection()
        	local speed = noclip_speed
			SetEntityVisible(GetPlayerPed(-1), false, false)
			SetEntityInvincible(GetPlayerPed(-1), true)

      		-- reset velocity
     		SetEntityVelocity(GetPlayerPed(-1), 0.0001, 0.0001, 0.0001)
      		if IsControlPressed(0, 21) then
      			speed = speed + 3
      		end
      		if IsControlPressed(0, 19) then
      			speed = speed - 0.5
      		end
      		-- forward
            if IsControlPressed(0,32) then -- MOVE UP
        		x = x+speed*dx
        		y = y+speed*dy
        		z = z+speed*dz
      	    end

      		-- backward
      	    if IsControlPressed(0,269) then -- MOVE DOWN
        		x = x-speed*dx
        		y = y-speed*dy
        		z = z-speed*dz
      	    end
        	
        	SetEntityCoordsNoOffset(GetPlayerPed(-1),x,y,z,true,true,true)
      	else
      	
      		SetEntityVisible(GetPlayerPed(-1), true, false)
      		SetEntityInvincible(GetPlayerPed(-1), false)

	    end
	end
end)

function getPosition()
  local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
  return x,y,z
end

function getCamDirection()
  local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(GetPlayerPed(-1))
  local pitch = GetGameplayCamRelativePitch()

  local x = -math.sin(heading*math.pi/180.0)
  local y = math.cos(heading*math.pi/180.0)
  local z = math.sin(pitch*math.pi/180.0)

  -- normalize
  local len = math.sqrt(x*x+y*y+z*z)
  if len ~= 0 then
    x = x/len
    y = y/len
    z = z/len
  end

  return x,y,z
end

AddEventHandler('admin:teleportMe', function(coords)
	local ped = GetPlayerPed(-1)

	SetEntityCoords(ped, coords.x, coords.y, coords.z, true, true, true, false)
end)

AddEventHandler('admin:teleportToMe', function(id)
	local ped = GetPlayerPed(-1)
	local coords = GetEntityCoords(ped)

	TriggerServerEvent('admin:teleport', coords, id)
end)

AddEventHandler('admin:toggleCoords', function()
	_displayCoords = not _displayCoords
end)

AddEventHandler('admin:respawn', function()
	exports.b_med:SpawnPlayer()
end)

AddEventHandler('admin:revive', function()
	exports.b_med:RevivePlayer()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if _displayCoords then
    		x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
        	SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.30)
			SetTextDropshadow(1, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("~b~X:~s~ "..x)
			DrawText(0.15, 0.0)
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.30)
			SetTextDropshadow(1, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("~b~Y:~s~ "..y)
			DrawText(0.24, 0.0)
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.30)
			SetTextDropshadow(1, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("~b~Z:~s~ "..z)
			DrawText(0.33, 0.0)
			heading = GetEntityHeading(GetPlayerPed(-1))
   	  	   	SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.32)
			SetTextDropshadow(1, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString("~b~Heading:~s~ "..heading)
			DrawText(0.22, 0.022) 
		end
	end
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:removeSuggestion', '/weather')
    TriggerEvent('chat:removeSuggestion', '/time')
    TriggerEvent('chat:removeSuggestion', '/freezetime')
    TriggerEvent('chat:removeSuggestion', '/freezeweather')
    TriggerEvent('chat:removeSuggestion', '/morning')
    TriggerEvent('chat:removeSuggestion', '/noon')
    TriggerEvent('chat:removeSuggestion', '/evening')
    TriggerEvent('chat:removeSuggestion', '/night')
    TriggerEvent('chat:removeSuggestion', '/blackout')
    TriggerEvent('chat:removeSuggestion', '/say')


    TriggerEvent('chat:addSuggestion', '/kick', 'Kick a user from the server.', {{ name="ID", help="The player ID"}, { name="Reason", help="The reason for kicking them"}})
    TriggerEvent('chat:addSuggestion', '/ban', 'Ban a user from the server.', {{ name="ID", help="The player ID"}, {name="Time", help="How long should they be banned?"}, { name="Reason", help="The reason for banning them"}})
    TriggerEvent('chat:addSuggestion', '/respawn', 'Respawns you.', {{ name="ID", help="The player ID (Leave blank for yourself)"}})
    TriggerEvent('chat:addSuggestion', '/spawn', 'Spawn a vehicle.', {{ name="Model", help="The Model Name"}})
    TriggerEvent('chat:addSuggestion', '/goto', 'Go to a player.', {{ name="ID", help="The player ID"}})
    TriggerEvent('chat:addSuggestion', '/bring', 'Bring a player to you.', {{ name="ID", help="The player ID"}})
    TriggerEvent('chat:addSuggestion', '/tp', 'Teleport to coordinates.', {{ name="X", help="X Coordinate"},{ name="Y", help="Y Coordinate"},{ name="Z", help="Z Coordinate"}})
    TriggerEvent('chat:addSuggestion', '/coords', 'Show coordinates.')
    TriggerEvent('chat:addSuggestion', '/dv', 'Delete vehicle')
    TriggerEvent('chat:addSuggestion', '/noclip', 'Toggle no clip')
    TriggerEvent('chat:addSuggestion', '/give', 'Give an item to a player.', {{ name="Player ID", help="The player ID"}, { name="Item ID", help="The item ID"}, { name="Quantity", help="The amount you would like to give"}})
    TriggerEvent('chat:addSuggestion', '/hidehud', 'Toggle the hud')
end)