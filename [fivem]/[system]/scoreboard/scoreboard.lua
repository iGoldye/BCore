local listOn = false
local isAdmin = false
local ptable = {}

Citizen.CreateThread(function()
    listOn = false
    while true do
        Wait(0)

        if IsControlPressed(0, 20) then
            if isAdmin == true then
                if not listOn then
                    local players = {}
                    for _,v in ipairs(ptable) do
                        table.insert(players, 
                        '<tr style=\"color: rgb(230, 230, 230)\"><td>' .. v.source .. '</td><td>' .. sanitize(v.identifiers.name) .. '</td><td>' .. v.identifiers.discord .. '</td></tr>'
                        )
                    end
                    
                    SendNUIMessage({ text = table.concat(players) })
    
                    listOn = true
                    while listOn do
                        Wait(0)
                        if(IsControlPressed(0, 20) == false) then
                            listOn = false
                            SendNUIMessage({
                                meta = 'close'
                            })
                            break
                        end
                    end
                end
            else
                -- Different Scoreboard
            end
        end
    end
end)



function sanitize(txt)
    local replacements = {
        ['&' ] = '&amp;', 
        ['<' ] = '&lt;', 
        ['>' ] = '&gt;', 
        ['\n'] = '<br/>'
    }
    return txt
        :gsub('[&<>\n]', replacements)
        :gsub(' +', function(s) return ' '..('&nbsp;'):rep(#s-1) end)
end

RegisterNetEvent('b:updatePlayerList')
AddEventHandler('b:updatePlayerList', function(players)
    ptable = players
end)

RegisterNetEvent('b:isAdmin')
AddEventHandler('b:isAdmin', function()
    isAdmin = true
end)