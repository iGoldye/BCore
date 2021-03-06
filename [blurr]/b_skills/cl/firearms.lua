local recoils = {
	[453432689] = 0.4, -- PISTOL
	[3219281620] = 0.4, -- PISTOL MK2
	[1593441988] = 0.3, -- COMBAT PISTOL
	[584646201] = 0.2, -- AP PISTOL
	[2578377531] = 0.7, -- PISTOL .50
	[324215364] = 0.3, -- MICRO SMG
	[736523883] = 0.3, -- SMG
	[2024373456] = 0.2, -- SMG MK2
	[4024951519] = 0.2, -- ASSAULT SMG
	[3220176749] = 0.3, -- ASSAULT RIFLE
	[961495388] = 0.3, -- ASSAULT RIFLE MK2
	[2210333304] = 0.2, -- CARBINE RIFLE
	[4208062921] = 0.2, -- CARBINE RIFLE MK2
	[2937143193] = 0.2, -- ADVANCED RIFLE
	[2634544996] = 0.2, -- MG
	[2144741730] = 0.2, -- COMBAT MG
	[3686625920] = 0.2, -- COMBAT MG MK2
	[487013001] = 0.5, -- PUMP SHOTGUN
	[2017895192] = 0.8, -- SAWNOFF SHOTGUN
	[3800352039] = 0.5, -- ASSAULT SHOTGUN
	[2640438543] = 0.3, -- BULLPUP SHOTGUN
	[911657153] = 0.2, -- STUN GUN
	[100416529] = 0.7, -- SNIPER RIFLE
	[205991906] = 0.8, -- HEAVY SNIPER
	[177293209] = 0.8, -- HEAVY SNIPER MK2
	[856002082] = 1.2, -- REMOTE SNIPER
	[2726580491] = 1.0, -- GRENADE LAUNCHER
	[1305664598] = 1.0, -- GRENADE LAUNCHER SMOKE
	[2982836145] = 0.0, -- RPG
	[1752584910] = 0.0, -- STINGER
	[1119849093] = 0.02, -- MINIGUN
	[3218215474] = 0.3, -- SNS PISTOL
	[1627465347] = 0.2, -- GUSENBERG
	[3231910285] = 0.3, -- SPECIAL CARBINE
	[3523564046] = 0.6, -- HEAVY PISTOL
	[2132975508] = 0.3, -- BULLPUP RIFLE
	[137902532] = 0.5, -- VINTAGE PISTOL
	[2828843422] = 0.8, -- MUSKET
	[984333226] = 0.3, -- HEAVY SHOTGUN
	[3342088282] = 0.4, -- MARKSMAN RIFLE
	[1672152130] = 99.9, -- HOMING LAUNCHER
	[1198879012] = 1.0, -- FLARE GUN
	[171789620] = 0.3, -- COMBAT PDW
	[3696079510] = 1.0, -- MARKSMAN PISTOL
  	[1834241177] = 99.4, -- RAILGUN
	[3675956304] = 0.4, -- MACHINE PISTOL
	[3249783761] = 0.7, -- REVOLVER
	[4019527611] = 0.8, -- DOUBLE BARREL SHOTGUN
	[1649403952] = 0.4, -- COMPACT RIFLE
	[317205821] = 1.0, -- AUTO SHOTGUN
	[125959754] = 0.6, -- COMPACT LAUNCHER
	[3173288789] = 0.2, -- MINI SMG		
}

-- Weapon control
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedShooting(PlayerPedId()) and not IsPedDoingDriveby(PlayerPedId()) then
			local _,wep = GetCurrentPedWeapon(PlayerPedId())
			_,cAmmo = GetAmmoInClip(PlayerPedId(), wep)

			local recoil = 0.5
			if (recoils[wep]) then
				recoil = recoils[wep]
			end

			if (recoilMultipliers[skills[5].lvl + 1] ~= nil) then
				recoil = recoil * recoilMultipliers[skills[5].lvl + 1]
			else
				recoil = recoil * recoilMultipliers[1]
			end

			if recoil ~= 0 then
				tv = 0
				repeat 
					Wait(0)
					p = GetGameplayCamRelativePitch()
					if GetFollowPedCamViewMode() ~= 4 then
						SetGameplayCamRelativePitch(p+0.1, 0.2)
					end
					tv = tv+0.1
				until tv >= (recoil / 2)
			end
			
		end
	end
end)

-- Leveling up
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		-- Level shooting
		if (IsPedShooting(GetPlayerPed(-1))) then
			skills[5].exp = skills[5].exp + firearmGain
		end
	end
end)

-- Leveling down
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15000)

		-- Level shooting
		if (IsPedShooting(GetPlayerPed(-1)) and skills[5].lvl > 0) then
			skills[5].exp = skills[5].exp - firearmDrain
		end

		oldLvl = skills[5].lvl
		level = 0
		for j,_ in pairs(levels) do
			if (skills[5].exp > levels[j]) then 
				level = j
			end
		end
		skills[5].lvl = level
		if (oldLvl ~= level) then 
			TriggerEvent('pNotify:SendNotification', {text = "Firearms - Level "..level,type = "success",timeout = 2000,layout = "centerLeft",queue = "left"})
		end

		-- Update server
		TriggerServerEvent('skills:update', skills)
	end
end)
