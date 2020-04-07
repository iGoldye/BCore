IsLoggedIn = false
WaitingForData = true
CharID = 1

AddEventHandler('playerSpawned', function(spawn)
    StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")

    if IsLoggedIn then
        TriggerServerEvent('b:spawned')
        TriggerEvent('b:spawnedClient')
    else
        exports.spawnmanager:setAutoSpawn(false)
        TriggerEvent('b:freeze')

        while (WaitingForData) do
            Citizen.Wait(0)
            DrawWaitingText()
        end
        TriggerServerEvent('b:getCharacterData')
    end
end)

RegisterNetEvent('b:ready')
AddEventHandler('b:ready', function()
    Citizen.Wait(200)
    WaitingForData = false
end)

RegisterNetEvent('b:freeze')
AddEventHandler('b:freeze', function()
  Citizen.CreateThread(function()
    local ped = GetPlayerPed(PlayerId())
    if IsEntityVisible(ped) then
    SetEntityVisible(ped, false)
    end
    SetPlayerInvincible(PlayerId(), true)
    SetEntityCoords(ped, -428.836, 1598.182, 356.261)
    SetEntityHeading(ped, 0.0)
    FreezeEntityPosition(ped, true) 

    HasSpawned = true
  end)
end)

RegisterNetEvent('b:unfreeze')
AddEventHandler('b:unfreeze', function(coords, modeldata)
    IsLoggedIn = true
    Citizen.CreateThread(function()
    local ped = GetPlayerPed(-1)

    SetEntityVisible(ped, true)
    SetPlayerInvincible(PlayerId(), false)
    FreezeEntityPosition(ped, false)    

    if (coords == nil) then
        SetEntityCoords(ped, 1455.667, 3644.834, 24.168)
        SetEntityHeading(ped, 28.907)
    else
        SetEntityCoords(ped, coords.x, coords.y, coords.z)
        SetEntityHeading(ped, coords.h)
    end
    TriggerEvent('clothes:spawn', modeldata)

    SavePosition()
    TriggerServerEvent('b:beginPlay')
  end)
end)

RegisterNetEvent('b:createCharacterUi')
AddEventHandler('b:createCharacterUi', function(data)
    local name = "Place Holder"
    local dob = {d=20, m=3, y=1998}
    local gender = "male"

    TriggerServerEvent('b:createCharacter', name, dob, gender)
end)

RegisterNetEvent('b:selectCharacterUi')
AddEventHandler('b:selectCharacterUi', function(data)
    TriggerServerEvent('b:selectCharacter', 1)
end)

Citizen.CreateThread(function()
    while true do
        if not IsLoggedIn then
            DisableControlAction(0, 1, not IsLoggedIn) -- LookLeftRight
            DisableControlAction(0, 2, not IsLoggedIn) -- LookUpDown

            DisableControlAction(0, 142, not IsLoggedIn) -- MeleeAttackAlternate

            DisableControlAction(0, 106, not IsLoggedIn) -- VehicleMouseControlOverride
        end
        Citizen.Wait(0)
    end
end)

function SavePosition()
    Citizen.Wait(60000)
    while true do
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local h = GetEntityHeading(GetPlayerPed(-1))

        TriggerServerEvent('b:updateLastCoords', coords.x, coords.y, coords.z, h)
        Citizen.Wait(10000)
    end
end

function DrawWaitingText()
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.0, 0.30)
    SetTextDropshadow(1, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString("~b~Please wait whilst we get everything ready...")
    DrawText(0.6, 0.95)
end