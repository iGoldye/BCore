local traderSpawns = {
	{t="locknkeep", coords={x=0.0, y=0.0, z=0.0, h=0.0}, model=""},
	{t="guard", coords={x=0.0, y=0.0, z=0.0, h=0.0}, model=""},
	{t="guard", coords={x=0.0, y=0.0, z=0.0, h=0.0}, model=""},
}
local traders = {}

function SpawnTraders()
	for i,v in pairs(traders) do
		RequestModel(GetHashKey(v.model))
		while (HasModelLoaded(GetHashKey(v.model)) == false) do
    		Citizen.Wait(1)
		end


		local ped = CreatePed(4, GetHashKey(v.model), v.coords.x, v.coords.y, v.coords.z, 0, false, true)
		SetEntityHeading(ped, v.coords.h)
		SetEntityInvincible(ped, true)
	end	
end