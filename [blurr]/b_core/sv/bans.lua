local bans = {
	{license="awda", discord=34412, reason="cunts"},
}
local playerCount = 0
local list = {}

AddEventHandler("playerConnecting", function(name, setKickReason, deferrals)
	local id = tonumber(source)
	local identifiers = {name=name,discord=tonumber(GetID("discord", id)), ip=GetID("ip", id), license=GetID("license", id), steam=GetID("steam", id)}
	local cv = GetConvarInt('sv_maxclients', 32)

	deferrals.defer()
	Wait(0)
	print("[B-Core] "..name.." is trying to connect...")
	deferrals.update("Welcome, we are running our checks...")
	Wait(0)

	if (identifiers.discord ~= nil and identifiers.discord > 1) then
		if (identifiers.license) then
			for i,v in pairs(bans) do
				if (bans[i].license == identifiers.license) or (bans[i].discord == identifiers.discord) then
					print("[B-Core] "..name.." tried to connect but are banned.")
					deferrals.done("You are banned from the server for " .. bans[i].reason..". Join our Discord for help.")
				else
					if (playerCount >= cv) then
						print("[B-Core] "..name.." passed all checks, server is full.")
						deferrals.done("The server is full, try again soon!")
					else
						print("[B-Core] "..name.." passed all checks, connecting.")
						deferrals.done()
					end
				end
			end
		else
			print("[B-Core] "..name.." tried to connect but couldn't find license identifier.")
			deferrals.done("No game license found, do you have a valid copy of the game?")
		end
	else
		print("[B-Core] "..name.." tried to connect but couldn't find Discord identifier.")
		deferrals.done("You must have a Discord account linked to FiveM to join this server. If this is in error, please restart your game.")
	end
end)

RegisterServerEvent('hardcap:playerActivated')
AddEventHandler('hardcap:playerActivated', function()
  if not list[source] then
    playerCount = playerCount + 1
    list[source] = true
  end
end)

AddEventHandler('playerDropped', function()
  if list[source] then
    playerCount = playerCount - 1
    list[source] = nil
  end
end)