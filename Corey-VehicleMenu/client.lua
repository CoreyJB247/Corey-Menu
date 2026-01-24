-- client.lua
local replaceVehicle = true
local savedVehicles = {}

CreateThread(function()
    local loaded = GetResourceKvpString('vehicle_menu_saved_vehicles')
    if loaded then
        savedVehicles = json.decode(loaded) or {}
        print('[Vehicle Menu] Loaded ' .. #savedVehicles .. ' saved vehicles')
    end
end)

local function SaveVehiclesToKVP()
    SetResourceKvp('vehicle_menu_saved_vehicles', json.encode(savedVehicles))
end

local vehicles = {
    {
        category = "Super", 
        icon = "gauge-high", 
        iconColor = "#FF00FF", 
        models = {
            {model = "adder", name = "Adder"},
            {model = "autarch", name = "Autarch"},
            {model = "banshee2", name = "Banshee 900R"},
            {model = "bullet", name = "Bullet"},
            {model = "cheetah", name = "Cheetah"},
            {model = "cyclone", name = "Cyclone"},
            {model = "entityxf", name = "Entity XF"},
            {model = "fmj", name = "FMJ"},
            {model = "infernus", name = "Infernus"},
            {model = "italigtb", name = "Itali GTB"},
            {model = "nero", name = "Nero"},
            {model = "osiris", name = "Osiris"},
            {model = "pfister811", name = "Pfister 811"},
            {model = "reaper", name = "Reaper"},
            {model = "sc1", name = "SC1"},
            {model = "sultanrs", name = "Sultan RS"},
            {model = "t20", name = "T20"},
            {model = "turismor", name = "Turismo R"},
            {model = "tyrus", name = "Tyrus"},
            {model = "vacca", name = "Vacca"},
            {model = "visione", name = "Visione"},
            {model = "voltic", name = "Voltic"},
            {model = "zentorno", name = "Zentorno"}
        }
    },
    {
        category = "Sports", 
        icon = "flag-checkered", 
        iconColor = "#FF4500", 
        models = {
            {model = "alpha", name = "Alpha"},
            {model = "banshee", name = "Banshee"},
            {model = "bestiagts", name = "Bestia GTS"},
            {model = "blista2", name = "Blista Compact"},
            {model = "buffalo", name = "Buffalo"},
            {model = "buffalo2", name = "Buffalo S"},
            {model = "carbonizzare", name = "Carbonizzare"},
            {model = "comet2", name = "Comet"},
            {model = "coquette", name = "Coquette"},
            {model = "elegy", name = "Elegy RH8"},
            {model = "elegy2", name = "Elegy Retro"},
            {model = "feltzer2", name = "Feltzer"},
            {model = "furoregt", name = "Furore GT"},
            {model = "fusilade", name = "Fusilade"},
            {model = "futo", name = "Futo"},
            {model = "jester", name = "Jester"},
            {model = "khamelion", name = "Khamelion"},
            {model = "kuruma", name = "Kuruma"},
            {model = "lynx", name = "Lynx"},
            {model = "massacro", name = "Massacro"},
            {model = "ninef", name = "9F"},
            {model = "penumbra", name = "Penumbra"},
            {model = "raiden", name = "Raiden"},
            {model = "rapidgt", name = "Rapid GT"},
            {model = "raptor", name = "Raptor"},
            {model = "revolter", name = "Revolter"},
            {model = "schafter3", name = "Schafter V12"},
            {model = "seven70", name = "Seven-70"},
            {model = "specter", name = "Specter"},
            {model = "surano", name = "Surano"}
        }
    },
    {
        category = "Sedans", 
        icon = "car", 
        iconColor = "#4169E1", 
        models = {
            {model = "asea", name = "Asea"},
            {model = "asterope", name = "Asterope"},
            {model = "cog55", name = "Cognoscenti 55"},
            {model = "cognoscenti", name = "Cognoscenti"},
            {model = "emperor", name = "Emperor"},
            {model = "fugitive", name = "Fugitive"},
            {model = "glendale", name = "Glendale"},
            {model = "ingot", name = "Ingot"},
            {model = "intruder", name = "Intruder"},
            {model = "premier", name = "Premier"},
            {model = "primo", name = "Primo"},
            {model = "primo2", name = "Primo Custom"},
            {model = "regina", name = "Regina"},
            {model = "schafter2", name = "Schafter"},
            {model = "stanier", name = "Stanier"},
            {model = "stratum", name = "Stratum"},
            {model = "stretch", name = "Stretch"},
            {model = "superd", name = "Super Diamond"},
            {model = "surge", name = "Surge"},
            {model = "tailgater", name = "Tailgater"},
            {model = "warrener", name = "Warrener"},
            {model = "washington", name = "Washington"}
        }
    },
    {
        category = "SUVs", 
        icon = "truck", 
        iconColor = "#228B22", 
        models = {
            {model = "baller", name = "Baller"},
            {model = "baller2", name = "Baller LE"},
            {model = "cavalcade", name = "Cavalcade"},
            {model = "cavalcade2", name = "Cavalcade II"},
            {model = "dubsta", name = "Dubsta"},
            {model = "dubsta2", name = "Dubsta 2"},
            {model = "fq2", name = "FQ 2"},
            {model = "granger", name = "Granger"},
            {model = "gresley", name = "Gresley"},
            {model = "habanero", name = "Habanero"},
            {model = "huntley", name = "Huntley S"},
            {model = "landstalker", name = "Landstalker"},
            {model = "mesa", name = "Mesa"},
            {model = "patriot", name = "Patriot"},
            {model = "radi", name = "Radius"},
            {model = "rocoto", name = "Rocoto"},
            {model = "seminole", name = "Seminole"},
            {model = "serrano", name = "Serrano"},
            {model = "xls", name = "XLS"}
        }
    },
    {
        category = "Coupes", 
        icon = "gem", 
        iconColor = "#DAA520", 
        models = {
            {model = "cogcabrio", name = "Cognoscenti Cabrio"},
            {model = "exemplar", name = "Exemplar"},
            {model = "f620", name = "F620"},
            {model = "felon", name = "Felon"},
            {model = "felon2", name = "Felon GT"},
            {model = "jackal", name = "Jackal"},
            {model = "oracle", name = "Oracle"},
            {model = "oracle2", name = "Oracle XS"},
            {model = "sentinel", name = "Sentinel"},
            {model = "sentinel2", name = "Sentinel XS"},
            {model = "windsor", name = "Windsor"},
            {model = "windsor2", name = "Windsor Drop"},
            {model = "zion", name = "Zion"},
            {model = "zion2", name = "Zion Cabrio"}
        }
    },
    {
        category = "Muscle", 
        icon = "fire", 
        iconColor = "#DC143C", 
        models = {
            {model = "blade", name = "Blade"},
            {model = "buccaneer", name = "Buccaneer"},
            {model = "buccaneer2", name = "Buccaneer Custom"},
            {model = "chino", name = "Chino"},
            {model = "chino2", name = "Chino Custom"},
            {model = "clique", name = "Clique"},
            {model = "coquette3", name = "Coquette BlackFin"},
            {model = "deviant", name = "Deviant"},
            {model = "dominator", name = "Dominator"},
            {model = "dominator2", name = "Dominator GTX"},
            {model = "dukes", name = "Dukes"},
            {model = "gauntlet", name = "Gauntlet"},
            {model = "gauntlet2", name = "Gauntlet Classic"},
            {model = "hermes", name = "Hermes"},
            {model = "hotknife", name = "Hotknife"},
            {model = "faction", name = "Faction"},
            {model = "faction2", name = "Faction Custom"},
            {model = "nightshade", name = "Nightshade"},
            {model = "phoenix", name = "Phoenix"},
            {model = "picador", name = "Picador"},
            {model = "ratloader", name = "Rat-Loader"},
            {model = "ruiner", name = "Ruiner"},
            {model = "sabregt", name = "Sabre Turbo"},
            {model = "slamvan", name = "Slamvan"},
            {model = "slamvan2", name = "Lost Slamvan"},
            {model = "stalion", name = "Stallion"},
            {model = "tampa", name = "Tampa"},
            {model = "vigero", name = "Vigero"},
            {model = "virgo", name = "Virgo"},
            {model = "voodoo", name = "Voodoo"},
            {model = "yosemite", name = "Yosemite"}
        }
    },
    {
        category = "Off-Road", 
        icon = "mountain", 
        iconColor = "#8B4513", 
        models = {
            {model = "bfinjection", name = "BF Injection"},
            {model = "bifta", name = "Bifta"},
            {model = "blazer", name = "Blazer"},
            {model = "brawler", name = "Brawler"},
            {model = "dubsta3", name = "Dubsta 6x6"},
            {model = "dune", name = "Dune Buggy"},
            {model = "guardian", name = "Guardian"},
            {model = "insurgent", name = "Insurgent"},
            {model = "insurgent2", name = "Insurgent Pick-Up"},
            {model = "kalahari", name = "Kalahari"},
            {model = "kamacho", name = "Kamacho"},
            {model = "marshall", name = "Marshall"},
            {model = "mesa3", name = "Mesa (Off-Road)"},
            {model = "monster", name = "Monster Truck"},
            {model = "rancher", name = "Rancher XL"},
            {model = "rebel", name = "Rebel"},
            {model = "rebel2", name = "Rusty Rebel"},
            {model = "riata", name = "Riata"},
            {model = "sandking", name = "Sandking XL"},
            {model = "sandking2", name = "Sandking SWB"},
            {model = "technical", name = "Technical"},
            {model = "trophytruck", name = "Trophy Truck"},
            {model = "trophytruck2", name = "Desert Raid"}
        }
    },
    {
        category = "Vans", 
        icon = "van-shuttle", 
        iconColor = "#696969", 
        models = {
            {model = "bison", name = "Bison"},
            {model = "bobcatxl", name = "Bobcat XL"},
            {model = "boxville", name = "Boxville"},
            {model = "burrito", name = "Burrito"},
            {model = "burrito2", name = "Burrito (Gang)"},
            {model = "burrito3", name = "Burrito (Snow)"},
            {model = "gburrito", name = "Gang Burrito"},
            {model = "gburrito2", name = "Gang Burrito 2"},
            {model = "minivan", name = "Minivan"},
            {model = "minivan2", name = "Minivan Custom"},
            {model = "paradise", name = "Paradise"},
            {model = "pony", name = "Pony"},
            {model = "pony2", name = "Pony (Weed)"},
            {model = "rumpo", name = "Rumpo"},
            {model = "rumpo2", name = "Rumpo (Deludamol)"},
            {model = "rumpo3", name = "Rumpo Custom"},
            {model = "speedo", name = "Speedo"},
            {model = "speedo2", name = "Speedo (Clown)"},
            {model = "surfer", name = "Surfer"},
            {model = "surfer2", name = "Surfer (Rusty)"},
            {model = "taco", name = "Taco Van"},
            {model = "youga", name = "Youga"},
            {model = "youga2", name = "Youga Classic"}
        }
    },
    {
        category = "Motorcycles", 
        icon = "motorcycle", 
        iconColor = "#FF6347", 
        models = {
            {model = "akuma", name = "Akuma"},
            {model = "avarus", name = "Avarus"},
            {model = "bagger", name = "Bagger"},
            {model = "bati", name = "Bati 801"},
            {model = "bati2", name = "Bati 801RR"},
            {model = "bf400", name = "BF400"},
            {model = "carbonrs", name = "Carbon RS"},
            {model = "chimera", name = "Chimera"},
            {model = "cliffhanger", name = "Cliffhanger"},
            {model = "daemon", name = "Daemon"},
            {model = "daemon2", name = "Daemon Custom"},
            {model = "defiler", name = "Defiler"},
            {model = "diablous", name = "Diabolus"},
            {model = "diablous2", name = "Diabolus Custom"},
            {model = "double", name = "Double T"},
            {model = "enduro", name = "Enduro"},
            {model = "esskey", name = "Esskey"},
            {model = "faggio", name = "Faggio"},
            {model = "faggio2", name = "Faggio Sport"},
            {model = "faggio3", name = "Faggio Mod"},
            {model = "gargoyle", name = "Gargoyle"},
            {model = "hakuchou", name = "Hakuchou"},
            {model = "hakuchou2", name = "Hakuchou Drag"},
            {model = "hexer", name = "Hexer"},
            {model = "innovation", name = "Innovation"},
            {model = "lectro", name = "Lectro"},
            {model = "manchez", name = "Manchez"},
            {model = "nemesis", name = "Nemesis"},
            {model = "nightblade", name = "Nightblade"},
            {model = "pcj", name = "PCJ 600"},
            {model = "ratbike", name = "Rat Bike"},
            {model = "ruffian", name = "Ruffian"},
            {model = "sanchez", name = "Sanchez"},
            {model = "sanchez2", name = "Sanchez (Livery)"},
            {model = "sanctus", name = "Sanctus"},
            {model = "shotaro", name = "Shotaro"},
            {model = "sovereign", name = "Sovereign"},
            {model = "thrust", name = "Thrust"},
            {model = "vader", name = "Vader"},
            {model = "vindicator", name = "Vindicator"},
            {model = "vortex", name = "Vortex"},
            {model = "wolfsbane", name = "Wolfsbane"},
            {model = "zombiea", name = "Zombie Bobber"},
            {model = "zombieb", name = "Zombie Chopper"}
        }
    }
}

-- Emergency vehicles with subcategories
local emergencyVehicles = {
    {
        subcategory = "Blaine County Sheriffs Office",
        icon = "shield-halved",
        vehicles = {
            {model = "socharger2", name = "BCSO 2023 Dodge Charger"},
            {model = "socharger", name = "BCSO 2014 Dodge Charger"},
            {model = "sodurango", name = "BCSO 2022 Dodge Durango"},
            {model = "sofpiu", name = "BCSO 2021 Ford FPIU"},
            {model = "sotruck", name = "BCSO 2018 Ford F-150"},
            {model = "sotaurus", name = "BCSO 2018 Ford Taurus"},
            {model = "sotahoe", name = "BCSO 2024 Chevy Tahoe"}
        }
    },
    {
    subcategory = "Los Santos Police Department",
    icon = "shield-halved",
    vehicles = {
        {model = "rav4hyb", name = "LSPD Detective 2024 Toyota Rav4"},
        {model = "25umfpiu", name = "LSPD Detective 2025 Ford Explorer"},
        {model = "umdet1", name = "LSPD Detective 2022 Dodge Durango"},
        {model = "pdfpiu", name = "LSPD 2023 Ford FPIU"},
        {model = "pdbike", name = "LSPD 2016 BMW R1200RT"},
        {model = "pdcvpi", name = "LSPD 2011 Ford CVPI"},
        {model = "pdtaurus", name = "LSPD 2018 Ford Taurus"},
        {model = "pdcharger", name = "LSPD 2021 Dodge Charger"},
        {model = "pdimpala", name = "LSPD 2011 Chevy Impala"},
        {model = "pdcaprice", name = "LSPD 2013 Chevy Caprice"},
        {model = "pdtahoe", name = "LSPD 2021 Chevy Tahoe"},
        {model = "pdtruck", name = "LSPD 2023 Chevy Silverado"}
    }
    },
    {
    subcategory = "San Andreas Highway Patrol",
    icon = "shield-halved",
    vehicles = {
        {model = "hpcharger", name = "SAHP 2022 Dodge Charger"}
    }
    },
    {
        subcategory = "San Andreas Fire Rescue",
        icon = "fire-extinguisher",
        vehicles = {
            {model = "fordambo", name = "SAFR Ford F-250 Ambulance"}
        }
    }
}

local function SpawnVehicle(model, savedData, keepMenuOpen, menuCallback)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    local currentVehicle = GetVehiclePedIsIn(ped, false)
    
    if replaceVehicle and currentVehicle ~= 0 then
        SetEntityAsMissionEntity(currentVehicle, true, true)
        DeleteEntity(currentVehicle)
    end
    
    local hash = GetHashKey(model)
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(0) end
    
    local spawnCoords = coords
    local groundFound, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, coords.z, false)
    if groundFound then
        spawnCoords = vector3(coords.x, coords.y, groundZ + 1.0)
    end
    
    local vehicle = CreateVehicle(hash, spawnCoords.x, spawnCoords.y, spawnCoords.z, heading, true, false)
    SetVehicleOnGroundProperly(vehicle)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetModelAsNoLongerNeeded(hash)
    SetVehRadioStation(vehicle, 'OFF')
    
    if savedData then
        SetVehicleModKit(vehicle, 0)
        if savedData.colors then
            SetVehicleColours(vehicle, savedData.colors.primary, savedData.colors.secondary)
        end
        if savedData.livery then
            SetVehicleLivery(vehicle, savedData.livery)
        end
        if savedData.plate then
            SetVehicleNumberPlateText(vehicle, savedData.plate)
        end
        if savedData.plateIndex then
            SetVehicleNumberPlateTextIndex(vehicle, savedData.plateIndex)
        end
        if savedData.mods then
            for modType, modValue in pairs(savedData.mods) do
                SetVehicleMod(vehicle, tonumber(modType), modValue, false)
            end
        end
        if savedData.windowTint then
            SetVehicleWindowTint(vehicle, savedData.windowTint)
        end
        if savedData.turbo then
            ToggleVehicleMod(vehicle, 18, true)
        end
        if savedData.extras then
            for extraId, state in pairs(savedData.extras) do
                SetVehicleExtra(vehicle, tonumber(extraId), state and 0 or 1)
            end
        end
    end
    
    TaskWarpPedIntoVehicle(ped, vehicle, -1)
    lib.notify({title = 'Vehicle Spawned', description = model:upper(), type = 'success'})
    
    if keepMenuOpen and menuCallback then
        menuCallback()
    end
end

local function SaveCurrentVehicle()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local categoryOptions = {
        {value = 'personal', label = 'Personal'},
        {value = 'work', label = 'Work'},
        {value = 'emergency', label = 'Emergency'},
        {value = 'favorites', label = 'Favorites'}
    }
    
    local input = lib.inputDialog('Save Vehicle', {
        {type = 'input', label = 'Vehicle Name', required = true, min = 1, max = 30},
        {type = 'select', label = 'Category', options = categoryOptions, required = true, default = 'personal'}
    })
    
    if not input then return end
    
    local model = GetEntityModel(vehicle)
    local modelName = GetDisplayNameFromVehicleModel(model):lower()
    
    local vehicleData = {
        model = modelName,
        category = input[2],
        colors = {
            primary = select(1, GetVehicleColours(vehicle)),
            secondary = select(2, GetVehicleColours(vehicle))
        },
        livery = GetVehicleLivery(vehicle),
        plate = GetVehicleNumberPlateText(vehicle),
        plateIndex = GetVehicleNumberPlateTextIndex(vehicle),
        mods = {},
        windowTint = GetVehicleWindowTint(vehicle),
        turbo = IsToggleModOn(vehicle, 18),
        extras = {}
    }
    
    SetVehicleModKit(vehicle, 0)
    for i = 0, 49 do
        local modValue = GetVehicleMod(vehicle, i)
        if modValue ~= -1 then
            vehicleData.mods[tostring(i)] = modValue
        end
    end
    
    -- Save extras (0-14 covers most vehicle extras)
    for i = 0, 14 do
        if DoesExtraExist(vehicle, i) then
            vehicleData.extras[tostring(i)] = IsVehicleExtraTurnedOn(vehicle, i)
        end
    end
    
    table.insert(savedVehicles, {name = input[1], data = vehicleData})
    SaveVehiclesToKVP()
    
    lib.notify({title = 'Vehicle Saved', description = input[1], type = 'success'})
    openSavedVehiclesMenu()
end

-- New function to change category of a saved vehicle
local function ChangeSavedVehicleCategory(vehicleIndex, categoryId, categoryName)
    local categoryOptions = {
        {value = 'personal', label = 'Personal'},
        {value = 'work', label = 'Work'},
        {value = 'racing', label = 'Racing'},
        {value = 'offroad', label = 'Off-Road'},
        {value = 'luxury', label = 'Luxury'},
        {value = 'emergency', label = 'Emergency'},
        {value = 'utility', label = 'Utility'},
        {value = 'custom', label = 'Custom'},
        {value = 'favorites', label = 'Favorites'},
        {value = 'other', label = 'Other'}
    }
    
    local input = lib.inputDialog('Change Category', {
        {type = 'select', label = 'New Category', options = categoryOptions, required = true, default = savedVehicles[vehicleIndex].data.category}
    })
    
    if input then
        savedVehicles[vehicleIndex].data.category = input[1]
        SaveVehiclesToKVP()
        lib.notify({title = 'Category Updated', description = 'Changed to ' .. input[1], type = 'success'})
        openCategoryVehiclesMenu(categoryId, categoryName)
    else
        openSavedVehicleOptionsMenu(vehicleIndex, categoryId, categoryName)
    end
end

-- New function to replace saved vehicle with current
local function ReplaceSavedVehicle(vehicleIndex, categoryId, categoryName)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        openSavedVehicleOptionsMenu(vehicleIndex, categoryId, categoryName)
        return
    end
    
    local alert = lib.alertDialog({
        header = 'Replace Vehicle?',
        content = 'Replace "' .. savedVehicles[vehicleIndex].name .. '" with current vehicle?',
        centered = true,
        cancel = true
    })
    
    if alert == 'confirm' then
        local model = GetEntityModel(vehicle)
        local modelName = GetDisplayNameFromVehicleModel(model):lower()
        
        local vehicleData = {
            model = modelName,
            category = savedVehicles[vehicleIndex].data.category,
            colors = {
                primary = select(1, GetVehicleColours(vehicle)),
                secondary = select(2, GetVehicleColours(vehicle))
            },
            livery = GetVehicleLivery(vehicle),
            plate = GetVehicleNumberPlateText(vehicle),
            plateIndex = GetVehicleNumberPlateTextIndex(vehicle),
            mods = {},
            windowTint = GetVehicleWindowTint(vehicle),
            turbo = IsToggleModOn(vehicle, 18),
            extras = {}
        }
        
        SetVehicleModKit(vehicle, 0)
        for i = 0, 49 do
            local modValue = GetVehicleMod(vehicle, i)
            if modValue ~= -1 then
                vehicleData.mods[tostring(i)] = modValue
            end
        end
        
        -- Save extras (0-14 covers most vehicle extras)
        for i = 0, 14 do
            if DoesExtraExist(vehicle, i) then
                vehicleData.extras[tostring(i)] = IsVehicleExtraTurnedOn(vehicle, i)
            end
        end
        
        savedVehicles[vehicleIndex].data = vehicleData
        SaveVehiclesToKVP()
        
        lib.notify({title = 'Vehicle Replaced', description = savedVehicles[vehicleIndex].name, type = 'success'})
        openCategoryVehiclesMenu(categoryId, categoryName)
    else
        openSavedVehicleOptionsMenu(vehicleIndex, categoryId, categoryName)
    end
end

-- New function to show options for a saved vehicle
local function openSavedVehicleOptionsMenu(vehicleIndex, categoryId, categoryName)
    local saved = savedVehicles[vehicleIndex]
    
    local options = {
        {
            title = 'Spawn Vehicle',
            description = 'Spawn ' .. saved.name,
            icon = 'car',
            iconColor = '#00ff00',
            onSelect = function()
                SpawnVehicle(saved.data.model, saved.data, true, function()
                    openSavedVehicleOptionsMenu(vehicleIndex, categoryId, categoryName)
                end)
            end
        },
        {
            title = 'Replace with Current',
            description = 'Update saved vehicle data',
            icon = 'rotate',
            iconColor = '#1E90FF',
            onSelect = function()
                ReplaceSavedVehicle(vehicleIndex, categoryId, categoryName)
            end
        },
        {
            title = 'Change Category',
            description = 'Current: ' .. saved.data.category,
            icon = 'folder',
            iconColor = '#FFA500',
            onSelect = function()
                ChangeSavedVehicleCategory(vehicleIndex, categoryId, categoryName)
            end
        },
        {
            title = 'Delete Vehicle',
            description = 'Cannot be undone',
            icon = 'trash',
            iconColor = '#ff0000',
            onSelect = function()
                local alert = lib.alertDialog({
                    header = 'Delete Vehicle?',
                    content = 'Delete "' .. saved.name .. '"?',
                    centered = true,
                    cancel = true
                })
                
                if alert == 'confirm' then
                    table.remove(savedVehicles, vehicleIndex)
                    SaveVehiclesToKVP()
                    lib.notify({title = 'Vehicle Deleted', description = saved.name, type = 'success'})
                    openCategoryVehiclesMenu(categoryId, categoryName)
                else
                    openSavedVehicleOptionsMenu(vehicleIndex, categoryId, categoryName)
                end
            end
        }
    }
    
    lib.registerContext({
        id = 'saved_vehicle_options_menu',
        title = saved.name,
        menu = 'category_vehicles_menu',
        options = options
    })
    lib.showContext('saved_vehicle_options_menu')
end

local function openCategoryVehiclesMenu(categoryId, categoryName)
    local options = {}
    local categoryVehicles = {}
    
    if categoryId == 'all' then
        categoryVehicles = savedVehicles
    else
        for _, saved in ipairs(savedVehicles) do
            if saved.data.category == categoryId then
                table.insert(categoryVehicles, saved)
            end
        end
    end
    
    if #categoryVehicles == 0 then
        table.insert(options, {
            title = 'No Vehicles',
            icon = 'circle-xmark',
            disabled = true
        })
    else
        for i, saved in ipairs(categoryVehicles) do
            local actualIndex = 0
            for j, v in ipairs(savedVehicles) do
                if v.name == saved.name and v.data.model == saved.data.model then
                    actualIndex = j
                    break
                end
            end
            
            table.insert(options, {
                title = saved.name,
                description = saved.data.model:upper() .. ' • ' .. saved.data.category,
                icon = 'car',
                onSelect = function()
                    openSavedVehicleOptionsMenu(actualIndex, categoryId, categoryName)
                end
            })
        end
    end
    
    lib.registerContext({
        id = 'category_vehicles_menu',
        title = categoryName,
        menu = 'saved_vehicles_menu',
        options = options
    })
    lib.showContext('category_vehicles_menu')
end

local function openSavedVehiclesMenu()
    local categories = {
        {id = 'all', name = 'All Vehicles', icon = 'list'},
        {id = 'personal', name = 'Personal', icon = 'user'},
        {id = 'work', name = 'Work', icon = 'briefcase'},
        {id = 'emergency', name = 'Emergency', icon = 'shield-halved'},
        {id = 'favorites', name = 'Favorites', icon = 'heart'}
    }
    
    local options = {}
    
    table.insert(options, {
        title = 'Save Current Vehicle',
        icon = 'floppy-disk',
        iconColor = '#00ff00',
        onSelect = function()
            SaveCurrentVehicle()
        end
    })
    
    for _, cat in ipairs(categories) do
        local count = 0
        if cat.id == 'all' then
            count = #savedVehicles
        else
            for _, saved in ipairs(savedVehicles) do
                if saved.data.category == cat.id then
                    count = count + 1
                end
            end
        end
        
        table.insert(options, {
            title = cat.name,
            description = count .. ' vehicle(s)',
            icon = cat.icon,
            onSelect = function()
                openCategoryVehiclesMenu(cat.id, cat.name)
            end
        })
    end
    
    if #savedVehicles > 0 then
        table.insert(options, {
            title = 'Delete All',
            icon = 'trash',
            iconColor = '#ff0000',
            onSelect = function()
                local alert = lib.alertDialog({
                    header = 'Delete All?',
                    content = 'Cannot be undone',
                    centered = true,
                    cancel = true
                })
                
                if alert == 'confirm' then
                    savedVehicles = {}
                    SaveVehiclesToKVP()
                    lib.notify({title = 'Cleared', type = 'success'})
                    openSavedVehiclesMenu()
                else
                    openSavedVehiclesMenu()
                end
            end
        })
    end
    
    lib.registerContext({
        id = 'saved_vehicles_menu',
        title = 'Saved Vehicles',
        menu = 'vehicle_main_menu',
        options = options
    })
    lib.showContext('saved_vehicles_menu')
end

-- New function to open emergency subcategory menu
local function openEmergencySubcategoryMenu(subcategory)
    local elements = {}
    for _, vehicle in ipairs(subcategory.vehicles) do
        table.insert(elements, {
            title = vehicle.name,
            description = vehicle.model:upper(),
            icon = 'car-side',
            onSelect = function()
                SpawnVehicle(vehicle.model, nil, true, function()
                    openEmergencySubcategoryMenu(subcategory)
                end)
            end
        })
    end
    
    lib.registerContext({
        id = 'emergency_subcategory_menu',
        title = subcategory.subcategory,
        menu = 'emergency_main_menu',
        options = elements
    })
    lib.showContext('emergency_subcategory_menu')
end

-- New function to open emergency category menu
local function openEmergencyMenu()
    local options = {}
    
    for _, subcategory in ipairs(emergencyVehicles) do
        table.insert(options, {
            title = subcategory.subcategory,
            icon = subcategory.icon,
            onSelect = function()
                openEmergencySubcategoryMenu(subcategory)
            end
        })
    end
    
    lib.registerContext({
        id = 'emergency_main_menu',
        title = 'Emergency Vehicles',
        menu = 'vehicle_spawner_menu',
        options = options
    })
    lib.showContext('emergency_main_menu')
end

local function openCategoryMenu(category)
    local elements = {}
    for _, vehicle in ipairs(category.models) do
        table.insert(elements, {
            title = vehicle.name,
            description = vehicle.model and vehicle.model:upper() or "Unknown",
            icon = 'car-side',
            onSelect = function()
                SpawnVehicle(vehicle.model, nil, true, function()
                    openCategoryMenu(category)
                end)
            end
        })
    end
    
    lib.registerContext({
        id = 'vehicle_category_menu',
        title = category.category .. ' Vehicles',
        menu = 'vehicle_spawner_menu',
        options = elements
    })
    lib.showContext('vehicle_category_menu')
end

local function openVehicleSpawnerMenu()
    local options = {
        {
            title = replaceVehicle and 'Replace Current Vehicle: ON' or 'Replace Current Vehicle: OFF',
            icon = replaceVehicle and 'toggle-on' or 'toggle-off',
            iconColor = replaceVehicle and '#00ff00' or '#ff0000',
            onSelect = function()
                replaceVehicle = not replaceVehicle
                lib.notify({title = 'Setting Updated', type = 'info'})
                openVehicleSpawnerMenu()
            end
        }
    }
    
    -- Add Emergency category with special handling
    table.insert(options, {
        title = 'Emergency',
        description = 'Emergency service vehicles',
        icon = 'shield-halved',
        iconColor = '#FF0000',
        onSelect = function()
            openEmergencyMenu()
        end
    })
    
    -- Add regular vehicle categories
    for _, category in ipairs(vehicles) do
        local description = #category.models .. ' vehicles'
        table.insert(options, {
            title = category.category,
            description = description,
            icon = category.icon,
            iconColor = category.iconColor,
            onSelect = function()
                openCategoryMenu(category)
            end
        })
    end

    lib.registerContext({id = 'vehicle_spawner_menu', title = 'Vehicle Spawner', menu = 'vehicle_main_menu', options = options})
    lib.showContext('vehicle_spawner_menu')
end

local function openLicensePlateMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local plateStyles = {
        {name = 'Blue on White 1', id = 0},
        {name = 'Yellow on Black', id = 1},
        {name = 'Yellow on Blue', id = 2},
        {name = 'Blue on White 2', id = 3},
        {name = 'Blue on White 3', id = 4},
        {name = 'Yankton', id = 5}
    }
    
    local options = {}
    
    -- Add option to change plate text
    table.insert(options, {
        title = 'Change Plate Text',
        description = 'Current: ' .. GetVehicleNumberPlateText(vehicle),
        icon = 'keyboard',
        iconColor = '#FFD700',
        onSelect = function()
            local input = lib.inputDialog('License Plate Text', {
                {type = 'input', label = 'Plate Text', placeholder = 'Max 8 characters', required = true, min = 1, max = 8, default = GetVehicleNumberPlateText(vehicle)}
            })
            
            if input then
                SetVehicleNumberPlateText(vehicle, input[1])
                lib.notify({title = 'Plate Changed', description = input[1], type = 'success'})
            end
            openLicensePlateMenu()
        end
    })
    
    -- Add plate style options
    local currentStyle = GetVehicleNumberPlateTextIndex(vehicle)
    for _, style in ipairs(plateStyles) do
        local isActive = currentStyle == style.id
        table.insert(options, {
            title = style.name,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'address-card',
            iconColor = isActive and '#00ff00' or '#4169E1',
            onSelect = function()
                SetVehicleNumberPlateTextIndex(vehicle, style.id)
                lib.notify({title = 'Plate Style Changed', description = style.name, type = 'success'})
                openLicensePlateMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'license_plate_menu',
        title = 'License Plate',
        menu = 'vehicle_customization_menu',
        options = options
    })
    lib.showContext('license_plate_menu')
end

local function openPrimaryColorMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local colors = {
        {name = 'Black', id = 0}, {name = 'Carbon Black', id = 147}, {name = 'Graphite', id = 1},
        {name = 'Steel', id = 3}, {name = 'Silver', id = 4}, {name = 'Frost White', id = 111},
        {name = 'Red', id = 27}, {name = 'Torino Red', id = 28}, {name = 'Formula Red', id = 29},
        {name = 'Blaze Red', id = 30}, {name = 'Grace Red', id = 31}, {name = 'Garnet Red', id = 32},
        {name = 'Sunset Red', id = 33}, {name = 'Cabernet Red', id = 34}, {name = 'Candy Red', id = 35},
        {name = 'Hot Pink', id = 135}, {name = 'Salmon Pink', id = 136}, {name = 'Orange', id = 38},
        {name = 'Bright Orange', id = 138}, {name = 'Yellow', id = 88}, {name = 'Race Yellow', id = 89},
        {name = 'Dew Yellow', id = 91}, {name = 'Dark Green', id = 49}, {name = 'Racing Green', id = 50},
        {name = 'Sea Green', id = 51}, {name = 'Olive Green', id = 52}, {name = 'Bright Green', id = 53},
        {name = 'Gasoline Green', id = 54}, {name = 'Lime Green', id = 92}, {name = 'Midnight Blue', id = 141},
        {name = 'Galaxy Blue', id = 61}, {name = 'Dark Blue', id = 62}, {name = 'Saxon Blue', id = 63},
        {name = 'Blue', id = 64}, {name = 'Mariner Blue', id = 65}, {name = 'Harbor Blue', id = 66},
        {name = 'Diamond Blue', id = 67}, {name = 'Surf Blue', id = 68}, {name = 'Nautical Blue', id = 69},
        {name = 'Racing Blue', id = 73}, {name = 'Light Blue', id = 74}, {name = 'Bison Brown', id = 101},
        {name = 'Creek Brown', id = 95}, {name = 'Chocolate Brown', id = 96}, {name = 'Maple Brown', id = 97},
        {name = 'Purple', id = 145}, {name = 'Spin Purple', id = 146}
    }
    
    local options = {}
    for _, color in ipairs(colors) do
        table.insert(options, {
            title = color.name,
            icon = 'circle',
            onSelect = function()
                local _, secondary = GetVehicleColours(vehicle)
                SetVehicleColours(vehicle, color.id, secondary)
                lib.notify({title = 'Color Changed', description = color.name, type = 'success'})
                openPrimaryColorMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'primary_color_menu',
        title = 'Primary Color',
        menu = 'vehicle_customization_menu',
        options = options
    })
    lib.showContext('primary_color_menu')
end

local function openSecondaryColorMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local colors = {
        {name = 'Black', id = 0}, {name = 'Carbon Black', id = 147}, {name = 'Graphite', id = 1},
        {name = 'Steel', id = 3}, {name = 'Silver', id = 4}, {name = 'Frost White', id = 111},
        {name = 'Red', id = 27}, {name = 'Torino Red', id = 28}, {name = 'Formula Red', id = 29},
        {name = 'Blaze Red', id = 30}, {name = 'Grace Red', id = 31}, {name = 'Garnet Red', id = 32},
        {name = 'Sunset Red', id = 33}, {name = 'Cabernet Red', id = 34}, {name = 'Candy Red', id = 35},
        {name = 'Hot Pink', id = 135}, {name = 'Salmon Pink', id = 136}, {name = 'Orange', id = 38},
        {name = 'Bright Orange', id = 138}, {name = 'Yellow', id = 88}, {name = 'Race Yellow', id = 89},
        {name = 'Dew Yellow', id = 91}, {name = 'Dark Green', id = 49}, {name = 'Racing Green', id = 50},
        {name = 'Sea Green', id = 51}, {name = 'Olive Green', id = 52}, {name = 'Bright Green', id = 53},
        {name = 'Gasoline Green', id = 54}, {name = 'Lime Green', id = 92}, {name = 'Midnight Blue', id = 141},
        {name = 'Galaxy Blue', id = 61}, {name = 'Dark Blue', id = 62}, {name = 'Saxon Blue', id = 63},
        {name = 'Blue', id = 64}, {name = 'Mariner Blue', id = 65}, {name = 'Harbor Blue', id = 66},
        {name = 'Diamond Blue', id = 67}, {name = 'Surf Blue', id = 68}, {name = 'Nautical Blue', id = 69},
        {name = 'Racing Blue', id = 73}, {name = 'Light Blue', id = 74}, {name = 'Bison Brown', id = 101},
        {name = 'Creek Brown', id = 95}, {name = 'Chocolate Brown', id = 96}, {name = 'Maple Brown', id = 97},
        {name = 'Purple', id = 145}, {name = 'Spin Purple', id = 146}
    }
    
    local options = {}
    for _, color in ipairs(colors) do
        table.insert(options, {
            title = color.name,
            icon = 'circle',
            onSelect = function()
                local primary, _ = GetVehicleColours(vehicle)
                SetVehicleColours(vehicle, primary, color.id)
                lib.notify({title = 'Color Changed', description = color.name, type = 'success'})
                openSecondaryColorMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'secondary_color_menu',
        title = 'Secondary Color',
        menu = 'vehicle_customization_menu',
        options = options
    })
    lib.showContext('secondary_color_menu')
end

local function openExtrasAndLiveryMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local options = {}
    
    -- Add liveries section
    local liveryCount = GetVehicleLiveryCount(vehicle)
    if liveryCount > 0 then
        for i = 0, liveryCount - 1 do
            local currentLivery = GetVehicleLivery(vehicle)
            local isActive = currentLivery == i
            table.insert(options, {
                title = 'Livery ' .. (i + 1),
                description = isActive and 'Currently Active' or 'Click to apply',
                icon = 'paintbrush',
                iconColor = isActive and '#00ff00' or '#9370DB',
                onSelect = function()
                    SetVehicleLivery(vehicle, i)
                    lib.notify({title = 'Livery Changed', description = 'Livery ' .. (i + 1), type = 'success'})
                    openExtrasAndLiveryMenu()
                end
            })
        end
    end
    
    -- Add extras section
    local hasExtras = false
    for i = 0, 14 do
        if DoesExtraExist(vehicle, i) then
            hasExtras = true
            local isOn = IsVehicleExtraTurnedOn(vehicle, i)
            table.insert(options, {
                title = 'Extra ' .. i,
                description = isOn and 'Currently ON' or 'Currently OFF',
                icon = isOn and 'toggle-on' or 'toggle-off',
                iconColor = isOn and '#00ff00' or '#ff0000',
                onSelect = function()
                    SetVehicleExtra(vehicle, i, isOn and 1 or 0)
                    lib.notify({title = 'Extra ' .. i, description = isOn and 'Disabled' or 'Enabled', type = 'info'})
                    openExtrasAndLiveryMenu()
                end
            })
        end
    end
    
    -- If no liveries or extras, show message
    if liveryCount <= 0 and not hasExtras then
        table.insert(options, {
            title = 'No Liveries or Extras',
            description = 'This vehicle has no liveries or extras',
            icon = 'circle-xmark',
            disabled = true
        })
    end
    
    lib.registerContext({
        id = 'extras_livery_menu',
        title = 'Liveries & Extras',
        menu = 'vehicle_customization_menu',
        options = options
    })
    lib.showContext('extras_livery_menu')
end

local function openVehicleCustomizationMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        openVehicleMenu()
        return
    end
    
    local options = {
        {
            title = 'Repair Vehicle',
            description = '(Requires to be at Mechanic for full Repair)',
            icon = 'hammer',
            iconColor = '#f5ac0fff',
            onSelect = function()
                ExecuteCommand('repair')
                openVehicleCustomizationMenu()
            end
        },
        {
            title = 'Clean Vehicle',
            description = 'Remove dirt from vehicle',
            icon = 'droplet',
            iconColor = '#00BFFF',
            onSelect = function()
                SetVehicleDirtLevel(vehicle, 0.0)
                lib.notify({title = 'Vehicle Cleaned', type = 'success'})
                openVehicleCustomizationMenu()
            end
        },
        {
            title = 'Change Primary Color',
            description = 'Modify primary paint color',
            icon = 'palette',
            iconColor = '#FF6347',
            onSelect = function()
                openPrimaryColorMenu()
            end
        },
        {
            title = 'Change Secondary Color',
            description = 'Modify secondary paint color',
            icon = 'palette',
            iconColor = '#4169E1',
            onSelect = function()
                openSecondaryColorMenu()
            end
        },
        {
            title = 'Liveries & Extras',
            description = 'Change liveries and toggle extras',
            icon = 'wrench',
            iconColor = '#FFA500',
            onSelect = function()
                openExtrasAndLiveryMenu()
            end
        },
        {
            title = 'License Plate',
            description = 'Customize license plate',
            icon = 'address-card',
            iconColor = '#FFD700',
            onSelect = function()
                openLicensePlateMenu()
            end
        }
    }
    
    lib.registerContext({
        id = 'vehicle_customization_menu',
        title = 'Vehicle Customization',
        menu = 'vehicle_main_menu',
        options = options
    })
    lib.showContext('vehicle_customization_menu')
end

local function openExtrasAndLiveryMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local options = {}
    
    -- Add liveries section
    local liveryCount = GetVehicleLiveryCount(vehicle)
    if liveryCount > 0 then
        for i = 0, liveryCount - 1 do
            local currentLivery = GetVehicleLivery(vehicle)
            local isActive = currentLivery == i
            table.insert(options, {
                title = 'Livery ' .. (i + 1),
                description = isActive and 'Currently Active' or 'Click to apply',
                icon = 'paintbrush',
                iconColor = isActive and '#00ff00' or '#9370DB',
                onSelect = function()
                    SetVehicleLivery(vehicle, i)
                    lib.notify({title = 'Livery Changed', description = 'Livery ' .. (i + 1), type = 'success'})
                    openExtrasAndLiveryMenu()
                end
            })
        end
    end
    
    -- Add extras section
    local hasExtras = false
    for i = 0, 14 do
        if DoesExtraExist(vehicle, i) then
            hasExtras = true
            local isOn = IsVehicleExtraTurnedOn(vehicle, i)
            table.insert(options, {
                title = 'Extra ' .. i,
                description = isOn and 'Currently ON' or 'Currently OFF',
                icon = isOn and 'toggle-on' or 'toggle-off',
                iconColor = isOn and '#00ff00' or '#ff0000',
                onSelect = function()
                    SetVehicleExtra(vehicle, i, isOn and 1 or 0)
                    lib.notify({title = 'Extra ' .. i, description = isOn and 'Disabled' or 'Enabled', type = 'info'})
                    openExtrasAndLiveryMenu()
                end
            })
        end
    end
    
    -- If no liveries or extras, show message
    if liveryCount <= 0 and not hasExtras then
        table.insert(options, {
            title = 'No Liveries or Extras',
            description = 'This vehicle has no liveries or extras',
            icon = 'circle-xmark',
            disabled = true
        })
    end
    
    lib.registerContext({
        id = 'extras_livery_menu',
        title = 'Liveries & Extras',
        menu = 'vehicle_customization_menu',
        options = options
    })
    lib.showContext('extras_livery_menu')
end

local function openExtrasMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local options = {}
    local hasExtras = false
    
    for i = 0, 14 do
        if DoesExtraExist(vehicle, i) then
            hasExtras = true
            local isOn = IsVehicleExtraTurnedOn(vehicle, i)
            table.insert(options, {
                title = 'Extra ' .. i,
                description = isOn and 'Currently ON' or 'Currently OFF',
                icon = isOn and 'toggle-on' or 'toggle-off',
                iconColor = isOn and '#00ff00' or '#ff0000',
                onSelect = function()
                    SetVehicleExtra(vehicle, i, isOn and 1 or 0)
                    lib.notify({title = 'Extra ' .. i, description = isOn and 'Disabled' or 'Enabled', type = 'info'})
                    openExtrasMenu()
                end
            })
        end
    end
    
    if not hasExtras then
        table.insert(options, {
            title = 'No Extras Available',
            icon = 'circle-xmark',
            disabled = true
        })
    end
    
    lib.registerContext({
        id = 'extras_menu',
        title = 'Vehicle Extras',
        menu = 'vehicle_customization_menu',
        options = options
    })
    lib.showContext('extras_menu')
end

local function openLiveryMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local liveryCount = GetVehicleLiveryCount(vehicle)
    local options = {}
    
    if liveryCount > 0 then
        for i = 0, liveryCount - 1 do
            table.insert(options, {
                title = 'Livery ' .. (i + 1),
                icon = 'paintbrush',
                onSelect = function()
                    SetVehicleLivery(vehicle, i)
                    lib.notify({title = 'Livery Changed', description = 'Livery ' .. (i + 1), type = 'success'})
                    openLiveryMenu()
                end
            })
        end
    else
        table.insert(options, {
            title = 'No Liveries Available',
            icon = 'circle-xmark',
            disabled = true
        })
    end
    
    lib.registerContext({
        id = 'livery_menu',
        title = 'Vehicle Liveries',
        menu = 'vehicle_customization_menu',
        options = options
    })
    lib.showContext('livery_menu')
end

local function openLicensePlateMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local plateStyles = {
        {name = 'Blue on White 1', id = 0},
        {name = 'Yellow on Black', id = 1},
        {name = 'Yellow on Blue', id = 2},
        {name = 'Blue on White 2', id = 3},
        {name = 'Blue on White 3', id = 4},
        {name = 'Yankton', id = 5}
    }
    
    local options = {}
    
    -- Add option to change plate text
    table.insert(options, {
        title = 'Change Plate Text',
        description = 'Current: ' .. GetVehicleNumberPlateText(vehicle),
        icon = 'keyboard',
        iconColor = '#FFD700',
        onSelect = function()
            local input = lib.inputDialog('License Plate Text', {
                {type = 'input', label = 'Plate Text', placeholder = 'Max 8 characters', required = true, min = 1, max = 8, default = GetVehicleNumberPlateText(vehicle)}
            })
            
            if input then
                SetVehicleNumberPlateText(vehicle, input[1])
                lib.notify({title = 'Plate Changed', description = input[1], type = 'success'})
            end
            openLicensePlateMenu()
        end
    })
    
    -- Add plate style options
    local currentStyle = GetVehicleNumberPlateTextIndex(vehicle)
    for _, style in ipairs(plateStyles) do
        local isActive = currentStyle == style.id
        table.insert(options, {
            title = style.name,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'address-card',
            iconColor = isActive and '#00ff00' or '#4169E1',
            onSelect = function()
                SetVehicleNumberPlateTextIndex(vehicle, style.id)
                lib.notify({title = 'Plate Style Changed', description = style.name, type = 'success'})
                openLicensePlateMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'license_plate_menu',
        title = 'License Plate',
        menu = 'vehicle_customization_menu',
        options = options
    })
    lib.showContext('license_plate_menu')
end

local function openVehicleMenu()
    local options = {
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
            title = 'Vehicle Spawner',
            description = 'Browse and spawn vehicles',
            icon = 'car',
            iconColor = '#00BFFF',
            onSelect = function()
                openVehicleSpawnerMenu()
            end
        },
        {
            title = 'Vehicle Customization',
            description = 'Customize your current vehicle',
            icon = 'wrench',
            iconColor = '#FF8C00',
            onSelect = function()
                openVehicleCustomizationMenu()
            end
        },
        {
            title = 'Saved Vehicles',
            description = 'Manage your saved vehicles',
            icon = 'bookmark',
            iconColor = '#FFD700',
            onSelect = function()
                openSavedVehiclesMenu()
            end
        }
    }

    lib.registerContext({id = 'vehicle_main_menu', title = 'Vehicle Menu', options = options})
    lib.showContext('vehicle_main_menu')
end
RegisterCommand('veh', function() openVehicleMenu() end, false)
RegisterKeyMapping('veh', 'Open Vehicle Menu', 'keyboard', 'F6')