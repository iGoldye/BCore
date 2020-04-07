local carwashLocations = {
	{x=26.5906,  y=-1392.0261, z=28.6}, -- Strawberry
	{x=-699.6325,  y=-932.7043, z=18.2}, -- Little Soul
	{x=1699.563, y=4942.126, z=42.2}, -- Grapeseed
	{x=-74.5693,  y=6427.8715, z=30.5}, -- Paleto Bay
}

Citizen.CreateThread(function ()
	Citizen.Wait(0)
	for i = 1, #carwashLocations do
		local garageCoords = carwashLocations[i]
		stationBlip = AddBlipForCoord(garageCoords.x, garageCoords.y, garageCoords.z)
		SetBlipSprite(stationBlip, 100)
		SetBlipAsShortRange(stationBlip, true)
		SetBlipScale(stationBlip, 0.8)
	end
end)

Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then 
			for i = 1, #carwashLocations do
				local garageCoords = carwashLocations[i]
				DrawMarker(27, garageCoords.x, garageCoords.y, garageCoords.z, 0, 0, 0, 0, 0, 0, 5.0, 5.0, 2.0, 0, 157, 0, 155, 0, 0, 2, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), garageCoords.x, garageCoords.y, garageCoords.z, true ) < 5 then
					DrawKeybindText("ENTER", "clear you car", 250)
					if(IsControlJustPressed(1, 201)) then
						SetVehicleDirtLevel(GetVehiclePedIsUsing(GetPlayerPed(-1)))
						SetVehicleUndriveable(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
					end
				end
			end
		end
	end
end)

function DrawKeybindText(key, action, price)
	local message = ""

	if (price > 0) then
		message = "Press [~b~"..key.."~s~] to "..action.." for ~g~$"..price.."~s~."
	else
		message = "Press [~b~"..key.."~s~] to "..action.."."
	end

	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.30)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(message)
	DrawText(0.75, 0.95)
end