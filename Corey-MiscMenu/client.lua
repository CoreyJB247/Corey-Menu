-- client.lua
local noclipEnabled = false
local noclipSpeedIndex = 3 -- Default to Normal speed
local hudHidden = false
local radarHidden = false
local isRecording = false

-- Noclip Variables
local heading = 0.0
local coords = vector3(0, 0, 0)

-- Noclip Speed Settings
local noclipSpeeds = {
    {name = "Very Slow", speed = 0.5},
    {name = "Slow", speed = 1.0},
    {name = "Normal", speed = 2.0},
    {name = "Fast", speed = 4.0},
    {name = "Very Fast", speed = 8.0},
    {name = "Extremely Fast", speed = 16.0},
    {name = "Max Speed", speed = 32.0}
}

-- Noclip Keybind
lib.addKeybind({
    name = 'noclip_toggle',
    description = 'Toggle Noclip',
    defaultKey = 'F2',
    onPressed = function()
        ToggleNoclip()
    end,
})

-- Noclip Speed Change Keybind (Shift key while in noclip)
local shiftPressed = false

-- Change Noclip Speed
function ChangeNoclipSpeed(direction)
    noclipSpeedIndex = noclipSpeedIndex + direction
    
    -- Loop around if exceeding bounds
    if noclipSpeedIndex > #noclipSpeeds then
        noclipSpeedIndex = 1
    elseif noclipSpeedIndex < 1 then
        noclipSpeedIndex = #noclipSpeeds
    end
    
    local currentSpeed = noclipSpeeds[noclipSpeedIndex]
    lib.notify({
        title = 'Noclip Speed',
        description = currentSpeed.name,
        type = 'info',
        duration = 4000,
        position = 'top-right'
    })
end

-- Noclip System
function ToggleNoclip()
    noclipEnabled = not noclipEnabled
    local ped = PlayerPedId()
    
    if noclipEnabled then
        local lastSpeedIndex = noclipSpeedIndex
        
        -- Monitor for speed changes and show notification
        CreateThread(function()
            while noclipEnabled do
                local currentSpeed = noclipSpeeds[noclipSpeedIndex]
                
                -- Show notification with short duration that keeps refreshing
                lib.notify({
                    id = 'noclip_notification',
                    title = 'Noclip Enabled',
                    description = 'Speed: ' .. currentSpeed.name .. ' (SHIFT to cycle)',
                    type = 'info',
                    duration = 4000,
                    position = 'top-right'
                })
                
                lastSpeedIndex = noclipSpeedIndex
                Wait(1500) -- Refresh before it expires
            end
        end)
        
        CreateThread(function()
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(ped, false)
            local entity = vehicle > 0 and vehicle or ped
            
            while noclipEnabled do
                Wait(0)
                
                ped = PlayerPedId()
                vehicle = GetVehiclePedIsIn(ped, false)
                entity = vehicle > 0 and vehicle or ped
                
                local currentCoords = GetEntityCoords(entity)
                
                -- Disable controls
                DisableControlAction(0, 30, true) -- MoveLeftRight
                DisableControlAction(0, 31, true) -- MoveUpDown
                DisableControlAction(0, 32, true) -- W
                DisableControlAction(0, 33, true) -- S
                DisableControlAction(0, 34, true) -- A
                DisableControlAction(0, 35, true) -- D
                DisableControlAction(0, 21, true) -- Shift (to prevent sprint)
                DisableControlAction(0, 36, true) -- Ctrl (to prevent crouch)
                
                -- Set entity properties
                SetEntityVelocity(entity, 0.0, 0.0, 0.0)
                SetEntityAlpha(entity, 150, false)
                FreezeEntityPosition(entity, true)
                SetEntityCollision(entity, false, false)
                SetEntityInvincible(entity, true)
                
                -- Check for shift key to cycle speed (must check with IsDisabledControlJustPressed since we disabled it)
                if IsDisabledControlJustPressed(0, 21) then -- Left Shift
                    if not shiftPressed then
                        shiftPressed = true
                        ChangeNoclipSpeed(1)
                    end
                elseif IsDisabledControlJustReleased(0, 21) then
                    shiftPressed = false
                end
                
                -- Get camera rotation
                local camRot = GetGameplayCamRot(2)
                local camHeading = camRot.z
                
                -- Movement speed
                local speed = noclipSpeeds[noclipSpeedIndex].speed
                
                -- Ctrl for slow mode (0.3x) - use IsDisabledControlPressed
                if IsDisabledControlPressed(0, 36) then -- Left Ctrl
                    speed = speed * 0.3
                end
                
                -- Initialize movement vector
                local moveX, moveY, moveZ = 0.0, 0.0, 0.0
                
                -- Convert camera heading to radians (ignore pitch for horizontal movement)
                local radHeading = math.rad(camHeading)
                
                -- Forward/Backward (W/S) - only horizontal movement
                if IsDisabledControlPressed(0, 32) then -- W (Forward)
                    moveX = moveX + (-math.sin(radHeading) * speed)
                    moveY = moveY + (math.cos(radHeading) * speed)
                end
                if IsDisabledControlPressed(0, 33) then -- S (Backward)
                    moveX = moveX - (-math.sin(radHeading) * speed)
                    moveY = moveY - (math.cos(radHeading) * speed)
                end
                
                -- Left/Right (A/D) - use IsDisabledControlPressed
                if IsDisabledControlPressed(0, 34) then -- A (Left)
                    moveX = moveX + (math.cos(radHeading) * speed)
                    moveY = moveY + (math.sin(radHeading) * speed)
                end
                if IsDisabledControlPressed(0, 35) then -- D (Right)
                    moveX = moveX - (math.cos(radHeading) * speed)
                    moveY = moveY - (math.sin(radHeading) * speed)
                end
                
                -- Up/Down (Q/E) - use IsDisabledControlPressed
                if IsDisabledControlPressed(0, 44) then -- Q (Down)
                    moveZ = moveZ - speed
                end
                if IsDisabledControlPressed(0, 38) then -- E (Up)
                    moveZ = moveZ + speed
                end
                
                -- Apply movement
                local newX = currentCoords.x + moveX
                local newY = currentCoords.y + moveY
                local newZ = currentCoords.z + moveZ
                
                -- Set new position and rotation
                SetEntityCoordsNoOffset(entity, newX, newY, newZ, true, true, true)
                SetEntityRotation(entity, 0.0, 0.0, camHeading, 2, true)
                SetEntityHeading(entity, camHeading)
            end
            
            -- Cleanup when noclip is disabled
            FreezeEntityPosition(entity, false)
            SetEntityCollision(entity, true, true)
            SetEntityInvincible(entity, false)
            SetEntityAlpha(entity, 255, false)
        end)
    else
        -- Show disabled notification
        lib.notify({
            title = 'Noclip',
            description = 'Disabled',
            type = 'error'
        })
    end
end

-- Toggle HUD
local function ToggleHUD()
    hudHidden = not hudHidden
    DisplayHud(not hudHidden)
    
    lib.notify({
        title = 'HUD',
        description = hudHidden and 'HUD hidden' or 'HUD shown',
        type = hudHidden and 'error' or 'success'
    })
    
    -- Reopen the menu after toggling
    OpenMiscMenu()
end

-- Toggle Radar
local function ToggleRadar()
    radarHidden = not radarHidden
    DisplayRadar(not radarHidden)
    
    lib.notify({
        title = 'Radar',
        description = radarHidden and 'Radar hidden' or 'Radar shown',
        type = radarHidden and 'error' or 'success'
    })
    
    -- Reopen the menu after toggling
    OpenMiscMenu()
end

-- Rockstar Editor Recording Functions
local function StartEditorRecording()
    if isRecording then
        lib.notify({
            title = 'Recording',
            description = 'Already recording',
            type = 'error'
        })
        OpenMiscMenu()
        return
    end
    
    StartRecording(1) -- Native function - Start recording with mode 1
    isRecording = true
    
    lib.notify({
        title = 'Rockstar Editor',
        description = 'Recording started',
        type = 'success'
    })
    
    OpenMiscMenu()
end

local function StopEditorRecording()
    if not isRecording then
        lib.notify({
            title = 'Recording',
            description = 'Not currently recording',
            type = 'error'
        })
        OpenMiscMenu()
        return
    end
    
    StopRecordingAndSaveClip() -- Native function - Stop and save the recording
    isRecording = false
    
    lib.notify({
        title = 'Rockstar Editor',
        description = 'Recording stopped and saved',
        type = 'success'
    })
    
    OpenMiscMenu()
end

local function ToggleRecording()
    if isRecording then
        StopEditorRecording()
    else
        StartEditorRecording()
    end
end

-- Teleport to Waypoint
local function TeleportToWaypoint()
    local waypoint = GetFirstBlipInfoId(8) -- 8 is the blip type for waypoint
    
    if not DoesBlipExist(waypoint) then
        lib.notify({
            title = 'Teleport Failed',
            description = 'No waypoint set on the map',
            type = 'error'
        })
        OpenMiscMenu()
        return
    end
    
    local waypointCoords = GetBlipInfoIdCoord(waypoint)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    local entity = vehicle > 0 and vehicle or ped
    
    -- Get ground Z coordinate
    local groundFound = false
    local groundZ = 0.0
    
    -- Start at a high Z position and work down
    for i = 1000, 0, -50 do
        RequestCollisionAtCoord(waypointCoords.x, waypointCoords.y, i)
        Wait(0)
        groundFound, groundZ = GetGroundZFor_3dCoord(waypointCoords.x, waypointCoords.y, i, false)
        
        if groundFound then
            break
        end
    end
    
    -- If still not found, use waypoint Z or add some height
    if not groundFound then
        groundZ = waypointCoords.z + 1.0
    end
    
    -- Teleport entity
    SetEntityCoords(entity, waypointCoords.x, waypointCoords.y, groundZ + 1.0, false, false, false, true)
    
    lib.notify({
        title = 'Teleported',
        description = 'Teleported to waypoint',
        type = 'success'
    })
    
    -- Reopen the menu after teleporting
    OpenMiscMenu()
end

-- Copy Coordinates Functions
local function CopyVec3()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local formattedCoords = string.format("vector3(%.2f, %.2f, %.2f)", coords.x, coords.y, coords.z)
    
    lib.setClipboard(formattedCoords)
    lib.notify({
        title = 'Coordinates Copied',
        description = formattedCoords,
        type = 'success',
        duration = 5000
    })
    
    -- Reopen the coords menu after copying
    OpenCoordsMenu()
end

local function CopyVec4()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    local formattedCoords = string.format("vector4(%.2f, %.2f, %.2f, %.2f)", coords.x, coords.y, coords.z, heading)
    
    lib.setClipboard(formattedCoords)
    lib.notify({
        title = 'Coordinates Copied',
        description = formattedCoords,
        type = 'success',
        duration = 5000
    })
    
    -- Reopen the coords menu after copying
    OpenCoordsMenu()
end

local function CopyCoords()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local formattedCoords = string.format("%.2f, %.2f, %.2f", coords.x, coords.y, coords.z)
    
    lib.setClipboard(formattedCoords)
    lib.notify({
        title = 'Coordinates Copied',
        description = formattedCoords,
        type = 'success',
        duration = 5000
    })
    
    -- Reopen the coords menu after copying
    OpenCoordsMenu()
end

local function CopyHeading()
    local ped = PlayerPedId()
    local heading = GetEntityHeading(ped)
    local formattedHeading = string.format("%.2f", heading)
    
    lib.setClipboard(formattedHeading)
    lib.notify({
        title = 'Heading Copied',
        description = formattedHeading,
        type = 'success',
        duration = 5000
    })
    
    -- Reopen the coords menu after copying
    OpenCoordsMenu()
end

-- Coords Menu (separate function for reopening)
function OpenCoordsMenu()
    lib.registerContext({
        id = 'coords_menu',
        title = 'Copy Coordinates',
        menu = 'misc_menu',
        options = {
            {
                title = 'Copy vec3',
                description = 'Copy as vector3(x, y, z)',
                icon = 'copy',
                onSelect = function()
                    CopyVec3()
                end
            },
            {
                title = 'Copy vec4',
                description = 'Copy as vector4(x, y, z, heading)',
                icon = 'copy',
                onSelect = function()
                    CopyVec4()
                end
            },
            {
                title = 'Copy x, y, z',
                description = 'Copy as x, y, z',
                icon = 'copy',
                onSelect = function()
                    CopyCoords()
                end
            },
            {
                title = 'Copy Heading',
                description = 'Copy heading only',
                icon = 'compass',
                onSelect = function()
                    CopyHeading()
                end
            }
        }
    })
    
    lib.showContext('coords_menu')
end

-- Noclip Speed Menu
local function OpenNoclipSpeedMenu()
    local options = {}
    
    for i, speedData in ipairs(noclipSpeeds) do
        table.insert(options, {
            title = speedData.name,
            description = 'Speed: ' .. speedData.speed,
            icon = 'gauge',
            iconColor = i == noclipSpeedIndex and '#00ff00' or '#ffffff',
            onSelect = function()
                noclipSpeedIndex = i
                lib.notify({
                    title = 'Noclip Speed',
                    description = 'Set to ' .. speedData.name,
                    type = 'success'
                })
                -- Reopen the speed menu after selecting
                OpenNoclipSpeedMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'noclip_speed_menu',
        title = 'Noclip Speed',
        menu = 'misc_menu',
        options = options
    })
    
    lib.showContext('noclip_speed_menu')
end

-- Main Misc Menu
function OpenMiscMenu()
    -- Register coords menu first before the main menu references it
    lib.registerContext({
        id = 'coords_menu',
        title = 'Copy Coordinates',
        menu = 'misc_menu',
        options = {
            {
                title = 'Copy vec3',
                description = 'Copy as vector3(x, y, z)',
                icon = 'copy',
                onSelect = function()
                    CopyVec3()
                end
            },
            {
                title = 'Copy vec4',
                description = 'Copy as vector4(x, y, z, heading)',
                icon = 'copy',
                onSelect = function()
                    CopyVec4()
                end
            },
            {
                title = 'Copy x, y, z',
                description = 'Copy as x, y, z',
                icon = 'copy',
                onSelect = function()
                    CopyCoords()
                end
            },
            {
                title = 'Copy Heading',
                description = 'Copy heading only',
                icon = 'compass',
                onSelect = function()
                    CopyHeading()
                end
            }
        }
    })

    lib.registerContext({
        id = 'misc_menu',
        title = 'Misc Options',
        options = {
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
                title = 'Noclip',
                description = 'Toggle noclip mode (F2)',
                icon = 'plane',
                iconColor = noclipEnabled and '#00ff00' or '#ffffff',
                onSelect = function()
                    ToggleNoclip()
                    -- Reopen the menu after toggling
                    OpenMiscMenu()
                end
            },
            {
                title = 'Noclip Speed',
                description = 'Current: ' .. noclipSpeeds[noclipSpeedIndex].name .. ' (Press SHIFT in noclip)',
                icon = 'gauge-high',
                onSelect = function()
                    OpenNoclipSpeedMenu()
                end
            },
            {
                title = 'Toggle HUD',
                description = hudHidden and 'Show HUD' or 'Hide HUD',
                icon = 'eye',
                iconColor = hudHidden and '#ff0000' or '#00ff00',
                onSelect = function()
                    ToggleHUD()
                end
            },
            {
                title = 'Toggle Radar',
                description = radarHidden and 'Show Radar' or 'Hide Radar',
                icon = 'map',
                iconColor = radarHidden and '#ff0000' or '#00ff00',
                onSelect = function()
                    ToggleRadar()
                end
            },
            {
                title = 'Toggle RHUD',
                description = 'Toggle the hud system',
                icon = 'eye',
                onSelect = function()
                    ExecuteCommand('rhud')
                    OpenMiscMenu()
                end
            },
            {
                title = 'Configure RHUD',
                description = 'Configure the hud system',
                icon = 'gear',
                onSelect = function()
                    ExecuteCommand('rhud config')
                    OpenMiscMenu()
                end
            },
            {
                title = 'Rockstar Editor',
                description = isRecording and 'Stop Recording' or 'Start Recording',
                icon = 'video',
                iconColor = isRecording and '#ff0000' or '#ffffff',
                onSelect = function()
                    ToggleRecording()
                end
            },
            {
                title = 'Copy Coordinates',
                icon = 'location-dot',
                menu = 'coords_menu'
            },
            {
                title = 'Teleport to Waypoint',
                description = 'Teleport to your map waypoint',
                icon = 'location-crosshairs',
                onSelect = function()
                    TeleportToWaypoint()
                end
            }
        }
    })
    
    lib.showContext('misc_menu')
end

-- Command to open menu
RegisterCommand('misc', function()
    OpenMiscMenu()
end, false)
