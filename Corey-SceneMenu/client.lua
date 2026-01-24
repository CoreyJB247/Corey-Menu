local speedZoneActive = false
local blip
local speedZone
local speedzones = {}
local GlobalData = ""

------------------------
--[[ Menu Functions ]]--
------------------------

local function openObjectMenu()
    local elements = {}
    
    for k, v in pairs(Config.Objects) do
        table.insert(elements, {
            title = v.Displayname,
            description = 'Spawn ' .. v.Displayname,
            icon = 'box',
            onSelect = function()
                local Player = GetPlayerPed(-1)
                local heading = GetEntityHeading(Player)
                local coords = GetEntityCoords(Player, true)
                local objectname = v.Object
                
                RequestModel(objectname)
                while not HasModelLoaded(objectname) do
                    Citizen.Wait(1)
                end
                
                local obj = CreateObject(GetHashKey(objectname), coords.x, coords.y, coords.z, true, false)
                PlaceObjectOnGroundProperly(obj)
                SetEntityHeading(obj, heading)
                FreezeEntityPosition(obj, true)
                
                lib.notify({
                    title = 'Object Spawned',
                    description = v.Displayname .. ' has been placed',
                    type = 'success'
                })
                
                openObjectMenu()
            end
        })
    end
    
    table.insert(elements, {
        title = 'Delete Nearest Object',
        description = 'Remove the closest prop',
        icon = 'trash',
        iconColor = 'red',
        onSelect = function()
            local coords = GetEntityCoords(PlayerPedId(), true)
            local deleted = false
            
            for k, v in pairs(Config.Objects) do
                local hash = GetHashKey(v.Object)
                if DoesObjectOfTypeExistAtCoords(coords.x, coords.y, coords.z, 0.9, hash, true) then
                    local object = GetClosestObjectOfType(coords.x, coords.y, coords.z, 0.9, hash, false, false, false)
                    DeleteObject(object)
                    deleted = true
                    break
                end
            end
            
            if deleted then
                lib.notify({
                    title = 'Corey Scene Menu',
                    description = 'Nearest object removed',
                    type = 'success'
                })
            else
                lib.notify({
                    title = 'Corey Scene Menu',
                    description = 'No objects nearby to delete',
                    type = 'error'
                })
            end
            
            openObjectMenu()
        end
    })
    
    lib.registerContext({
        id = 'object_menu',
        title = 'Objects Menu',
        menu = 'main_menu',
        options = elements
    })
    
    lib.showContext('object_menu')
end

local function openSpeedZoneMenu()
    lib.registerContext({
        id = 'speedzone_menu',
        title = 'Speed Zone',
        menu = 'main_menu',
        options = {
            {
                title = 'Create Speed Zone',
                description = 'Set a speed limit zone',
                icon = 'gauge',
                onSelect = function()
                    local radiusInput = lib.inputDialog('Speed Zone Settings', {
                        {
                            type = 'select',
                            label = 'Radius',
                            description = 'Select zone radius',
                            options = (function()
                                local opts = {}
                                for _, v in pairs(Config.SpeedZone.Radius) do
                                    table.insert(opts, {value = tonumber(v), label = v .. 'm'})
                                end
                                return opts
                            end)(),
                            required = true,
                            default = 25
                        },
                        {
                            type = 'select',
                            label = 'Speed Limit',
                            description = 'Select speed limit (mph)',
                            options = (function()
                                local opts = {}
                                for _, v in pairs(Config.SpeedZone.Speed) do
                                    table.insert(opts, {value = tonumber(v), label = v .. ' mph'})
                                end
                                return opts
                            end)(),
                            required = true,
                            default = 0
                        }
                    })
                    
                    if radiusInput then
                        local radius = radiusInput[1]
                        local speed = radiusInput[2]
                        
                        speedZoneActive = true
                        local coords = GetEntityCoords(GetPlayerPed(-1))
                        
                        local streetName, crossing = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
                        streetName = GetStreetNameFromHashKey(streetName)
                        
                        local message = "^* ^1Traffic Announcement: ^r^*^7Police have ordered that traffic on ^2" .. streetName .. " ^7is to travel at a speed of ^2" .. speed .. "mph ^7due to an incident."
                        TriggerServerEvent('ZoneActivated', message, speed + 0.0, radius + 0.0, coords.x, coords.y, coords.z)
                        
                        lib.notify({
                            title = 'Speed Zone Created',
                            description = 'Speed limit: ' .. speed .. 'mph, Radius: ' .. radius .. 'm',
                            type = 'success'
                        })
                    end
                    
                    openSpeedZoneMenu()
                end
            },
            {
                title = 'Delete Speed Zone',
                description = 'Remove all speed zones',
                icon = 'circle-xmark',
                iconColor = 'red',
                onSelect = function()
                    TriggerServerEvent('Disable')
                    lib.notify({
                        title = 'Corey Scene Menu',
                        description = 'Speed Zones Disabled',
                        type = 'success'
                    })
                    
                    openSpeedZoneMenu()
                end
            }
        }
    })
    
    lib.showContext('speedzone_menu')
end

local function openAdvertsMenu()
    local elements = {}
    
    for k, v in pairs(Config.Adverts) do
        table.insert(elements, {
            title = v.name,
            description = 'Send an advert for ' .. v.name,
            icon = v.icon,
            onSelect = function()
                local input = lib.inputDialog('Send Advertisement', {
                    {
                        type = 'textarea',
                        label = 'Message',
                        description = 'Enter your advertisement message',
                        required = true,
                        min = 1,
                        max = 128
                    }
                })
                
                if input and input[1] then
                    local message = input[1]
                    TriggerServerEvent('SceneMenu:SendAdvert', message, v.name, v.icon)
                    
                    lib.notify({
                        title = 'Advertisement Sent',
                        description = 'Your ' .. v.name .. ' advert has been posted',
                        type = 'success'
                    })
                end
                
                openAdvertsMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'adverts_menu',
        title = 'Advertisements',
        menu = 'main_menu',
        options = elements
    })
    
    lib.showContext('adverts_menu')
end

local function openMainMenu()
    local menuOptions = {
        {
                title = '← Back to Main Menu',
                description = 'Return to unified menu',
                icon = 'arrow-left',
                iconColor = '#95a5a6',
                onSelect = function()
                    ExecuteCommand('menu')
                end
        },
        {
            title = 'Object Menu',
            description = 'Spawn and manage objects',
            icon = 'box',
            onSelect = function()
                openObjectMenu()
            end
        },
        {
            title = 'Speed Zone Menu',
            description = 'Create and manage speed zones',
            icon = 'gauge',
            onSelect = function()
                openSpeedZoneMenu()
            end
        }
    }
    
    -- Add Adverts menu option if enabled
    if Config.ShowAdverts then
        table.insert(menuOptions, {
            title = 'Advertisements',
            description = 'Send business advertisements',
            icon = 'circle',
            iconColor = 'yellow',
            onSelect = function()
                openAdvertsMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'main_menu',
        title = 'Corey Scene Menu',
        options = menuOptions
    })
    
    lib.showContext('main_menu')
end

------------------------
--[[ Menu Activation ]]--
------------------------

local function checkPermission()
    if Config.UsageMode == "Ped" then
        local pmodel = GetEntityModel(PlayerPedId())
        if inArrayPed(pmodel, Config.WhitelistedPeds) then
            return true
        else
            lib.notify({
                title = 'Access Denied',
                description = 'You are not in the correct ped to use this',
                type = 'error'
            })
            return false
        end
    elseif Config.UsageMode == "IP" then
        TriggerServerEvent("GetData", "IP")
        Wait(100)
        if inArray(GlobalData, Config.WhitelistedIPs) then
            return true
        else
            lib.notify({
                title = 'Access Denied',
                description = 'You are not whitelisted to use this',
                type = 'error'
            })
            return false
        end
    elseif Config.UsageMode == "Steam" then
        TriggerServerEvent("GetData", "Steam")
        Wait(100)
        if inArraySteam(GlobalData, Config.WhitelistedSteam) then
            return true
        else
            lib.notify({
                title = 'Access Denied',
                description = 'You are not whitelisted to use this',
                type = 'error'
            })
            return false
        end
    elseif Config.UsageMode == "Everyone" then
        return true
    end
    return false
end

if Config.ActivationMode == "Key" then
    RegisterCommand('+scenemenu', function()
        if checkPermission() then
            openMainMenu()
        end
    end)
    
    RegisterCommand('-scenemenu', function() end)
    
    RegisterKeyMapping('+scenemenu', 'Open Scene Menu', 'keyboard', Config.ActivationKey)
elseif Config.ActivationMode == "Command" then
    RegisterCommand(Config.ActivationCommand, function()
        if checkPermission() then
            openMainMenu()
        end
    end, false)
end

------------------------
--[[ Network Events ]]--
------------------------

RegisterNetEvent('ReturnData')
AddEventHandler('ReturnData', function(data)
    GlobalData = data
end)

RegisterNetEvent('Zone')
AddEventHandler('Zone', function(speed, radius, x, y, z)
    blip = AddBlipForRadius(x, y, z, radius)
    SetBlipColour(blip, 1)
    SetBlipAlpha(blip, 80)
    SetBlipSprite(blip, 9)
    speedZone = AddSpeedZoneForCoord(x, y, z, radius, speed, false)
    
    table.insert(speedzones, {x, y, z, speedZone, blip})
end)

RegisterNetEvent('RemoveBlip')
AddEventHandler('RemoveBlip', function()
    if speedzones == nil or #speedzones == 0 then
        return
    end
    
    local playerPed = GetPlayerPed(-1)
    local coords = GetEntityCoords(playerPed, true)
    local closestSpeedZone = 0
    local closestDistance = 1000
    
    for i = 1, #speedzones, 1 do
        local distance = #(vector3(speedzones[i][1], speedzones[i][2], speedzones[i][3]) - coords)
        if distance < closestDistance then
            closestDistance = distance
            closestSpeedZone = i
        end
    end
    
    if closestSpeedZone > 0 then
        RemoveSpeedZone(speedzones[closestSpeedZone][4])
        RemoveBlip(speedzones[closestSpeedZone][5])
        table.remove(speedzones, closestSpeedZone)
    end
end)

-- Advert notification event
RegisterNetEvent('SceneMenu:ReceiveAdvert')
AddEventHandler('SceneMenu:ReceiveAdvert', function(message, businessName, icon, senderID)
    lib.notify({
        title = 'ADVERT: ' .. businessName,
        description = message,
        icon = 'megaphone',
        type = 'info',
        duration = 10000,
        position = 'top'
    })
end)

--------------------------
--[[ Useful Functions ]]--
--------------------------

function inArrayPed(value, array)
    for _, v in pairs(array) do
        if GetHashKey(v) == value then
            return true
        end
    end
    return false
end

function inArray(value, array)
    for _, v in pairs(array) do
        if v == value then
            return true
        end
    end
    return false
end

function inArraySteam(value, array)
    for _, v in pairs(array) do
        v = getSteamId(v)
        if v == value then
            return true
        end
    end
    return false
end

function isNativeSteamId(steamId)
    if string.sub(steamId, 0, 6) == "steam:" then
        return true
    end
    return false
end

function getSteamId(steamId)
    if not isNativeSteamId(steamId) then
        steamId = "steam:" .. string.format("%x", tonumber(steamId))
    else
        steamId = string.lower(steamId)
    end
    return steamId
end