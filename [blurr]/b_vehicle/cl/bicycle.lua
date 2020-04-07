local bicycleSpawn = {x=1469.5654, y=6368.687, z=23.623}
local spawned = false

Citizen.CreateThread(function()
	local incircle = false
	while not spawned do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		local distance = GetDistanceBetweenCoords(bicycleSpawn.x, bicycleSpawn.y, bicycleSpawn.z, pos.x, pos.y, pos.z, true)

		if (distance < 15) then
			DrawMarker(1, bicycleSpawn.x, bicycleSpawn.y, bicycleSpawn.z-1, 0, 0, 0, 0, 0, 0, 3.0001, 3.0001, 0.5001, 1555, 0, 0,165, 0, 0, 0,0)

			if (distance < 2) then
				DrawText3D(bicycleSpawn.x, bicycleSpawn.y, bicycleSpawn.z + 1, 255, 255, 255, "Press ~INPUT_CONTEXT~ to spawn a bicycle.")
				--if (incircle == false) then
                 --   DisplayHelpText("Press ~INPUT_CONTEXT~ to spawn a bicycle.")
                --end
                incircle = true

				if (IsControlJustReleased(1, 51)) then
					local hash = 1131912276
					RequestModel(hash)
					while not HasModelLoaded(hash) do
						RequestModel(hash)
						Citizen.Wait(0)
					end

					local veh = CreateVehicle(hash, bicycleSpawn.x, bicycleSpawn.y, bicycleSpawn.z, 208.0, true, true)
					SetPedIntoVehicle(GetPlayerPed(-1), veh, -1)
					SetVehicleCustomPrimaryColour(veh, 255, 0, 0)
					SetVehicleCustomSecondaryColour(veh, 255, 255, 255)
					SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
					spawned = true
					TriggerEvent('pNotify:SendNotification', {text = "Spawned free bicycle.",type = "success",timeout = 2000,layout = "centerLeft",queue = "left"})
				end
			else
				if (distance < 8) then
					DrawText3D(bicycleSpawn.x, bicycleSpawn.y, bicycleSpawn.z + 1, 0, 0, 0, "Press ~INPUT_CONTEXT~ to spawn a bicycle.")
				end

				incircle = false
			end
		end

		Citizen.Wait(1)
	end
end)

RegisterNetEvent('b:spawnedClient')
AddEventHandler('b:spawnedClient', function()
    spawned = false
end)

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3D(x, y, z, r, g, b, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.34, 0.34)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end