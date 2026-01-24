-- Unified Menu System - Client
-- Links all menu systems together

-- Function to open scene menu (we'll trigger the event that opens it)
local function openSceneMenu()
    -- Call the scene menu directly by triggering its open function
    -- Since scene menu uses +scenemenu command internally, we trigger it
    ExecuteCommand('+scenemenu')
    Wait(50)
    ExecuteCommand('-scenemenu')
end

-- Main Unified Menu
function OpenUnifiedMenu()
    lib.registerContext({
        id = 'unified_main_menu',
        title = 'Corey Menu',
        options = {
            {
                title = 'Player Options',
                description = 'Player health, armor, and abilities',
                icon = 'user',
                iconColor = '#2ecc71',
                onSelect = function()
                    ExecuteCommand('playermenu')
                end
            },
            {
                title = 'Vehicle Options',
                description = 'Vehicle spawner and customization',
                icon = 'car',
                iconColor = '#e74c3c',
                onSelect = function()
                    ExecuteCommand('veh')
                end
            },
            {
                title = 'Misc Options',
                description = 'Noclip, HUD, radar, and coordinates',
                icon = 'sliders',
                iconColor = '#f39c12',
                onSelect = function()
                    ExecuteCommand('misc')
                end
            },
            {
                title = 'Scene Menu',
                description = 'Object spawning, speed zones, and advertisements',
                icon = 'box',
                iconColor = '#3498db',
                onSelect = function()
                    openSceneMenu()
                end
            }
        }
    })
    
    lib.showContext('unified_main_menu')
end

-- Register command to open unified menu
RegisterCommand('menu', function()
    OpenUnifiedMenu()
end, false)

-- Register keybind (F4 by default)
RegisterKeyMapping('menu', 'Open Main Menu', 'keyboard', 'M')
