Citizen.CreateThread(function()
	while true do
		DisableControlAction(1, 12, true)
		DisableControlAction(1, 13, true)
		DisableControlAction(1, 14, true)
		DisableControlAction(1, 15, true)
		DisableControlAction(1, 16, true)
		DisableControlAction(1, 17, true)
		DisableControlAction(1, 37, true)
		DisableControlAction(1, 99, true)
		DisableControlAction(1, 100, true)
		DisableControlAction(1, 115, true)
		DisableControlAction(1, 116, true)
		DisableControlAction(1, 157, true)
		DisableControlAction(1, 158, true)
		DisableControlAction(1, 159, true)
		DisableControlAction(1, 160, true)
		DisableControlAction(1, 161, true)
		DisableControlAction(1, 162, true)
		DisableControlAction(1, 163, true)
		DisableControlAction(1, 164, true)
		DisableControlAction(1, 165, true)
		DisableControlAction(1, 183, true) -- G
		DisableControlAction(1, 192, true)
		DisableControlAction(1, 204, true)
		DisableControlAction(1, 211, true)
		DisableControlAction(1, 261, true)
		DisableControlAction(1, 262, true)
		DisableControlAction(1, 349, true)

		if (IsDisabledControlJustPressed(1, 37) or IsDisabledControlJustPressed(1, 183)) then
			if (inv_ui == false and trade_ui == false and craft_ui == false and vehicle_ui == false) then
				if (IsPedArmed(GetPlayerPed(-1), 7)) then
					local ammo = GetAmmoInPedWeapon(GetPlayerPed(-1), GetCurrentPedWeapon(GetPlayerPed(-1), true))
					TriggerServerEvent('inv:updateAmmo', GetCurrentPedWeapon(GetPlayerPed(-1), true), ammo)
					print("updating ammo")
				end

				TriggerServerEvent('inv:update')
  				SetCursorLocation(0.5,0.1)
  				inv_ui = true
  			end
		end

		Citizen.Wait(1)
	end
end)

RegisterNetEvent('inv:open')
AddEventHandler('inv:open', function(inventory, weight, count)
	inv = inventory
	invWeight = weight
	invCount = count

	SendNUIMessage({
    	action = 'open_inventory',
    	items = inv,
    	itemsW = invWeight,
    	itemsC = invCount,
  	})

	TriggerEvent('hud:hide', true)
  	SetNuiFocus(true, true)
end)

RegisterNUICallback('closeInventory', function()
	SetNuiFocus(false, false)
	inv_ui = false
	TriggerEvent('hud:hide', false)
end)

RegisterNUICallback('onUseItem', function(data)
	SetNuiFocus(false, false)
	inv_ui = false
	TriggerEvent('hud:hide', false)

	if (data.itemUse == -1 or data.itemUse == 8) then
		TriggerEvent('pNotify:SendNotification', {text = "This item can not be used here.",type = "success",timeout = 2000,layout = "centerLeft",queue = "left"})
		return
	end

	if (data.itemUse == 0) then
		SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), false)
	elseif (data.itemUse == 1) then
		DrinkItem(data.itemId)
	elseif (data.itemUse == 2) then
		EatItem(data.itemId)
	elseif (data.itemUse == 3) then
		UseItem(data.itemId)
	elseif (data.itemUse == 4) then
		TriggerEvent('med:useItem', data)
	elseif (data.itemUse == 5 or data.itemUse == 6 or data.itemUse == 7) then
		for i,v in pairs(inv) do
			if (v.id == data.itemId) then
				local weapon = GetHashKey(v.model)
        		GiveWeaponToPed(GetPlayerPed(-1), weapon, v.count, 0, true)
			end
		end
	end
end)

RegisterNUICallback('onDropItem', function(data)
	if (data.itemUse == -1 or data.itemUse == 0) then
		return
	end

	local location = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.5, -0.9)

	if (data.itemUse == 5 or data.itemUse == 6 or data.itemUse == 7) then
		TriggerServerEvent('inv:dropItem', data.itemName, data.itemUse, data.itemId, data.itemCount, location)
	else
		TriggerServerEvent('inv:dropItem', data.itemName, data.itemUse, data.itemId, 1, location)
	end

	SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), false)
	TriggerServerEvent('inv:update')
end)

local pickups = {}
RegisterNetEvent('inv:placeDroppedItem')
AddEventHandler('inv:placeDroppedItem', function(location, time, item, objectName)
	local obj = CreateObject(GetHashKey(objectName), location.x, location.y, location.z, true, true, true)
	PlaceObjectOnGroundProperly(obj)
	
	Citizen.Wait(1200)

	item.object = obj
	item.location = GetEntityCoords(obj)
	TriggerServerEvent('inv:broadcastItem', item)
end)

RegisterNetEvent('inv:removeDroppedItem')
AddEventHandler('inv:removeDroppedItem', function(item, inventory)
	inv = inventory

	for i,v in pairs(pickups) do
		if (v.id == item.id and v.object == item.object) then
			SetEntityAsMissionEntity(item.object)
			DeleteObject(item.object)
			
			if (v.use == 5 or v.use == 6 or v.use == 7) then
				local weapon = GetHashKey(v.model)
        		GiveWeaponToPed(GetPlayerPed(-1), weapon, v.count, 0, true)
			end
		end
	end
end)

RegisterNetEvent('inv:syncDroppedItems')
AddEventHandler('inv:syncDroppedItems', function(items)
	pickups = items
end)

local nearbyItems = {}
local currentItem = {}

Citizen.CreateThread(function()
	while true do
		local coords = GetEntityCoords(GetPlayerPed(-1))
		nearbyItems = {}
		local nearestDist = 1000.0
		for i,v in pairs(pickups) do
			local distance = GetDistanceBetweenCoords(coords, v.location, true)

			if distance < 3.0 then
				local onScreen,_x,_y=World3dToScreen2d(v.location.x, v.location.y, v.location.z)
				if (onScreen) then
					local camDist = GetDistanceBetweenCoords(_x, _y, 0.0, 0.0, 0.0, 0.0, false)
					
					if (camDist <= nearestDist) then
						currentItem = v
						nearestDist = camDist
					end
				end
				table.insert(nearbyItems, v)
				--DrawText3D("Pickup "..v.n, v.location.x, v.location.y, v.location.z + 0.1, 255, 255, 255)

				--if (IsControlJustPressed(1, 51)) then
					--TriggerServerEvent('inv:pickupItem', v)
				--end
			end
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		if (#nearbyItems > 0) then
			DrawText3D("Pickup "..currentItem.n, currentItem.location.x, currentItem.location.y, currentItem.location.z + 0.1, 255, 255, 255)

			if (IsControlJustPressed(1, 51)) then
				TriggerServerEvent('inv:pickupItem', currentItem)
			end
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if (IsPedArmed(GetPlayerPed(-1), 7)) then
			local ammo = GetAmmoInPedWeapon(GetPlayerPed(-1), GetCurrentPedWeapon(GetPlayerPed(-1), true))
			TriggerServerEvent('inv:updateAmmo', GetWeapontypeModel(GetCurrentPedWeapon(GetPlayerPed(-1), true)), ammo)
			print("updating ammo")
		end
	end
end)


function DrinkItem(itemId)
	TriggerServerEvent('inv:removeItem', itemId, 1)

	-- Animation?

	if (itemId == 1) then -- water
		TriggerEvent('hud:addHunger', 0, 55)
	elseif (itemId == 2) then -- apple juice
		TriggerEvent('hud:addHunger', 0, 50)
	elseif (itemId == 3) then -- cola
		TriggerEvent('hud:addHunger', 0, 40)
	elseif (itemId == 4) then -- redbull
		TriggerEvent('hud:addHunger', 0, 30)
		TriggerEvent('effects:energetic', 10000)
	elseif (itemId == 5) then -- coffee
		TriggerEvent('hud:addHunger', 0, 45)
	else
		-- this drink hasnt been set up correctly rip
		TriggerEvent('hud:addHunger', 0, 40)
	end
end

function EatItem(itemId)
	TriggerServerEvent('inv:removeItem', itemId, 1)

	-- Animation?

	if (itemId == 10) then -- burger
		TriggerEvent('hud:addHunger', 60, 0)
	elseif (itemId == 11) then -- hotdog
		TriggerEvent('hud:addHunger', 55, 0)
	elseif (itemId == 12) then -- salad
		TriggerEvent('hud:addHunger', 45, 10)
	elseif (itemId == 13) then -- pineapple
		TriggerEvent('hud:addHunger', 40, 25)
	elseif (itemId == 14) then -- banana
		TriggerEvent('hud:addHunger', 25, 0)
	elseif (itemId == 15) then -- raw meat
		TriggerEvent('hud:addHunger', -25, -25)
		TriggerEvent('effects:sick', 10000)
	elseif (itemId == 16) then -- cooked meat
		TriggerEvent('hud:addHunger', 65, 10)
	else
		-- this food hasnt been set up correctly rip
		TriggerEvent('hud:addHunger', 40, 0)
	end
end

function UseItem(itemId)
	TriggerServerEvent('inv:removeItem', itemId, 1)

	-- Todo
end


function DrawText3D(text, x, y, z, r, g, b)
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