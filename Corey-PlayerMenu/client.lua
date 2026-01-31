-- Client-side script for Player Options Menu using ox_lib

local playerOptions = {
    godMode = false,
    invisible = false,
    infiniteStamina = false,
    fastRun = false,
    fastSwim = false,
    superJump = false,
    noRagdoll = false,
    neverWanted = false
}

-- Toggle Infinite Stamina
local function toggleInfiniteStamina()
    playerOptions.infiniteStamina = not playerOptions.infiniteStamina
    lib.notify({
        title = 'Infinite Stamina',
        description = playerOptions.infiniteStamina and 'Enabled' or 'Disabled',
        type = playerOptions.infiniteStamina and 'success' or 'inform'
    })
end

-- Toggle Fast Run
local function toggleFastRun()
    playerOptions.fastRun = not playerOptions.fastRun
    if playerOptions.fastRun then
        SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    else
        SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    end
    lib.notify({
        title = 'Fast Run',
        description = playerOptions.fastRun and 'Enabled' or 'Disabled',
        type = playerOptions.fastRun and 'success' or 'inform'
    })
end

-- Toggle Fast Swim
local function toggleFastSwim()
    playerOptions.fastSwim = not playerOptions.fastSwim
    if playerOptions.fastSwim then
        SetSwimMultiplierForPlayer(PlayerId(), 1.49)
    else
        SetSwimMultiplierForPlayer(PlayerId(), 1.0)
    end
    lib.notify({
        title = 'Fast Swim',
        description = playerOptions.fastSwim and 'Enabled' or 'Disabled',
        type = playerOptions.fastSwim and 'success' or 'inform'
    })
end

-- Toggle Super Jump
local function toggleSuperJump()
    playerOptions.superJump = not playerOptions.superJump
    lib.notify({
        title = 'Super Jump',
        description = playerOptions.superJump and 'Enabled' or 'Disabled',
        type = playerOptions.superJump and 'success' or 'inform'
    })
end

-- Toggle No Ragdoll
local function toggleNoRagdoll()
    playerOptions.noRagdoll = not playerOptions.noRagdoll
    lib.notify({
        title = 'No Ragdoll',
        description = playerOptions.noRagdoll and 'Enabled' or 'Disabled',
        type = playerOptions.noRagdoll and 'success' or 'inform'
    })
end

-- Heal Player
local function healPlayer()
    local ped = PlayerPedId()
    SetEntityHealth(ped, GetEntityMaxHealth(ped))
    lib.notify({
        title = 'Player Healed',
        description = 'Health restored to maximum',
        type = 'success'
    })
end

-- Revive Player
local function revivePlayer()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, GetEntityHeading(ped), true, false)
    SetEntityHealth(ped, GetEntityMaxHealth(ped))
    ClearPedTasksImmediately(ped)
    lib.notify({
        title = 'Player Revived',
        description = 'You have been revived',
        type = 'success'
    })
end

-- Clean Player
local function cleanPlayer()
    local ped = PlayerPedId()
    ClearPedBloodDamage(ped)
    ClearPedWetness(ped)
    ClearPedEnvDirt(ped)
    ResetPedVisibleDamage(ped)
    lib.notify({
        title = 'Player Cleaned',
        description = 'All dirt and blood removed',
        type = 'success'
    })
end

-- Armor Options Menu
local function openArmorMenu()
    lib.registerContext({
        id = 'armor_options_menu',
        title = 'Armor Options',
        menu = 'player_options_menu',
        options = {
            {
                title = 'No Armor',
                description = 'Remove all armor (0%)',
                icon = 'xmark',
                iconColor = '#e74c3c',
                onSelect = function()
                    local ped = PlayerPedId()
                    SetPedArmour(ped, 0)
                    lib.notify({
                        title = 'Armor Added',
                        description = 'No Armor equipped (0%)',
                        type = 'success'
                    })
                    openArmorMenu()
                end
            },
            {
                title = 'Light Armor',
                description = 'Basic protection (25%)',
                icon = 'vest',
                iconColor = '#95a5a6',
                onSelect = function()
                    local ped = PlayerPedId()
                    SetPedArmour(ped, 25)
                    lib.notify({
                        title = 'Armor Added',
                        description = 'Light Armor equipped (25%)',
                        type = 'success'
                    })
                    openArmorMenu()
                end
            },
            {
                title = 'Standard Armor',
                description = 'Standard police vest (50%)',
                icon = 'vest',
                iconColor = '#3498db',
                onSelect = function()
                    local ped = PlayerPedId()
                    SetPedArmour(ped, 50)
                    lib.notify({
                        title = 'Armor Added',
                        description = 'Standard Armor equipped (50%)',
                        type = 'success'
                    })
                    openArmorMenu()
                end
            },
            {
                title = 'Heavy Armor',
                description = 'Military grade protection (75%)',
                icon = 'vest-patches',
                iconColor = '#f39c12',
                onSelect = function()
                    local ped = PlayerPedId()
                    SetPedArmour(ped, 75)
                    lib.notify({
                        title = 'Armor Added',
                        description = 'Heavy Armor equipped (75%)',
                        type = 'success'
                    })
                    openArmorMenu()
                end
            },
            {
                title = 'Super Heavy Armor',
                description = 'Maximum protection (100%)',
                icon = 'vest-patches',
                iconColor = '#27ae60',
                onSelect = function()
                    local ped = PlayerPedId()
                    SetPedArmour(ped, 100)
                    lib.notify({
                        title = 'Armor Added',
                        description = 'Super Heavy Armor equipped (100%)',
                        type = 'success'
                    })
                    openArmorMenu()
                end
            },
            {
                title = 'Custom Armor',
                description = 'Enter a custom armor value',
                icon = 'keyboard',
                iconColor = '#9b59b6',
                onSelect = function()
                    local input = lib.inputDialog('Custom Armor', {
                        {type = 'number', label = 'Armor Amount', description = 'Enter armor value (0-100)', required = true, min = 0, max = 100}
                    })
                    
                    if input then
                        local ped = PlayerPedId()
                        SetPedArmour(ped, input[1])
                        lib.notify({
                            title = 'Armor Added',
                            description = 'Custom Armor equipped (' .. input[1] .. '%)',
                            type = 'success'
                        })
                    end
                    openArmorMenu()
                end
            }
        }
    })
    
    lib.showContext('armor_options_menu')
end

-- Main Player Options Menu
function OpenPlayerOptionsMenu()
    lib.registerContext({
        id = 'player_options_menu',
        title = 'Player Options',
        onExit = function()
            -- Optional: Add any cleanup here if needed
        end,
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
                title = 'Heal Player',
                description = 'Restore health to maximum',
                icon = 'heart',
                iconColor = '#ff6b6b',
                onSelect = function()
                    healPlayer()
                    OpenPlayerOptionsMenu()
                end
            },
            {
                title = 'Give Armor',
                description = 'Open armor selection menu',
                icon = 'shield',
                iconColor = '#6c5ce7',
                arrow = true,
                onSelect = openArmorMenu
            },
            {
                title = 'Revive Player',
                description = 'Revive if dead',
                icon = 'heart-pulse',
                iconColor = '#4ecdc4',
                onSelect = function()
                    revivePlayer()
                    OpenPlayerOptionsMenu()
                end
            },
            {
                title = 'Clean Player',
                description = 'Remove blood and dirt',
                icon = 'spray-can',
                iconColor = '#95e1d3',
                onSelect = function()
                    cleanPlayer()
                    OpenPlayerOptionsMenu()
                end
            },
            {
                title = 'Fast Run',
                description = 'Status: ' .. (playerOptions.fastRun and 'Enabled' or 'Disabled'),
                icon = 'person-running',
                iconColor = playerOptions.fastRun and '#00ff00' or '#ff0000',
                onSelect = function()
                    toggleFastRun()
                    OpenPlayerOptionsMenu()
                end
            },
            {
                title = 'Fast Swim',
                description = 'Status: ' .. (playerOptions.fastSwim and 'Enabled' or 'Disabled'),
                icon = 'person-swimming',
                iconColor = playerOptions.fastSwim and '#00ff00' or '#ff0000',
                onSelect = function()
                    toggleFastSwim()
                    OpenPlayerOptionsMenu()
                end
            },
            {
                title = 'No Ragdoll',
                description = 'Status: ' .. (playerOptions.noRagdoll and 'Enabled' or 'Disabled'),
                icon = 'person',
                iconColor = playerOptions.noRagdoll and '#00ff00' or '#ff0000',
                onSelect = function()
                    toggleNoRagdoll()
                    OpenPlayerOptionsMenu()
                end
            }
        }
    })

    lib.showContext('player_options_menu')
end

-- Command to open menu
RegisterCommand('playermenu', function()
    OpenPlayerOptionsMenu()
end, false)

-- Threads for continuous effects
CreateThread(function()
    while true do
        Wait(0)
        
        local ped = PlayerPedId()
        
        -- Infinite Stamina
        if playerOptions.infiniteStamina then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        
        -- Super Jump
        if playerOptions.superJump then
            SetSuperJumpThisFrame(PlayerId())
        end
        
        -- No Ragdoll
        if playerOptions.noRagdoll then
            SetPedCanRagdoll(ped, false)
        end
        
        -- Never Wanted
        if playerOptions.neverWanted then
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
        end
    end
end)