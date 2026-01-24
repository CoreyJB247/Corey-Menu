RegisterServerEvent('ZoneActivated')
AddEventHandler('ZoneActivated', function(message, speed, radius, x, y, z)
    if message and Config.TrafficAlert then
        TriggerClientEvent('chat:addMessage', -1, { color = { 255, 255, 255 }, multiline = false, args = {"Scene Menu", message} })
    end
    TriggerClientEvent('Zone', -1, speed, radius, x, y, z)
end)

RegisterServerEvent('Disable')
AddEventHandler('Disable', function(blip)
    TriggerClientEvent('RemoveBlip', -1)
end)

RegisterServerEvent('GetData')
AddEventHandler('GetData', function(mode)
    local identifiers = GetPlayerIdentifiers(source)
    if mode == "IP" then
        for k,v in pairs(identifiers) do
            if string.sub(v, 0, 3) == "ip:" then
                TriggerClientEvent('ReturnData', source, v)
            end
        end
    else
        for k,v in pairs(identifiers) do
            if string.sub(v, 0, 6) == "steam:" then
                TriggerClientEvent('ReturnData', source, v)
            end
        end
    end
end)

-- Advert system
RegisterServerEvent('SceneMenu:SendAdvert')
AddEventHandler('SceneMenu:SendAdvert', function(message, businessName, icon)
    local src = source
    
    -- Send the advert to all players
    TriggerClientEvent('SceneMenu:ReceiveAdvert', -1, message, businessName, icon, src)
    
    -- Log to console
    print(string.format('[SceneMenu Advert] Player %s (%s): [%s] %s', GetPlayerName(src), src, businessName, message))
end)