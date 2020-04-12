inv = {}
invWeight = 0
invCount = 0

inv_ui = false
craft_ui = false
trade_ui = false
vehicle_ui = false

canOpenCrafting = false
crafting_locations = {
	{name="workbench", x=0.0, y=0.0, z=0.0},
}

tradeName = "Other Players Name"
otherInv = {}

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