Citizen.CreateThread(function()
    while true do
        hour = GetClockHours()
        minute = GetClockMinutes()
        if hour <= 9 then
            hour = "0" .. hour
        end
        if minute <= 9 then
            minute = "0" .. minute
        end

        local time = "Time: "..hour..":"..minute
        
        SendNUIMessage({
            action = 'updateTime',
            time = time,
        })

        Citizen.Wait(10)

        --[[Citizen.Wait(0)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.0, 0.30)
        SetTextDropshadow(1, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")

        AddTextComponentString("~b~Time:~s~ "..hour..":"..minute)
        DrawText(0.8, 0.013)]]
    end
end)