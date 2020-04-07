local firstjoin = true
Citizen.CreateThread(function()
    while firstjoin do
        Citizen.Wait(0)

        if NetworkIsSessionStarted() then
            exports.spawnmanager:setAutoSpawn(false)

            TriggerServerEvent('b:firstJoin')
            TriggerServerEvent('hardcap:playerActivated')

            firstjoin = false
            return
        end
    end
end)