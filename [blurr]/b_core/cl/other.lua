---------------------- NO POPO
Citizen.CreateThread(function()
    while true do
    	if GetPlayerWantedLevel(PlayerId()) ~= 0 then
        	SetPlayerWantedLevel(PlayerId(), 0, false)
        	SetPlayerWantedLevelNow(PlayerId(), false)
    	end
    	Citizen.Wait(0)
    end
end)

---------------------- NO POINT N SHOOT
Citizen.CreateThread(function()
	local isSniper = false
	while true do
		Citizen.Wait(0)

    	local ped = GetPlayerPed(-1)
		local currentWeaponHash = GetSelectedPedWeapon(ped)

		if currentWeaponHash == 100416529 then
			isSniper = true
		elseif currentWeaponHash == 205991906 then
			isSniper = true
		elseif currentWeaponHash == -952879014 then
			isSniper = true
		elseif currentWeaponHash == GetHashKey('WEAPON_HEAVYSNIPER_MK2') then
			isSniper = true
		else
			isSniper = false
		end

		if not isSniper then
			HideHudComponentThisFrame(14)
		end
	end
end)

---------------------- IPLS
RegisterNetEvent("ipl:LoadAllIPLS")
AddEventHandler("ipl:LoadAllIPLS", function(weapon)
	Citizen.CreateThread(function()

		LoadMpDlcMaps()
		EnableMpDlcMaps(true)
		RequestIpl("chop_props")
		RequestIpl("FIBlobby")
		RemoveIpl("FIBlobbyfake")
		RequestIpl("FBI_colPLUG")
		RequestIpl("FBI_repair")
		RequestIpl("v_tunnel_hole")
		RequestIpl("TrevorsMP")
		RequestIpl("TrevorsTrailer")
		RequestIpl("TrevorsTrailerTidy")
		RemoveIpl("farm_burnt")
		RemoveIpl("farm_burnt_lod")
		RemoveIpl("farm_burnt_props")
		RemoveIpl("farmint_cap")
		RemoveIpl("farmint_cap_lod")
		RequestIpl("farm")
		RequestIpl("farmint")
		RequestIpl("farm_lod")
		RequestIpl("farm_props")
		RequestIpl("facelobby")
		RemoveIpl("CS1_02_cf_offmission")
		RequestIpl("CS1_02_cf_onmission1")
		RequestIpl("CS1_02_cf_onmission2")
		RequestIpl("CS1_02_cf_onmission3")
		RequestIpl("CS1_02_cf_onmission4")
		RequestIpl("v_rockclub")
		RemoveIpl("hei_bi_hw1_13_door")
		RequestIpl("bkr_bi_hw1_13_int")
		RequestIpl("ufo")
		RemoveIpl("v_carshowroom")
		RemoveIpl("shutter_open")
		RemoveIpl("shutter_closed")
		RemoveIpl("shr_int")
		RemoveIpl("csr_inMission")
		RequestIpl("v_carshowroom")
		RequestIpl("shr_int")
		RequestIpl("shutter_closed")
		RequestIpl("smboat")
		RequestIpl("cargoship")
		RequestIpl("railing_start")
		RemoveIpl("sp1_10_fake_interior")
		RemoveIpl("sp1_10_fake_interior_lod")
		RequestIpl("sp1_10_real_interior")
		RequestIpl("sp1_10_real_interior_lod")
		RemoveIpl("id2_14_during_door")
		RemoveIpl("id2_14_during1")
		RemoveIpl("id2_14_during2")
		RemoveIpl("id2_14_on_fire")
		RemoveIpl("id2_14_post_no_int")
		RemoveIpl("id2_14_pre_no_int")
		RemoveIpl("id2_14_during_door")
		RequestIpl("id2_14_during1")
		RequestIpl("coronertrash")
		RequestIpl("Coroner_Int_on")
		RemoveIpl("Coroner_Int_off")
		RemoveIpl("bh1_16_refurb")
		RemoveIpl("jewel2fake")
		RemoveIpl("bh1_16_doors_shut")
		RequestIpl("refit_unload")
		RequestIpl("post_hiest_unload")
		RequestIpl("Carwash_with_spinners")
		RequestIpl("ferris_finale_Anim")
		RemoveIpl("ch1_02_closed")
		RequestIpl("ch1_02_open")
		RequestIpl("AP1_04_TriAf01")
		RequestIpl("CS2_06_TriAf02")
		RequestIpl("CS4_04_TriAf03")
		RemoveIpl("scafstartimap")
		RequestIpl("scafendimap")
		RemoveIpl("DT1_05_HC_REMOVE")
		RequestIpl("DT1_05_HC_REQ")
		RequestIpl("DT1_05_REQUEST")
		RequestIpl("FINBANK")
		RemoveIpl("DT1_03_Shutter")
		RemoveIpl("DT1_03_Gr_Closed")
		RequestIpl("ex_sm_13_office_01a")
		RequestIpl("ex_sm_13_office_01b")
		RequestIpl("ex_sm_13_office_02a")
		RequestIpl("ex_sm_13_office_02b")
		RequestIpl("rc12b_hospitalinterior")
		RequestIpl("rc12b_hospitalinterior_lod")
		RequestIpl("rc12b_fixed")
		RequestIpl("CS3_05_water_grp1")
		RequestIpl("CS3_05_water_grp2")
		RequestIpl("canyonriver01")
		RequestIpl("canyonrvrdeep")
		
	end)
end)

---------------------- PVP
RegisterNetEvent("b:pvp")
AddEventHandler("b:pvp", function()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            
            SetCanAttackFriendly(GetPlayerPed(-1), true, true)
            NetworkSetFriendlyFireOption(true)
        end
    end)
end)

---------------------- CROUCHING
local crouched = false

Citizen.CreateThread( function()
    while true do 
        Citizen.Wait( 1 )

        local ped = GetPlayerPed( -1 )

        if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
            DisableControlAction( 0, 36, true ) -- INPUT_DUCK  

            if ( not IsPauseMenuActive() ) then 
                if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) and IsDisabledControlJustPressed( 0, 36 ) then 
                    RequestAnimSet( "move_ped_crouched" )

                    while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
                        Citizen.Wait( 100 )
                    end 

                    if ( crouched == true ) then 
                        ResetPedMovementClipset( ped, 0 )
                        crouched = false 
                    elseif ( crouched == false ) then
                        SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
                        crouched = true 
                    end 
                end
            end 
        end 
    end
end )

---------------------- POINTING
local mp_pointing = false
local keyPressed = false

local function startPointing()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end

local once = true
local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if once then
            once = false
        end

        if not keyPressed then
            if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
                Wait(200)
                if not IsControlPressed(0, 29) then
                    keyPressed = true
                    startPointing()
                    mp_pointing = true
                else
                    keyPressed = true
                    while IsControlPressed(0, 29) do
                        Wait(50)
                    end
                end
            elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
        end

        if keyPressed then
            if not IsControlPressed(0, 29) then
                keyPressed = false
            end
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
            stopPointing()
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
            if not IsPedOnFoot(PlayerPedId()) then
                stopPointing()
            else
                local ped = GetPlayerPed(-1)
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

            end
        end
    end
end)

---------------------- HANDSUP
Citizen.CreateThread(function()
    local dict = "missminuteman_1ig_2"
    
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    local handsup = false
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 323) then --Start holding X
            if not handsup then
                TaskPlayAnim(GetPlayerPed(-1), dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
        end
    end
end)

local mp_pointing = false
local keyPressed = false

local function startPointing()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end

local once = true
local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if once then
            once = false
        end

        if not keyPressed then
            if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
                Wait(200)
                if not IsControlPressed(0, 29) then
                    keyPressed = true
                    startPointing()
                    mp_pointing = true
                else
                    keyPressed = true
                    while IsControlPressed(0, 29) do
                        Wait(50)
                    end
                end
            elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
        end

        if keyPressed then
            if not IsControlPressed(0, 29) then
                keyPressed = false
            end
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
            stopPointing()
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
            if not IsPedOnFoot(PlayerPedId()) then
                stopPointing()
            else
                local ped = GetPlayerPed(-1)
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

            end
        end
    end
end)