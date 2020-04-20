local spawn = {x = 1455.667, y = 6344.834, z = 24.168, h = 25.907}

function SpawnPlayer()
    Citizen.CreateThread(function()
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do
            Citizen.Wait(0)
        end
        FreezePlayer(PlayerId(), true)
        RequestCollisionAtCoord(spawn.x, spawn.y, spawn.z)

        local ped = PlayerPedId()
        SetEntityCoordsNoOffset(ped, spawn.x, spawn.y, spawn.z, false, false, false, true)
        NetworkResurrectLocalPlayer(spawn.x, spawn.y, spawn.z, spawn.heading, true, true, false)

        ClearPedTasksImmediately(ped)
        RemoveAllPedWeapons(ped)

        ShutdownLoadingScreen()

        if IsScreenFadedOut() then
            DoScreenFadeIn(500)

            while not IsScreenFadedIn() do
                Citizen.Wait(0)
            end
        end

        -- and unfreeze the player
        FreezePlayer(PlayerId(), false)

        TriggerEvent('playerSpawned', spawn)
    end)
end

function RevivePlayer()
    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local h = GetEntityHeading(ped)
        
        NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, h, true, true, false)
        ClearPedTasksImmediately(ped)
        TriggerEvent('hud:updateHunger', 100, 100)
    end)
end

function FreezePlayer(id, freeze)
    local player = id
    SetPlayerControl(player, not freeze, false)

    local ped = GetPlayerPed(player)

    if not freeze then
        if not IsEntityVisible(ped) then
            SetEntityVisible(ped, true)
        end

        if not IsPedInAnyVehicle(ped) then
            SetEntityCollision(ped, true)
        end

        FreezeEntityPosition(ped, false)
        --SetCharNeverTargetted(ped, false)
        SetPlayerInvincible(player, false)
    else
        if IsEntityVisible(ped) then
            SetEntityVisible(ped, false)
        end

        SetEntityCollision(ped, false)
        FreezeEntityPosition(ped, true)
        --SetCharNeverTargetted(ped, true)
        SetPlayerInvincible(player, true)
        --RemovePtfxFromPed(ped)

        if not IsPedFatallyInjured(ped) then
            ClearPedTasksImmediately(ped)
        end
    end
end

RegisterNetEvent('med:useItem')
AddEventHandler('med:useItem', function(itemData)
    local itemId = itemData.itemId
    local currentHealth = GetEntityHealth(GetPlayerPed(-1))

    if (itemId == 30) then -- Medkit
        if (currentHealth < 200) then
            local newHealth = currentHealth + 100
            if (newHealth > 200) then newHealth = 200 end

            -- Animation

            SetEntityHealth(GetPlayerPed(-1), newHealth)
            TriggerServerEvent('inv:removeItem', itemId, 1)
        end
    end
end)