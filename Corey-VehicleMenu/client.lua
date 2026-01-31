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
            {model = "issi8", name = "Issi Rally"},
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
            {model = "baller8", name = "Baller ST-D"},
            {model = "cavalcade", name = "Cavalcade"},
            {model = "cavalcade2", name = "Cavalcade II"},
            {model = "dubsta", name = "Dubsta"},
            {model = "dubsta2", name = "Dubsta 2"},
            {model = "fq2", name = "FQ 2"},
            {model = "granger", name = "Granger"},
            {model = "granger2", name = "Granger 3600LX"},
            {model = "gresley", name = "Gresley"},
            {model = "habanero", name = "Habanero"},
            {model = "huntley", name = "Huntley S"},
            {model = "landstalker", name = "Landstalker"},
            {model = "landstalker2", name = "Landstalker XL"},
            {model = "mesa", name = "Mesa"},
            {model = "patriot", name = "Patriot"},
            {model = "radi", name = "Radius"},
            {model = "rocoto", name = "Rocoto"},
            {model = "seminole", name = "Seminole"},
            {model = "serrano", name = "Serrano"},
            {model = "xls", name = "XLS"},
            {model = "iwagen", name = "I-Wagen"},
            {model = "jubilee", name = "Jubilee"},
            {model = "dorado", name = "Dorado"},
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
            {model = "guardian", name = "Vapid Guardian"},
            {model = "trophytruck2", name = "Desert Raid"}
        }
    },
    {
        category = "Vans", 
        icon = "van-shuttle", 
        iconColor = "#ccc8c8ff", 
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
        category = "Commercial", 
        icon = "truck", 
        iconColor = "#eb4646ff", 
        models = {
            {model = "benson", name = "Benson"},
            {model = "benson2", name = "Benson (Cluckin' Bell)"},
            {model = "biff", name = "Biff"},
            {model = "cerberus", name = "Apocalypse Cerberus"},
            {model = "cerberus2", name = "Future Shock Cerberus"},
            {model = "cerberus3", name = "Nightmare Cerberus"},
            {model = "hauler", name = "Hauler"},
            {model = "hauler2", name = "Hauler Custom"},
            {model = "mule", name = "Mule"},
            {model = "mule4", name = "Mule Custom"},
            {model = "packer", name = "Packer"},
            {model = "phantom", name = "Phantom"},
            {model = "phantom2", name = "Phantom Wedge"},
            {model = "phantom3", name = "Phantom Custom"},
            {model = "phantom4", name = "Phantom XMAS"},
            {model = "pounder", name = "Pounder"},
            {model = "pounder2", name = "Pounder Custom"},
            {model = "stockade", name = "Stockade"},
            {model = "terbyte", name = "Terrorbyte"},
            {model = "docktug", name = "Docktug"},
            {model = "tractor2", name = "Fieldmaster Tractor"},
            {model = "utillitruck", name = "Utility Truck (Lift)"},
            {model = "utillitruck2", name = "Utility Truck"},
            {model = "utillitruck3", name = "Utility Car"},
            {model = "handler", name = "Dock Handler"},
            {model = "mixer", name = "Cement Mixer"},
            {model = "rubble", name = "Rubble Truck"},
            {model = "tiptruck", name = "Tipper"},
            {model = "tiptruck2", name = "Tipper 2"},
            {model = "trash", name = "Garbage Truck"},

        }
    },
    {
        category = "Service", 
        icon = "cog", 
        iconColor = "#f4f812ff", 
        models = {
            {model = "airbus", name = "Airport Bus"},
            {model = "bus", name = "Bus"},
            {model = "coach", name = "Coach"},
            {model = "pbus", name = "Party Bus"},
            {model = "rallytruck", name = "Rally Truck"},
            {model = "rentalbus", name = "Rental Shuttle Bus"},
            {model = "taxi", name = "Vapid Stanier Taxi"},
            {model = "tourbus", name = "Tour Bus"},
        }
    },
    {
        category = "Trailer", 
        icon = "trailer", 
        iconColor = "#ffffffff", 
        models = {
            {model = "armytrailer", name = "Army Trailer"},
            {model = "freighttrailer", name = "Freight Trailer"},
            {model = "armytanker", name = "Army Tanker"},
            {model = "trailerlarger", name = "MOC"},
            {model = "docktrailer", name = "Container Trailer"},
            {model = "tr3", name = "Large Boat Trailer"},
            {model = "tr2", name = "Car Trailer"},
            {model = "tr3", name = "Army Trailer"},
            {model = "trflat", name = "Flatbed Trailer"},
            {model = "trailers", name = "Countainer Trailer 2"},
            {model = "trailers4", name = "Countainer Trailer 3"},
            {model = "trailers2", name = "Trailer 2"},
            {model = "trailers3", name = "Trailer 3"},
            {model = "trailers5", name = "XMAS Trailer"},
            {model = "tvtrailer", name = "TV Trailer"},
            {model = "tvtrailer2", name = "TV Trailer 2"},
            {model = "trailerlogs", name = "Log Trailer"},
            {model = "tanker", name = "Fuel Tanker"},
            {model = "baletrailer", name = "Bale Trailer"},
            {model = "graintrailer", name = "Grain Trailer"},
            {model = "raketrailer", name = "Tractor Rake Trailer"},
            {model = "trailersmall", name = "Small Trailer"},
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
    },
    {
        category = "Open Wheel", 
        icon = "flag-checkered", 
        iconColor = "#51e623ff", 
        models = {
            {model = "formula", name = "PR4"},
            {model = "formula2", name = "R88"},
            {model = "openwheel1", name = "BR8"},
            {model = "openwheel2", name = "DR1"},
        }
    },
    {
        category = "Bicycle's", 
        icon = "bicycle", 
        iconColor = "#ffffffff", 
        models = {
            {model = "bmx", name = "BMX"},
            {model = "cruiser", name = "Cruiser"},
            {model = "fixter", name = "Fixter"},
            {model = "inductor", name = "Inductor"},
            {model = "inductor2", name = "Junk Energy Inductor"},
            {model = "scorcher", name = "Scorcher"},
            {model = "tribike", name = "Whippet Race Bike"},
            {model = "tribike2", name = "Endurex Race Bike"},
            {model = "tribike3", name = "Tri-Cycles Race Bike"},
        }
    },
    {
        category = "Helicopters", 
        icon = "helicopter", 
        iconColor = "#0066ffff", 
        models = {
            {model = "akula", name = "Akula"},
            {model = "annihilator", name = "Annihilator"},
            {model = "annihilator2", name = "Annihilator Stealth"},
            {model = "buzzard", name = "Buzzard Attack Chopper"},
            {model = "buzzard2", name = "Buzzard"},
            {model = "cargobob", name = "Cargobob"},
            {model = "cargobob2", name = "Cargobob Jetsam"},
            {model = "cargobob3", name = "Cargobob TPE"},
            {model = "conada", name = "Conada"},
            {model = "condada2", name = "Weaponized Conada"},
            {model = "frogger", name = "Frogger"},
            {model = "havok", name = "Havok"},
            {model = "hunter", name = "FH-1 Hunter"},
            {model = "maverick", name = "Maverick"},
            {model = "polmav", name = "Police/EMS Maverick"},
            {model = "seasparrow", name = "Sea Sparrow"},
            {model = "seasparrow2", name = "Sparrow"},
            {model = "skylift", name = "Skylift"},
            {model = "supervolito", name = "SuperVolito"},
            {model = "supervolito2", name = "SuperVolito Carbon"},
            {model = "swift", name = "Swift"},
            {model = "swift2", name = "Swift Deluxe"},
            {model = "valkyrie", name = "Valkyrie"},
            {model = "volatus", name = "Volatus"},
        }
    },
    {
        category = "Planes", 
        icon = "plane", 
        iconColor = "#0066ffff", 
        models = {
            {model = "alkonost", name = "RO-86 Alkonost"},
            {model = "alphaz1", name = "Alpha-Z1"},
            {model = "avenger", name = "Avenger"},
            {model = "besra", name = "Besra"},
            {model = "blimp", name = "Atomic Blimp"},
            {model = "blimp2", name = "Xero Blimp"},
            {model = "blimp3", name = "Custom Blimp"},
            {model = "bombushka", name = "RM-10 Bombushka"},
            {model = "cargoplane", name = "Cargo Plane"},
            {model = "cuban800", name = "Cuban 800"},
            {model = "dodo", name = "Dodo"},
            {model = "duster", name = "Crop Duster"},
            {model = "howard", name = "Howard NX-25"},
            {model = "hydra", name = "Hydra"},
            {model = "jet", name = "Commercial Jet"},
            {model = "lazer", name = "P-996 Lazer"},
            {model = "luxor", name = "Luxor"},
            {model = "luxor2", name = "Luxor Deluxe"},
            {model = "mammatus", name = "Mammatus"},
            {model = "microlight", name = "Ultralight"},
            {model = "miljet", name = "Military Jet"},
            {model = "mogul", name = "Mogul"},
            {model = "molotok", name = "V-65 Molotok"},
            {model = "nimbus", name = "Nimbus"},
            {model = "nokota", name = "P-45 Nokota"},
            {model = "pyro", name = "Pyro"},
            {model = "raiju", name = "F-160 Raiju"},
            {model = "rogue", name = "Rogue"},
            {model = "seabreeze", name = "Seabreeze"},
            {model = "shamal", name = "Shamal"},
            {model = "starling", name = "LF-22 Starling"},
            {model = "streamer216", name = "Streamer 216"},
            {model = "strikeforce", name = "B-11 Strikeforce"},
            {model = "stunt", name = "Mallard"},
            {model = "titan", name = "Titan"},
            {model = "tula", name = "Tula"},
            {model = "velum", name = "Velum"},
            {model = "velum2", name = "Velum (5-Seater)"},
            {model = "vestra", name = "Vestra"},
            {model = "volatol", name = "Volatol"},
        }
    },
    {
        category = "Other", 
        icon = "circle", 
        iconColor = "#ffffffff", 
        models = {
            {model = "airtug", name = "Airtug"},
            {model = "caddy", name = "Golf Cart"},
            {model = "caddy2", name = "Golf Cart Old"},
            {model = "caddy3", name = "Caddy Long"},
            {model = "forklift", name = "Forklift"},
            {model = "mower", name = "Lawn Mower"},
            {model = "ripley", name = "Ripley"},
            {model = "tractor", name = "Tractor"},
            {model = "bulldozer", name = "Bulldozer"},
            {model = "cutter", name = "Cutter"},
            {model = "dump", name = "Dump Truck"},
            {model = "wastelander", name = "Wastelander"},
        }
    },
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
        {model = "segway", name = "LSPD Segway"},
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

-- Addon vehicles with subcategories
local addonVehicles = {
    {
        subcategory = "Compacts",
        icon = "car",
        vehicles = {
            {model = "piccolo", name = "Grotti Piccolo"},
            {model = "twingo", name = "Renault Twingo"},
            -- Add your addon vehicles here
        }
    },
    {
        subcategory = "Sedans",
        icon = "car",
        vehicles = {
            {model = "golf8gti", name = "VW Golf 8 GTI"},
            {model = "golfgti7", name = "VW Golf 7 GTI"},
            {model = "tltypes", name = "Honda Acura TLS"},
            {model = "teslapd", name = "Tesla Model S"},
            {model = "tmodel", name = "Tesla Model 3"},
            {model = "c6320", name = "Mercedes AMG C63S"},
            {model = "77monaco", name = "1977 Dodge Monaco "},
            {model = "22char", name = "2022 Dodge Charger"},
            {model = "08char", name = "2008 Dodge Charger"},
            {model = "impa6", name = "2006 Chevy Impala LS"},
            {model = "22530i", name = "2022 BMW 530I Wagon"},
            {model = "22ct4", name = "2022 Cadillac Ct4"},
            {model = "13malibu", name = "2023 Chevy Malibu"},
            {model = "03impa", name = "2003 Chevy Impala"},
            {model = "cmr11", name = "2011 Toyota Camry"},
            {model = "vic11", name = "2011 Ford Crown Victoria"},
            {model = "11cvpiciv", name = "2011 Ford CVPI (Retired)"},
            {model = "18chargerciv", name = "2018 Dodge Charger PPV (Retired)"},
            {model = "m3e36", name = "BMW M3 E36"},
            {model = "22rs5", name = "2022 Audi rs5"},
            {model = "22m5sal", name = "2022 BMW M5"},
            {model = "m422", name = "2022 BMW M4"},
            {model = "21avant", name = "2021 Audi RS5 Avant"},
            {model = "nbmazda3", name = "2020 Mazda 3"},
            {model = "saab93aeroc", name = "Saab 93"},
            {model = "rbmwm3f80", name = "BMW M3 F80"},
            -- Add your addon vehicles here
        }
    },
    {
        subcategory = "Sports",
        icon = "flag-checkered",
        vehicles = {
            {model = "22m5", name = "2022 BMW M5 CS"},
            {model = "22bengt", name = "2022 Bentley GT Continental"},
            {model = "mustang68", name = "1968 Ford Mustang"},
            {model = "nbbatur", name = "Bentley Batur"},
            {model = "ypg205t16a", name = "Peugeot 205 (Rally)"},
            {model = "ypg205t16b", name = "Peugeot 205"},
            {model = "majfd", name = "Mazda RX-7"},
            {model = "99viper", name = "1999 Dodge Viper"},
            {model = "cam8tun", name = "Toyota Camry XSE"},
            {model = "z32", name = "Fairlady Z 300ZX"},
            {model = "ap2", name = "Honda S2000"},
            {model = "focusrs", name = "2017 Ford Focus RS"},
            {model = "s63w222", name = "Mercedes AMG S63"},
            {model = "rufrgt8", name = "Porshe GT8"},
            {model = "24mustdh", name = "2024 Ford Mustang GT"},
            {model = "cali57", name = "Ferrari 250 GT"},
            {model = "20gt500", name = "2020 Ford Mustang GT"},
            {model = "59coronet", name = "1959 Dodge Coronet"},
            {model = "chrysler11", name = "Chrysler"},
            {model = "21ltz", name = "2021 Chevy Camero ZL1"},
            {model = "20gt500", name = "2020 Ford Mustang GT"},
            {model = "gtr50", name = "Nissan GT-R50"},
            {model = "r820", name = "Audi R8"},
            -- Add your addon vehicles here
        }
    },
    {
        subcategory = "Super",
        icon = "gauge-high",
        vehicles = {
            {model = "mig", name = "Ferrari"},
            {model = "jeskoattack24", name = "Koenigsegg Jesko"},
            {model = "f812", name = "Ferrari F812"},
            {model = "italigtb2", name = "Ferrari Itali GTB"},
            {model = "f4090", name = "Ferrari F4090"},
            {model = "czr1", name = "Chevy Corvette ZR"},
            {model = "c7", name = "Chevy Corvette C7"},
            {model = "evija", name = "2020 Lotus Evija"},
            {model = "20gt500", name = "2020 Ford Mustang GT"},
            {model = "bolide", name = "2020 Bugatti Bolide"},
            -- Add your addon vehicles here
        }
    },
    {
        subcategory = "SUVs",
        icon = "truck",
        vehicles = {
            {model = "teslax", name = "Tesla Model X"},
            {model = "mache", name = "Ford MachE"},
            {model = "4runner", name = "Toyota 4 Runner"},
            {model = "g63sec20", name = "Mercedes AMG G63"},
            {model = "urus", name = "Lamborghini Urus"},
            {model = "bbentayga", name = "Bentley Bentayga"},
            {model = "vxr", name = "Toyota VXR V8"},
            {model = "16i3", name = "2016 BMW I3"},
            {model = "tundra2021", name = "2021 Toyota Tundra"},
            {model = "expmax20", name = "2020 Ford Expedition Platinum"},
            {model = "22exp", name = "2022 Ford Expedition"},
            {model = "21dura", name = "2021 Dodge Durango Citreol"},
            {model = "19exp", name = "2019 Ford Explorer"},
            {model = "15expxl", name = "2015 Ford Expedition"},
            {model = "15exp", name = "2015 Ford Expedition Platinum"},
            {model = "02tahoe", name = "2002 Chevy Tahoe"},
            {model = "ncavalcade", name = "Cavalcade"},
            {model = "20tahoeciv", name = "2018 Chevy Tahoe (Retired)"},
            {model = "16fpiuciv", name = "2016 Ford FPIU (Retired)"},
            {model = "sec_rav424", name = "2021 Toyota Rav4 Hybrid"},
            {model = "tahoe08", name = "2008 Chevy Tahoe"},
            {model = "21subur", name = "2021 Chevy Suburban"},
            {model = "15carv", name = "2015 Dodge Grand Caravan"},
            {model = "sec_rav424", name = "2021 Toyota Rav4 Hybrid"},
            {model = "sec_rav424", name = "2021 Toyota Rav4 Hybrid"},
            -- Add your addon vehicles here
        }
    },
    {
        subcategory = "Off-Road",
        icon = "mountain",
        vehicles = {
            {model = "peacemaker", name = "Gallavanter Peacemaker"},
            {model = "peacemaker4", name = "Gallavanter Peacemaker (Bed)"},
            {model = "peacemaker6", name = "Gallavanter Peacemaker (Net)"},
            {model = "f150", name = "2015 Ford F-150 SVT"},
            {model = "f150army", name = "2015 Ford F-150 (Army)"},
            {model = "rubicon24", name = "2024 Jeep Rubicon"},
            {model = "nsandstorm3", name = "Vapid Sandstorm (Single Cab)"},
            {model = "nsandstorm2", name = "Vapid Sandstorm (Dually)"},
            {model = "nsandstorm", name = "Vapid Sandstorm (Crew Cab)"},
            {model = "hellenstorm", name = "Vapid Hellenstorm"},
            {model = "CyberTruckV", name = "Tesla Cybertruck"},
            {model = "wildtrak", name = "Ford Bronco Wildtrack"},
            {model = "velociraptor", name = "Ford F-150 Velociraptor"},
            {model = "f35019", name = "2019 Ford F-350"},
            {model = "22mavxl", name = "2022 Ford Maverick"},
            {model = "22f450xl", name = "2022 Ford F450 XL Superduty"},
            {model = "22f450xl", name = "2022 Ford F450 Limited Superduty"},
            {model = "21f250", name = "2021 Ford F-250 Superduty"},
            {model = "21f150", name = "2021 Ford F-150"},
            {model = "21brooff", name = "2021 Ford Bronco Sport"},
            {model = "21bro", name = "2021 Ford Bronco"},
            {model = "18raptor", name = "2018 Ford F-150 Raptor"},
            {model = "22silvwt", name = "2021 Chevy Silverado"},
            {model = "22silvltz", name = "2021 Chevy Silverado LTZ"},
            {model = "21f150", name = "2021 Ford F-150"},
            {model = "cararv", name = "Vapid Caracara 4x4 RV"},
            {model = "sandkingRV", name = "Vapid Sandking RV"},
            {model = "guardianrv", name = "Vapid Guardian RV"},
            {model = "sandroamer", name = "Vapid Sandroamer RV"},
            {model = "f15078", name = "1978 Ford F-150"},
            -- Add your addon vehicles here
        }
    },
    {
        subcategory = "Vans",
        icon = "van-shuttle",
        vehicles = {
            {model = "22chevango", name = "2012 Chevy Express (Cargo)"},
            {model = "22chevan", name = "2012 Chevy Express (Passenger)"},
            {model = "jogger", name = "Benefactor Jogger"},
            {model = "joggerpas", name = "Benefactor Jogger (Passenger)"},
            {model = "imperialev", name = "Benefactor Imperial EV"},
            {model = "imperialpas", name = "Benefactor Imperial (Passenger)"},
            {model = "imperial", name = "Benefactor Imperial"},
            -- Add your addon vehicles here
        }
    },
    {
        subcategory = "Motorcycles",
        icon = "motorcycle",
        vehicles = {
            {model = "21z900", name = "Kawasaki Z900"},
            {model = "g_xlcr", name = "Harley Davidson Sportser"},
            {model = "r1200gsec", name = "BMW R1200"},
            {model = "pcx160_2025", name = "PCX 160"},
            {model = "ip_m1000rr_23", name = "BMW M1000RR"},
            {model = "s1000sec", name = "BMW S1000R"},
            {model = "goldwing", name = "Honda Goldwing"},
            {model = "sahara300", name = "Sahara 300"},
            {model = "117", name = "Harley Davidson Bike"},
            -- Add your addon vehicles here
        }
    },
    {
        subcategory = "Utility",
        icon = "circle",
        vehicles = {
            {model = "segwayciv", name = "Segway"},
            {model = "iak_wheelchair", name = "Wheelchair"},
            {model = "galaxyroamer", name = "Galaxy Roamer Bus RV"},
            -- Add your addon vehicles here
        }
    },
    {
        subcategory = "Boats",
        icon = "circle",
        vehicles = {
            {model = "amels200", name = "AMELS200"},
            {model = "650e", name = "Sea Ray 650E"},
            -- Add your addon vehicles here
        }
    },
    -- Add more subcategories as needed
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

-- Settings variables
local noHelmet = false
local engineAlwaysOn = false

-- Thread to manage no helmet
CreateThread(function()
    while true do
        Wait(0)
        if noHelmet then
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                SetPedConfigFlag(ped, 35, false)
            end
        end
    end
end)

-- Thread to manage always clean vehicle
CreateThread(function()
    while true do
        Wait(1000)
        if alwaysClean then
            local ped = PlayerPedId()
            local vehicle = GetVehiclePedIsIn(ped, false)
            if vehicle ~= 0 then
                local dirtLevel = GetVehicleDirtLevel(vehicle)
                if dirtLevel > 0 then
                    SetVehicleDirtLevel(vehicle, 0.0)
                end
            end
        end
    end
end)

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

-- New function to open addon subcategory menu
local function openAddonSubcategoryMenu(subcategory)
    local elements = {}
    for _, vehicle in ipairs(subcategory.vehicles) do
        table.insert(elements, {
            title = vehicle.name,
            description = vehicle.model:upper(),
            icon = 'car-side',
            onSelect = function()
                SpawnVehicle(vehicle.model, nil, true, function()
                    openAddonSubcategoryMenu(subcategory)
                end)
            end
        })
    end
    
    lib.registerContext({
        id = 'addon_subcategory_menu',
        title = subcategory.subcategory,
        menu = 'addon_main_menu',
        options = elements
    })
    lib.showContext('addon_subcategory_menu')
end

-- New function to open addon category menu
local function openAddonMenu()
    local options = {}
    
    for _, subcategory in ipairs(addonVehicles) do
        table.insert(options, {
            title = subcategory.subcategory,
            icon = subcategory.icon,
            onSelect = function()
                openAddonSubcategoryMenu(subcategory)
            end
        })
    end
    
    lib.registerContext({
        id = 'addon_main_menu',
        title = 'Addon Vehicles',
        menu = 'vehicle_spawner_menu',
        options = options
    })
    lib.showContext('addon_main_menu')
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

    -- Add Addon category with special handling
    table.insert(options, {
        title = 'Custom Vehicles',
        description = 'Custom addon vehicles',
        icon = 'star',
        iconColor = '#FFD700',
        onSelect = function()
            openAddonMenu()
        end
    })
    
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


local function openPerformanceModsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    
    local performanceMods = {
        {modType = 11, name = 'Engine', icon = 'gears'},
        {modType = 12, name = 'Brakes', icon = 'circle-stop'},
        {modType = 13, name = 'Transmission', icon = 'gauge-high'},
        {modType = 15, name = 'Suspension', icon = 'car-side'},
        {modType = 16, name = 'Armor', icon = 'shield-halved'}
    }
    
    local options = {}
    
    -- Turbo option
    local hasTurbo = IsToggleModOn(vehicle, 18)
    table.insert(options, {
        title = 'Turbo',
        description = hasTurbo and 'Currently ON' or 'Currently OFF',
        icon = 'wind',
        iconColor = hasTurbo and '#00ff00' or '#ff0000',
        onSelect = function()
            ToggleVehicleMod(vehicle, 18, not hasTurbo)
            lib.notify({title = 'Turbo', description = hasTurbo and 'Disabled' or 'Enabled', type = 'success'})
            openPerformanceModsMenu()
        end
    })
    
    -- Performance mods
    for _, mod in ipairs(performanceMods) do
        local maxMod = GetNumVehicleMods(vehicle, mod.modType)
        if maxMod > 0 then
            table.insert(options, {
                title = mod.name,
                description = 'Configure ' .. mod.name:lower() .. ' upgrades',
                icon = mod.icon,
                iconColor = '#1E90FF',
                onSelect = function()
                    openSpecificModMenu(mod.modType, mod.name, 'performance_mods_menu')
                end
            })
        end
    end
    
    if #options == 1 then
        table.insert(options, {
            title = 'No Performance Mods Available',
            icon = 'circle-xmark',
            disabled = true
        })
    end
    
    lib.registerContext({
        id = 'performance_mods_menu',
        title = 'Performance Upgrades',
        menu = 'vehicle_customization_menu',
        options = options
    })
    lib.showContext('performance_mods_menu')
end

local function openVisualModsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    
    local visualMods = {
        {modType = 0, name = 'Spoilers', icon = 'car-rear'},
        {modType = 1, name = 'Front Bumper', icon = 'car-burst'},
        {modType = 2, name = 'Rear Bumper', icon = 'car-burst'},
        {modType = 3, name = 'Side Skirt', icon = 'car-side'},
        {modType = 4, name = 'Exhaust', icon = 'wind'},
        {modType = 5, name = 'Frame', icon = 'border-all'},
        {modType = 6, name = 'Grille', icon = 'table-cells'},
        {modType = 7, name = 'Hood', icon = 'car'},
        {modType = 8, name = 'Fender', icon = 'car'},
        {modType = 9, name = 'Right Fender', icon = 'car'},
        {modType = 10, name = 'Roof', icon = 'house'},
        {modType = 23, name = 'Front Wheels', icon = 'circle'},
        {modType = 24, name = 'Back Wheels', icon = 'circle'},
        {modType = 25, name = 'Plate Holder', icon = 'address-card'},
        {modType = 26, name = 'Vanity Plates', icon = 'address-card'},
        {modType = 27, name = 'Trim', icon = 'paintbrush'},
        {modType = 28, name = 'Ornaments', icon = 'star'},
        {modType = 29, name = 'Dashboard', icon = 'gauge'},
        {modType = 30, name = 'Dial', icon = 'clock'},
        {modType = 31, name = 'Door Speaker', icon = 'volume-high'},
        {modType = 32, name = 'Seats', icon = 'chair'},
        {modType = 33, name = 'Steering Wheel', icon = 'circle-notch'},
        {modType = 34, name = 'Shifter Leavers', icon = 'gear'},
        {modType = 35, name = 'Plaques', icon = 'award'},
        {modType = 36, name = 'Speakers', icon = 'volume-up'},
        {modType = 37, name = 'Trunk', icon = 'box'},
        {modType = 38, name = 'Hydraulics', icon = 'arrows-up-down'},
        {modType = 39, name = 'Engine Block', icon = 'gears'},
        {modType = 40, name = 'Air Filter', icon = 'filter'},
        {modType = 41, name = 'Struts', icon = 'bars'},
        {modType = 42, name = 'Arch Cover', icon = 'car'},
        {modType = 43, name = 'Aerials', icon = 'tower-broadcast'},
        {modType = 44, name = 'Trim 2', icon = 'paintbrush'},
        {modType = 45, name = 'Tank', icon = 'gas-pump'},
        {modType = 46, name = 'Windows', icon = 'window-maximize'},
        {modType = 48, name = 'Livery', icon = 'palette'}
    }
    
    local options = {}
    
    -- Window tint option
    table.insert(options, {
        title = 'Window Tint',
        description = 'Change window tint level',
        icon = 'window-maximize',
        iconColor = '#696969',
        onSelect = function()
            openWindowTintMenu()
        end
    })
    
    -- Neon lights option
    table.insert(options, {
        title = 'Neon Lights',
        description = 'Configure neon underglow',
        icon = 'lightbulb',
        iconColor = '#FF1493',
        onSelect = function()
            openNeonLightsMenu()
        end
    })
    
    -- Visual mods
    for _, mod in ipairs(visualMods) do
        local maxMod = GetNumVehicleMods(vehicle, mod.modType)
        if maxMod > 0 then
            table.insert(options, {
                title = mod.name,
                description = 'Configure ' .. mod.name:lower(),
                icon = mod.icon,
                iconColor = '#9370DB',
                onSelect = function()
                    openSpecificModMenu(mod.modType, mod.name, 'visual_mods_menu')
                end
            })
        end
    end
    
    lib.registerContext({
        id = 'visual_mods_menu',
        title = 'Visual Modifications',
        menu = 'vehicle_customization_menu',
        options = options
    })
    lib.showContext('visual_mods_menu')
end

local function openWindowTintMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local tints = {
        {name = 'None', id = 0},
        {name = 'Pure Black', id = 1},
        {name = 'Dark Smoke', id = 2},
        {name = 'Light Smoke', id = 3},
        {name = 'Stock', id = 4},
        {name = 'Limo', id = 5},
        {name = 'Green', id = 6}
    }
    
    local options = {}
    local currentTint = GetVehicleWindowTint(vehicle)
    
    for _, tint in ipairs(tints) do
        local isActive = currentTint == tint.id
        table.insert(options, {
            title = tint.name,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'window-maximize',
            iconColor = isActive and '#00ff00' or '#696969',
            onSelect = function()
                SetVehicleWindowTint(vehicle, tint.id)
                lib.notify({title = 'Window Tint Changed', description = tint.name, type = 'success'})
                openWindowTintMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'window_tint_menu',
        title = 'Window Tint',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('window_tint_menu')
end

local function openNeonLightsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local neonPositions = {
        {id = 0, name = 'Left'},
        {id = 1, name = 'Right'},
        {id = 2, name = 'Front'},
        {id = 3, name = 'Back'}
    }
    
    local options = {}
    
    -- Toggle all neons
    local allEnabled = true
    for _, pos in ipairs(neonPositions) do
        if not IsVehicleNeonLightEnabled(vehicle, pos.id) then
            allEnabled = false
            break
        end
    end
    
    table.insert(options, {
        title = allEnabled and 'Disable All Neons' or 'Enable All Neons',
        icon = 'lightbulb',
        iconColor = allEnabled and '#ff0000' or '#00ff00',
        onSelect = function()
            for _, pos in ipairs(neonPositions) do
                SetVehicleNeonLightEnabled(vehicle, pos.id, not allEnabled)
            end
            lib.notify({title = 'Neon Lights', description = allEnabled and 'All Disabled' or 'All Enabled', type = 'success'})
            openNeonLightsMenu()
        end
    })
    
    -- Individual neon positions
    for _, pos in ipairs(neonPositions) do
        local isEnabled = IsVehicleNeonLightEnabled(vehicle, pos.id)
        table.insert(options, {
            title = pos.name .. ' Neon',
            description = isEnabled and 'Currently ON' or 'Currently OFF',
            icon = 'lightbulb',
            iconColor = isEnabled and '#00ff00' or '#ff0000',
            onSelect = function()
                SetVehicleNeonLightEnabled(vehicle, pos.id, not isEnabled)
                lib.notify({title = pos.name .. ' Neon', description = isEnabled and 'Disabled' or 'Enabled', type = 'success'})
                openNeonLightsMenu()
            end
        })
    end
    
    -- Neon color option
    table.insert(options, {
        title = 'Change Neon Color',
        description = 'Set custom RGB color',
        icon = 'palette',
        iconColor = '#FF1493',
        onSelect = function()
            local r, g, b = GetVehicleNeonLightsColour(vehicle)
            local input = lib.inputDialog('Neon Color (RGB)', {
                {type = 'number', label = 'Red (0-255)', default = r, min = 0, max = 255, required = true},
                {type = 'number', label = 'Green (0-255)', default = g, min = 0, max = 255, required = true},
                {type = 'number', label = 'Blue (0-255)', default = b, min = 0, max = 255, required = true}
            })
            
            if input then
                SetVehicleNeonLightsColour(vehicle, input[1], input[2], input[3])
                lib.notify({title = 'Neon Color Changed', type = 'success'})
            end
            openNeonLightsMenu()
        end
    })
    
    lib.registerContext({
        id = 'neon_lights_menu',
        title = 'Neon Lights',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('neon_lights_menu')
end

local function openSpecificModMenu(modType, modName, parentMenu)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    local maxMod = GetNumVehicleMods(vehicle, modType)
    local currentMod = GetVehicleMod(vehicle, modType)
    
    local options = {}
    
    -- Stock/Remove option
    table.insert(options, {
        title = 'Stock / Remove',
        description = currentMod == -1 and 'Currently Active' or 'Click to apply',
        icon = 'xmark',
        iconColor = currentMod == -1 and '#00ff00' or '#ff0000',
        onSelect = function()
            RemoveVehicleMod(vehicle, modType)
            lib.notify({title = modName, description = 'Removed', type = 'success'})
            openSpecificModMenu(modType, modName, parentMenu)
        end
    })
    
    -- Mod options
    for i = 0, maxMod - 1 do
        local modLabel = GetModTextLabel(vehicle, modType, i)
        local modDisplayName = modLabel ~= 'NULL' and GetLabelText(modLabel) or ('Upgrade ' .. (i + 1))
        local isActive = currentMod == i
        
        table.insert(options, {
            title = modDisplayName,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'check',
            iconColor = isActive and '#00ff00' or '#1E90FF',
            onSelect = function()
                SetVehicleMod(vehicle, modType, i, false)
                lib.notify({title = modName, description = modDisplayName, type = 'success'})
                openSpecificModMenu(modType, modName, parentMenu)
            end
        })
    end
    
    lib.registerContext({
        id = 'specific_mod_menu',
        title = modName,
        menu = parentMenu,
        options = options
    })
    lib.showContext('specific_mod_menu')
end

local function openWindowTintMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local tints = {
        {name = 'None', id = 0},
        {name = 'Pure Black', id = 1},
        {name = 'Dark Smoke', id = 2},
        {name = 'Light Smoke', id = 3},
        {name = 'Stock', id = 4},
        {name = 'Limo', id = 5},
        {name = 'Green', id = 6}
    }
    
    local options = {}
    local currentTint = GetVehicleWindowTint(vehicle)
    
    for _, tint in ipairs(tints) do
        local isActive = currentTint == tint.id
        table.insert(options, {
            title = tint.name,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'window-maximize',
            iconColor = isActive and '#00ff00' or '#696969',
            onSelect = function()
                SetVehicleWindowTint(vehicle, tint.id)
                lib.notify({title = 'Window Tint Changed', description = tint.name, type = 'success'})
                openWindowTintMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'window_tint_menu',
        title = 'Window Tint',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('window_tint_menu')
end

local function openNeonLightsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local neonPositions = {
        {id = 0, name = 'Left'},
        {id = 1, name = 'Right'},
        {id = 2, name = 'Front'},
        {id = 3, name = 'Back'}
    }
    
    local options = {}
    
    -- Toggle all neons
    local allEnabled = true
    for _, pos in ipairs(neonPositions) do
        if not IsVehicleNeonLightEnabled(vehicle, pos.id) then
            allEnabled = false
            break
        end
    end
    
    table.insert(options, {
        title = allEnabled and 'Disable All Neons' or 'Enable All Neons',
        icon = 'lightbulb',
        iconColor = allEnabled and '#ff0000' or '#00ff00',
        onSelect = function()
            for _, pos in ipairs(neonPositions) do
                SetVehicleNeonLightEnabled(vehicle, pos.id, not allEnabled)
            end
            lib.notify({title = 'Neon Lights', description = allEnabled and 'All Disabled' or 'All Enabled', type = 'success'})
            openNeonLightsMenu()
        end
    })
    
    -- Individual neon positions
    for _, pos in ipairs(neonPositions) do
        local isEnabled = IsVehicleNeonLightEnabled(vehicle, pos.id)
        table.insert(options, {
            title = pos.name .. ' Neon',
            description = isEnabled and 'Currently ON' or 'Currently OFF',
            icon = 'lightbulb',
            iconColor = isEnabled and '#00ff00' or '#ff0000',
            onSelect = function()
                SetVehicleNeonLightEnabled(vehicle, pos.id, not isEnabled)
                lib.notify({title = pos.name .. ' Neon', description = isEnabled and 'Disabled' or 'Enabled', type = 'success'})
                openNeonLightsMenu()
            end
        })
    end
    
    -- Neon color option
    table.insert(options, {
        title = 'Change Neon Color',
        description = 'Set custom RGB color',
        icon = 'palette',
        iconColor = '#FF1493',
        onSelect = function()
            local r, g, b = GetVehicleNeonLightsColour(vehicle)
            local input = lib.inputDialog('Neon Color (RGB)', {
                {type = 'number', label = 'Red (0-255)', default = r, min = 0, max = 255, required = true},
                {type = 'number', label = 'Green (0-255)', default = g, min = 0, max = 255, required = true},
                {type = 'number', label = 'Blue (0-255)', default = b, min = 0, max = 255, required = true}
            })
            
            if input then
                SetVehicleNeonLightsColour(vehicle, input[1], input[2], input[3])
                lib.notify({title = 'Neon Color Changed', type = 'success'})
            end
            openNeonLightsMenu()
        end
    })
    
    lib.registerContext({
        id = 'neon_lights_menu',
        title = 'Neon Lights',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('neon_lights_menu')
end

local function openPerformanceModsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    
    local performanceMods = {
        {modType = 11, name = 'Engine', icon = 'gears'},
        {modType = 12, name = 'Brakes', icon = 'circle-stop'},
        {modType = 13, name = 'Transmission', icon = 'gauge-high'},
        {modType = 15, name = 'Suspension', icon = 'car-side'},
        {modType = 16, name = 'Armor', icon = 'shield-halved'}
    }
    
    local options = {}
    
    -- Turbo option
    local hasTurbo = IsToggleModOn(vehicle, 18)
    table.insert(options, {
        title = 'Turbo',
        description = hasTurbo and 'Currently ON' or 'Currently OFF',
        icon = 'wind',
        iconColor = hasTurbo and '#00ff00' or '#ff0000',
        onSelect = function()
            ToggleVehicleMod(vehicle, 18, not hasTurbo)
            lib.notify({title = 'Turbo', description = hasTurbo and 'Disabled' or 'Enabled', type = 'success'})
            openPerformanceModsMenu()
        end
    })
    
    -- Performance mods
    for _, mod in ipairs(performanceMods) do
        local maxMod = GetNumVehicleMods(vehicle, mod.modType)
        if maxMod > 0 then
            table.insert(options, {
                title = mod.name,
                description = 'Configure ' .. mod.name:lower() .. ' upgrades',
                icon = mod.icon,
                iconColor = '#1E90FF',
                onSelect = function()
                    openSpecificModMenu(mod.modType, mod.name, 'performance_mods_menu')
                end
            })
        end
    end
    
    if #options == 1 then
        table.insert(options, {
            title = 'No Performance Mods Available',
            icon = 'circle-xmark',
            disabled = true
        })
    end
    
    lib.registerContext({
        id = 'performance_mods_menu',
        title = 'Performance Upgrades',
        menu = 'vehicle_customization_menu',
        options = options
    })
    lib.showContext('performance_mods_menu')
end

local function openVisualModsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    
    local visualMods = {
        {modType = 0, name = 'Spoilers', icon = 'car-rear'},
        {modType = 1, name = 'Front Bumper', icon = 'car-burst'},
        {modType = 2, name = 'Rear Bumper', icon = 'car-burst'},
        {modType = 3, name = 'Side Skirt', icon = 'car-side'},
        {modType = 4, name = 'Exhaust', icon = 'wind'},
        {modType = 5, name = 'Frame', icon = 'border-all'},
        {modType = 6, name = 'Grille', icon = 'table-cells'},
        {modType = 7, name = 'Hood', icon = 'car'},
        {modType = 8, name = 'Fender', icon = 'car'},
        {modType = 9, name = 'Right Fender', icon = 'car'},
        {modType = 10, name = 'Roof', icon = 'house'},
        {modType = 23, name = 'Front Wheels', icon = 'circle'},
        {modType = 24, name = 'Back Wheels', icon = 'circle'},
        {modType = 25, name = 'Plate Holder', icon = 'address-card'},
        {modType = 26, name = 'Vanity Plates', icon = 'address-card'},
        {modType = 27, name = 'Trim', icon = 'paintbrush'},
        {modType = 28, name = 'Ornaments', icon = 'star'},
        {modType = 29, name = 'Dashboard', icon = 'gauge'},
        {modType = 30, name = 'Dial', icon = 'clock'},
        {modType = 31, name = 'Door Speaker', icon = 'volume-high'},
        {modType = 32, name = 'Seats', icon = 'chair'},
        {modType = 33, name = 'Steering Wheel', icon = 'circle-notch'},
        {modType = 34, name = 'Shifter Leavers', icon = 'gear'},
        {modType = 35, name = 'Plaques', icon = 'award'},
        {modType = 36, name = 'Speakers', icon = 'volume-up'},
        {modType = 37, name = 'Trunk', icon = 'box'},
        {modType = 38, name = 'Hydraulics', icon = 'arrows-up-down'},
        {modType = 39, name = 'Engine Block', icon = 'gears'},
        {modType = 40, name = 'Air Filter', icon = 'filter'},
        {modType = 41, name = 'Struts', icon = 'bars'},
        {modType = 42, name = 'Arch Cover', icon = 'car'},
        {modType = 43, name = 'Aerials', icon = 'tower-broadcast'},
        {modType = 44, name = 'Trim 2', icon = 'paintbrush'},
        {modType = 45, name = 'Tank', icon = 'gas-pump'},
        {modType = 46, name = 'Windows', icon = 'window-maximize'},
        {modType = 48, name = 'Livery', icon = 'palette'}
    }
    
    local options = {}
    
    -- Window tint option
    table.insert(options, {
        title = 'Window Tint',
        description = 'Change window tint level',
        icon = 'window-maximize',
        iconColor = '#696969',
        onSelect = function()
            openWindowTintMenu()
        end
    })
    
    -- Neon lights option
    table.insert(options, {
        title = 'Neon Lights',
        description = 'Configure neon underglow',
        icon = 'lightbulb',
        iconColor = '#FF1493',
        onSelect = function()
            openNeonLightsMenu()
        end
    })
    
    -- Visual mods
    for _, mod in ipairs(visualMods) do
        local maxMod = GetNumVehicleMods(vehicle, mod.modType)
        if maxMod > 0 then
            table.insert(options, {
                title = mod.name,
                description = 'Configure ' .. mod.name:lower(),
                icon = mod.icon,
                iconColor = '#9370DB',
                onSelect = function()
                    openSpecificModMenu(mod.modType, mod.name, 'visual_mods_menu')
                end
            })
        end
    end
    
    lib.registerContext({
        id = 'visual_mods_menu',
        title = 'Visual Modifications',
        menu = 'vehicle_customization_menu',
        options = options
    })
    lib.showContext('visual_mods_menu')
end

local function openWindowTintMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local tints = {
        {name = 'None', id = 0},
        {name = 'Pure Black', id = 1},
        {name = 'Dark Smoke', id = 2},
        {name = 'Light Smoke', id = 3},
        {name = 'Stock', id = 4},
        {name = 'Limo', id = 5},
        {name = 'Green', id = 6}
    }
    
    local options = {}
    local currentTint = GetVehicleWindowTint(vehicle)
    
    for _, tint in ipairs(tints) do
        local isActive = currentTint == tint.id
        table.insert(options, {
            title = tint.name,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'window-maximize',
            iconColor = isActive and '#00ff00' or '#696969',
            onSelect = function()
                SetVehicleWindowTint(vehicle, tint.id)
                lib.notify({title = 'Window Tint Changed', description = tint.name, type = 'success'})
                openWindowTintMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'window_tint_menu',
        title = 'Window Tint',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('window_tint_menu')
end

local function openNeonLightsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local neonPositions = {
        {id = 0, name = 'Left'},
        {id = 1, name = 'Right'},
        {id = 2, name = 'Front'},
        {id = 3, name = 'Back'}
    }
    
    local options = {}
    
    -- Toggle all neons
    local allEnabled = true
    for _, pos in ipairs(neonPositions) do
        if not IsVehicleNeonLightEnabled(vehicle, pos.id) then
            allEnabled = false
            break
        end
    end
    
    table.insert(options, {
        title = allEnabled and 'Disable All Neons' or 'Enable All Neons',
        icon = 'lightbulb',
        iconColor = allEnabled and '#ff0000' or '#00ff00',
        onSelect = function()
            for _, pos in ipairs(neonPositions) do
                SetVehicleNeonLightEnabled(vehicle, pos.id, not allEnabled)
            end
            lib.notify({title = 'Neon Lights', description = allEnabled and 'All Disabled' or 'All Enabled', type = 'success'})
            openNeonLightsMenu()
        end
    })
    
    -- Individual neon positions
    for _, pos in ipairs(neonPositions) do
        local isEnabled = IsVehicleNeonLightEnabled(vehicle, pos.id)
        table.insert(options, {
            title = pos.name .. ' Neon',
            description = isEnabled and 'Currently ON' or 'Currently OFF',
            icon = 'lightbulb',
            iconColor = isEnabled and '#00ff00' or '#ff0000',
            onSelect = function()
                SetVehicleNeonLightEnabled(vehicle, pos.id, not isEnabled)
                lib.notify({title = pos.name .. ' Neon', description = isEnabled and 'Disabled' or 'Enabled', type = 'success'})
                openNeonLightsMenu()
            end
        })
    end
    
    -- Neon color option
    table.insert(options, {
        title = 'Change Neon Color',
        description = 'Set custom RGB color',
        icon = 'palette',
        iconColor = '#FF1493',
        onSelect = function()
            local r, g, b = GetVehicleNeonLightsColour(vehicle)
            local input = lib.inputDialog('Neon Color (RGB)', {
                {type = 'number', label = 'Red (0-255)', default = r, min = 0, max = 255, required = true},
                {type = 'number', label = 'Green (0-255)', default = g, min = 0, max = 255, required = true},
                {type = 'number', label = 'Blue (0-255)', default = b, min = 0, max = 255, required = true}
            })
            
            if input then
                SetVehicleNeonLightsColour(vehicle, input[1], input[2], input[3])
                lib.notify({title = 'Neon Color Changed', type = 'success'})
            end
            openNeonLightsMenu()
        end
    })
    
    lib.registerContext({
        id = 'neon_lights_menu',
        title = 'Neon Lights',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('neon_lights_menu')
end

local function openSpecificModMenu(modType, modName, parentMenu)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    local maxMod = GetNumVehicleMods(vehicle, modType)
    local currentMod = GetVehicleMod(vehicle, modType)
    
    -- Performance mod level names
    local performanceLabels = {
        [11] = {'Stock Engine', 'Level 1 Engine', 'Level 2 Engine', 'Level 3 Engine', 'Level 4 Engine'},
        [12] = {'Stock Brakes', 'Street Brakes', 'Sport Brakes', 'Race Brakes'},
        [13] = {'Stock Transmission', 'Street Transmission', 'Sport Transmission', 'Race Transmission'},
        [15] = {'Stock Suspension', 'Lowered Suspension', 'Street Suspension', 'Sport Suspension', 'Competition Suspension'},
        [16] = {'No Armor', 'Armor Upgrade 20%', 'Armor Upgrade 40%', 'Armor Upgrade 60%', 'Armor Upgrade 80%', 'Armor Upgrade 100%'}
    }
    
    local options = {}
    
    -- Stock/Remove option
    table.insert(options, {
        title = 'Stock / Remove',
        description = currentMod == -1 and 'Currently Active' or 'Click to apply',
        icon = 'xmark',
        iconColor = currentMod == -1 and '#00ff00' or '#ff0000',
        onSelect = function()
            RemoveVehicleMod(vehicle, modType)
            lib.notify({title = modName, description = 'Removed', type = 'success'})
            openSpecificModMenu(modType, modName, parentMenu)
        end
    })
    
    -- Mod options
    for i = 0, maxMod - 1 do
        local modDisplayName
        
        -- Check if we have a custom label for this performance mod
        if performanceLabels[modType] and performanceLabels[modType][i + 1] then
            modDisplayName = performanceLabels[modType][i + 1]
        else
            -- Try to get the label from the game
            local modLabel = GetModTextLabel(vehicle, modType, i)
            local labelText = GetLabelText(modLabel)
            
            -- If label is valid and not the same as input (which means it wasn't found)
            if labelText and labelText ~= modLabel and labelText ~= 'NULL' then
                modDisplayName = labelText
            else
                -- Fallback to generic names
                modDisplayName = 'Upgrade ' .. (i + 1)
            end
        end
        
        local isActive = currentMod == i
        
        table.insert(options, {
            title = modDisplayName,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'check',
            iconColor = isActive and '#00ff00' or '#1E90FF',
            onSelect = function()
                SetVehicleMod(vehicle, modType, i, false)
                lib.notify({title = modName, description = modDisplayName, type = 'success'})
                openSpecificModMenu(modType, modName, parentMenu)
            end
        })
    end
    
    lib.registerContext({
        id = 'specific_mod_menu',
        title = modName,
        menu = parentMenu,
        options = options
    })
    lib.showContext('specific_mod_menu')
end

local function openWindowTintMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local tints = {
        {name = 'None', id = 0},
        {name = 'Pure Black', id = 1},
        {name = 'Dark Smoke', id = 2},
        {name = 'Light Smoke', id = 3},
        {name = 'Stock', id = 4},
        {name = 'Limo', id = 5},
        {name = 'Green', id = 6}
    }
    
    local options = {}
    local currentTint = GetVehicleWindowTint(vehicle)
    
    for _, tint in ipairs(tints) do
        local isActive = currentTint == tint.id
        table.insert(options, {
            title = tint.name,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'window-maximize',
            iconColor = isActive and '#00ff00' or '#696969',
            onSelect = function()
                SetVehicleWindowTint(vehicle, tint.id)
                lib.notify({title = 'Window Tint Changed', description = tint.name, type = 'success'})
                openWindowTintMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'window_tint_menu',
        title = 'Window Tint',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('window_tint_menu')
end

local function openNeonLightsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local neonPositions = {
        {id = 0, name = 'Left'},
        {id = 1, name = 'Right'},
        {id = 2, name = 'Front'},
        {id = 3, name = 'Back'}
    }
    
    local options = {}
    
    -- Toggle all neons
    local allEnabled = true
    for _, pos in ipairs(neonPositions) do
        if not IsVehicleNeonLightEnabled(vehicle, pos.id) then
            allEnabled = false
            break
        end
    end
    
    table.insert(options, {
        title = allEnabled and 'Disable All Neons' or 'Enable All Neons',
        icon = 'lightbulb',
        iconColor = allEnabled and '#ff0000' or '#00ff00',
        onSelect = function()
            for _, pos in ipairs(neonPositions) do
                SetVehicleNeonLightEnabled(vehicle, pos.id, not allEnabled)
            end
            lib.notify({title = 'Neon Lights', description = allEnabled and 'All Disabled' or 'All Enabled', type = 'success'})
            openNeonLightsMenu()
        end
    })
    
    -- Individual neon positions
    for _, pos in ipairs(neonPositions) do
        local isEnabled = IsVehicleNeonLightEnabled(vehicle, pos.id)
        table.insert(options, {
            title = pos.name .. ' Neon',
            description = isEnabled and 'Currently ON' or 'Currently OFF',
            icon = 'lightbulb',
            iconColor = isEnabled and '#00ff00' or '#ff0000',
            onSelect = function()
                SetVehicleNeonLightEnabled(vehicle, pos.id, not isEnabled)
                lib.notify({title = pos.name .. ' Neon', description = isEnabled and 'Disabled' or 'Enabled', type = 'success'})
                openNeonLightsMenu()
            end
        })
    end
    
    -- Neon color option
    table.insert(options, {
        title = 'Change Neon Color',
        description = 'Set custom RGB color',
        icon = 'palette',
        iconColor = '#FF1493',
        onSelect = function()
            local r, g, b = GetVehicleNeonLightsColour(vehicle)
            local input = lib.inputDialog('Neon Color (RGB)', {
                {type = 'number', label = 'Red (0-255)', default = r, min = 0, max = 255, required = true},
                {type = 'number', label = 'Green (0-255)', default = g, min = 0, max = 255, required = true},
                {type = 'number', label = 'Blue (0-255)', default = b, min = 0, max = 255, required = true}
            })
            
            if input then
                SetVehicleNeonLightsColour(vehicle, input[1], input[2], input[3])
                lib.notify({title = 'Neon Color Changed', type = 'success'})
            end
            openNeonLightsMenu()
        end
    })
    
    lib.registerContext({
        id = 'neon_lights_menu',
        title = 'Neon Lights',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('neon_lights_menu')
end

local function openPerformanceModsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    
    local performanceMods = {
        {modType = 11, name = 'Engine', icon = 'gears'},
        {modType = 12, name = 'Brakes', icon = 'circle-stop'},
        {modType = 13, name = 'Transmission', icon = 'gauge-high'},
        {modType = 15, name = 'Suspension', icon = 'car-side'},
        {modType = 16, name = 'Armor', icon = 'shield-halved'}
    }
    
    local options = {}
    
    -- Turbo option
    local hasTurbo = IsToggleModOn(vehicle, 18)
    table.insert(options, {
        title = 'Turbo',
        description = hasTurbo and 'Currently ON' or 'Currently OFF',
        icon = 'wind',
        iconColor = hasTurbo and '#00ff00' or '#ff0000',
        onSelect = function()
            ToggleVehicleMod(vehicle, 18, not hasTurbo)
            lib.notify({title = 'Turbo', description = hasTurbo and 'Disabled' or 'Enabled', type = 'success'})
            openPerformanceModsMenu()
        end
    })
    
    -- Performance mods
    for _, mod in ipairs(performanceMods) do
        local maxMod = GetNumVehicleMods(vehicle, mod.modType)
        if maxMod > 0 then
            table.insert(options, {
                title = mod.name,
                description = 'Configure ' .. mod.name:lower() .. ' upgrades',
                icon = mod.icon,
                iconColor = '#1E90FF',
                onSelect = function()
                    openSpecificModMenu(mod.modType, mod.name, 'performance_mods_menu')
                end
            })
        end
    end
    
    if #options == 1 then
        table.insert(options, {
            title = 'No Performance Mods Available',
            icon = 'circle-xmark',
            disabled = true
        })
    end
    
    lib.registerContext({
        id = 'performance_mods_menu',
        title = 'Performance Upgrades',
        menu = 'vehicle_customization_menu',
        options = options
    })
    lib.showContext('performance_mods_menu')
end

local function openVisualModsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    
    local visualMods = {
        {modType = 0, name = 'Spoilers', icon = 'car-rear'},
        {modType = 1, name = 'Front Bumper', icon = 'car-burst'},
        {modType = 2, name = 'Rear Bumper', icon = 'car-burst'},
        {modType = 3, name = 'Side Skirt', icon = 'car-side'},
        {modType = 4, name = 'Exhaust', icon = 'wind'},
        {modType = 5, name = 'Frame', icon = 'border-all'},
        {modType = 6, name = 'Grille', icon = 'table-cells'},
        {modType = 7, name = 'Hood', icon = 'car'},
        {modType = 8, name = 'Fender', icon = 'car'},
        {modType = 9, name = 'Right Fender', icon = 'car'},
        {modType = 10, name = 'Roof', icon = 'house'},
        {modType = 23, name = 'Front Wheels', icon = 'circle'},
        {modType = 24, name = 'Back Wheels', icon = 'circle'},
        {modType = 25, name = 'Plate Holder', icon = 'address-card'},
        {modType = 26, name = 'Vanity Plates', icon = 'address-card'},
        {modType = 27, name = 'Trim', icon = 'paintbrush'},
        {modType = 28, name = 'Ornaments', icon = 'star'},
        {modType = 29, name = 'Dashboard', icon = 'gauge'},
        {modType = 30, name = 'Dial', icon = 'clock'},
        {modType = 31, name = 'Door Speaker', icon = 'volume-high'},
        {modType = 32, name = 'Seats', icon = 'chair'},
        {modType = 33, name = 'Steering Wheel', icon = 'circle-notch'},
        {modType = 34, name = 'Shifter Leavers', icon = 'gear'},
        {modType = 35, name = 'Plaques', icon = 'award'},
        {modType = 36, name = 'Speakers', icon = 'volume-up'},
        {modType = 37, name = 'Trunk', icon = 'box'},
        {modType = 38, name = 'Hydraulics', icon = 'arrows-up-down'},
        {modType = 39, name = 'Engine Block', icon = 'gears'},
        {modType = 40, name = 'Air Filter', icon = 'filter'},
        {modType = 41, name = 'Struts', icon = 'bars'},
        {modType = 42, name = 'Arch Cover', icon = 'car'},
        {modType = 43, name = 'Aerials', icon = 'tower-broadcast'},
        {modType = 44, name = 'Trim 2', icon = 'paintbrush'},
        {modType = 45, name = 'Tank', icon = 'gas-pump'},
        {modType = 46, name = 'Windows', icon = 'window-maximize'},
        {modType = 48, name = 'Livery', icon = 'palette'}
    }
    
    local options = {}
    
    -- Window tint option
    table.insert(options, {
        title = 'Window Tint',
        description = 'Change window tint level',
        icon = 'window-maximize',
        iconColor = '#696969',
        onSelect = function()
            openWindowTintMenu()
        end
    })
    
    -- Neon lights option
    table.insert(options, {
        title = 'Neon Lights',
        description = 'Configure neon underglow',
        icon = 'lightbulb',
        iconColor = '#FF1493',
        onSelect = function()
            openNeonLightsMenu()
        end
    })
    
    -- Visual mods
    for _, mod in ipairs(visualMods) do
        local maxMod = GetNumVehicleMods(vehicle, mod.modType)
        if maxMod > 0 then
            table.insert(options, {
                title = mod.name,
                description = 'Configure ' .. mod.name:lower(),
                icon = mod.icon,
                iconColor = '#9370DB',
                onSelect = function()
                    openSpecificModMenu(mod.modType, mod.name, 'visual_mods_menu')
                end
            })
        end
    end
    
    lib.registerContext({
        id = 'visual_mods_menu',
        title = 'Visual Modifications',
        menu = 'vehicle_customization_menu',
        options = options
    })
    lib.showContext('visual_mods_menu')
end

local function openWindowTintMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local tints = {
        {name = 'None', id = 0},
        {name = 'Pure Black', id = 1},
        {name = 'Dark Smoke', id = 2},
        {name = 'Light Smoke', id = 3},
        {name = 'Stock', id = 4},
        {name = 'Limo', id = 5},
        {name = 'Green', id = 6}
    }
    
    local options = {}
    local currentTint = GetVehicleWindowTint(vehicle)
    
    for _, tint in ipairs(tints) do
        local isActive = currentTint == tint.id
        table.insert(options, {
            title = tint.name,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'window-maximize',
            iconColor = isActive and '#00ff00' or '#696969',
            onSelect = function()
                SetVehicleWindowTint(vehicle, tint.id)
                lib.notify({title = 'Window Tint Changed', description = tint.name, type = 'success'})
                openWindowTintMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'window_tint_menu',
        title = 'Window Tint',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('window_tint_menu')
end

local function openNeonLightsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local neonPositions = {
        {id = 0, name = 'Left'},
        {id = 1, name = 'Right'},
        {id = 2, name = 'Front'},
        {id = 3, name = 'Back'}
    }
    
    local options = {}
    
    -- Toggle all neons
    local allEnabled = true
    for _, pos in ipairs(neonPositions) do
        if not IsVehicleNeonLightEnabled(vehicle, pos.id) then
            allEnabled = false
            break
        end
    end
    
    table.insert(options, {
        title = allEnabled and 'Disable All Neons' or 'Enable All Neons',
        icon = 'lightbulb',
        iconColor = allEnabled and '#ff0000' or '#00ff00',
        onSelect = function()
            for _, pos in ipairs(neonPositions) do
                SetVehicleNeonLightEnabled(vehicle, pos.id, not allEnabled)
            end
            lib.notify({title = 'Neon Lights', description = allEnabled and 'All Disabled' or 'All Enabled', type = 'success'})
            openNeonLightsMenu()
        end
    })
    
    -- Individual neon positions
    for _, pos in ipairs(neonPositions) do
        local isEnabled = IsVehicleNeonLightEnabled(vehicle, pos.id)
        table.insert(options, {
            title = pos.name .. ' Neon',
            description = isEnabled and 'Currently ON' or 'Currently OFF',
            icon = 'lightbulb',
            iconColor = isEnabled and '#00ff00' or '#ff0000',
            onSelect = function()
                SetVehicleNeonLightEnabled(vehicle, pos.id, not isEnabled)
                lib.notify({title = pos.name .. ' Neon', description = isEnabled and 'Disabled' or 'Enabled', type = 'success'})
                openNeonLightsMenu()
            end
        })
    end
    
    -- Neon color option
    table.insert(options, {
        title = 'Change Neon Color',
        description = 'Set custom RGB color',
        icon = 'palette',
        iconColor = '#FF1493',
        onSelect = function()
            local r, g, b = GetVehicleNeonLightsColour(vehicle)
            local input = lib.inputDialog('Neon Color (RGB)', {
                {type = 'number', label = 'Red (0-255)', default = r, min = 0, max = 255, required = true},
                {type = 'number', label = 'Green (0-255)', default = g, min = 0, max = 255, required = true},
                {type = 'number', label = 'Blue (0-255)', default = b, min = 0, max = 255, required = true}
            })
            
            if input then
                SetVehicleNeonLightsColour(vehicle, input[1], input[2], input[3])
                lib.notify({title = 'Neon Color Changed', type = 'success'})
            end
            openNeonLightsMenu()
        end
    })
    
    lib.registerContext({
        id = 'neon_lights_menu',
        title = 'Neon Lights',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('neon_lights_menu')
end

local function openWheelModMenu(wheelType, wheelTypeName, parentMenu)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    
    -- Set the wheel type first
    SetVehicleWheelType(vehicle, wheelType)
    
    local maxMod = GetNumVehicleMods(vehicle, 23) -- 23 is front wheels
    local currentMod = GetVehicleMod(vehicle, 23)
    
    local options = {}
    
    -- Stock wheels option
    table.insert(options, {
        title = 'Stock Wheels',
        description = currentMod == -1 and 'Currently Active' or 'Click to apply',
        icon = 'circle',
        iconColor = currentMod == -1 and '#00ff00' or '#ff0000',
        onSelect = function()
            RemoveVehicleMod(vehicle, 23)
            lib.notify({title = 'Wheels', description = 'Stock wheels applied', type = 'success'})
            openWheelModMenu(wheelType, wheelTypeName, parentMenu)
        end
    })
    
    -- Wheel options
    for i = 0, maxMod - 1 do
        local modLabel = GetModTextLabel(vehicle, 23, i)
        local labelText = GetLabelText(modLabel)
        local modDisplayName
        
        if labelText and labelText ~= modLabel and labelText ~= 'NULL' then
            modDisplayName = labelText
        else
            modDisplayName = wheelTypeName .. ' Wheel ' .. (i + 1)
        end
        
        local isActive = currentMod == i
        
        table.insert(options, {
            title = modDisplayName,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'circle',
            iconColor = isActive and '#00ff00' or '#1E90FF',
            onSelect = function()
                SetVehicleWheelType(vehicle, wheelType)
                SetVehicleMod(vehicle, 23, i, false)
                lib.notify({title = 'Wheels', description = modDisplayName, type = 'success'})
                openWheelModMenu(wheelType, wheelTypeName, parentMenu)
            end
        })
    end
    
    lib.registerContext({
        id = 'wheel_mod_menu',
        title = wheelTypeName .. ' Wheels',
        menu = parentMenu,
        options = options
    })
    lib.showContext('wheel_mod_menu')
end

local function openWheelAccessoriesMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    
    local options = {}
    
    -- Custom Tires
    local hasCustomTires = GetVehicleModVariation(vehicle, 23)
    table.insert(options, {
        title = 'Custom Tires',
        description = hasCustomTires and 'Currently ON' or 'Currently OFF',
        icon = 'circle-notch',
        iconColor = hasCustomTires and '#00ff00' or '#ff0000',
        onSelect = function()
            local currentMod = GetVehicleMod(vehicle, 23)
            if currentMod ~= -1 then
                SetVehicleMod(vehicle, 23, currentMod, not hasCustomTires)
                lib.notify({title = 'Custom Tires', description = hasCustomTires and 'Disabled' or 'Enabled', type = 'success'})
            else
                lib.notify({title = 'Error', description = 'Install custom wheels first', type = 'error'})
            end
            openWheelAccessoriesMenu()
        end
    })
    
    -- Tire Smoke Color
    table.insert(options, {
        title = 'Tire Smoke Color',
        description = 'Set custom RGB color',
        icon = 'cloud',
        iconColor = '#B0C4DE',
        onSelect = function()
            local r, g, b = GetVehicleTyreSmokeColor(vehicle)
            local input = lib.inputDialog('Tire Smoke Color (RGB)', {
                {type = 'number', label = 'Red (0-255)', default = r, min = 0, max = 255, required = true},
                {type = 'number', label = 'Green (0-255)', default = g, min = 0, max = 255, required = true},
                {type = 'number', label = 'Blue (0-255)', default = b, min = 0, max = 255, required = true}
            })
            
            if input then
                SetVehicleModKit(vehicle, 0)
                ToggleVehicleMod(vehicle, 20, true)
                SetVehicleTyreSmokeColor(vehicle, input[1], input[2], input[3])
                lib.notify({title = 'Tire Smoke Color Changed', type = 'success'})
            end
            openWheelAccessoriesMenu()
        end
    })
    
    -- Bulletproof Tires
    local hasBulletproofTires = GetVehicleTyresCanBurst(vehicle) == false
    table.insert(options, {
        title = 'Bulletproof Tires',
        description = hasBulletproofTires and 'Currently ON' or 'Currently OFF',
        icon = 'shield',
        iconColor = hasBulletproofTires and '#00ff00' or '#ff0000',
        onSelect = function()
            SetVehicleTyresCanBurst(vehicle, hasBulletproofTires)
            lib.notify({title = 'Bulletproof Tires', description = hasBulletproofTires and 'Disabled' or 'Enabled', type = 'success'})
            openWheelAccessoriesMenu()
        end
    })
    
    -- Wheel Color (if custom wheels are installed)
    local currentMod = GetVehicleMod(vehicle, 23)
    if currentMod ~= -1 then
        table.insert(options, {
            title = 'Change Wheel Color',
            description = 'Modify wheel rim color',
            icon = 'palette',
            iconColor = '#FFD700',
            onSelect = function()
                openWheelColorMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'wheel_accessories_menu',
        title = 'Wheel Accessories',
        menu = 'wheels_main_menu',
        options = options
    })
    lib.showContext('wheel_accessories_menu')
end

local function openWheelColorMenu()
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
        {name = 'Blaze Red', id = 30}, {name = 'Hot Pink', id = 135}, {name = 'Salmon Pink', id = 136},
        {name = 'Orange', id = 38}, {name = 'Bright Orange', id = 138}, {name = 'Yellow', id = 88},
        {name = 'Race Yellow', id = 89}, {name = 'Dark Green', id = 49}, {name = 'Racing Green', id = 50},
        {name = 'Lime Green', id = 92}, {name = 'Midnight Blue', id = 141}, {name = 'Galaxy Blue', id = 61},
        {name = 'Dark Blue', id = 62}, {name = 'Blue', id = 64}, {name = 'Light Blue', id = 74},
        {name = 'Purple', id = 145}, {name = 'Spin Purple', id = 146}, {name = 'Gold', id = 37},
        {name = 'Bronze', id = 90}
    }
    
    local options = {}
    local currentColor = GetVehicleExtraColours(vehicle)
    
    for _, color in ipairs(colors) do
        local isActive = currentColor == color.id
        table.insert(options, {
            title = color.name,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'circle',
            iconColor = isActive and '#00ff00' or '#1E90FF',
            onSelect = function()
                local _, pearl = GetVehicleExtraColours(vehicle)
                SetVehicleExtraColours(vehicle, pearl or 0, color.id)
                lib.notify({title = 'Wheel Color Changed', description = color.name, type = 'success'})
                openWheelColorMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'wheel_color_menu',
        title = 'Wheel Color',
        menu = 'wheel_accessories_menu',
        options = options
    })
    lib.showContext('wheel_color_menu')
end

local function openWheelsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local wheelCategories = {
        {type = 0, name = 'Sport', icon = 'gauge'},
        {type = 1, name = 'Muscle', icon = 'fire'},
        {type = 2, name = 'Lowrider', icon = 'car-side'},
        {type = 3, name = 'SUV', icon = 'truck'},
        {type = 4, name = 'Offroad', icon = 'mountain'},
        {type = 5, name = 'Tuner', icon = 'wrench'},
        {type = 6, name = 'Bike Wheels', icon = 'motorcycle'},
        {type = 7, name = 'High End', icon = 'gem'},
        {type = 8, name = 'Benny\'s Original', icon = 'star'},
        {type = 9, name = 'Benny\'s Bespoke', icon = 'crown'},
        {type = 10, name = 'Open Wheel', icon = 'circle-notch'},
        {type = 11, name = 'Street', icon = 'road'},
        {type = 12, name = 'Track', icon = 'flag-checkered'}
    }
    
    local options = {}
    
    -- Wheel Accessories at the top
    table.insert(options, {
        title = 'Wheel Accessories',
        description = 'Custom tires, smoke, bulletproof',
        icon = 'gears',
        iconColor = '#FFA500',
        onSelect = function()
            openWheelAccessoriesMenu()
        end
    })
    
    -- Wheel categories
    for _, category in ipairs(wheelCategories) do
        table.insert(options, {
            title = category.name,
            description = 'Browse ' .. category.name:lower() .. ' wheels',
            icon = category.icon,
            iconColor = '#1E90FF',
            onSelect = function()
                openWheelModMenu(category.type, category.name, 'wheels_main_menu')
            end
        })
    end
    
    lib.registerContext({
        id = 'wheels_main_menu',
        title = 'Wheels',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('wheels_main_menu')
end

local function openSpecificModMenu(modType, modName, parentMenu)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    local maxMod = GetNumVehicleMods(vehicle, modType)
    local currentMod = GetVehicleMod(vehicle, modType)
    
    -- Performance mod level names
    local performanceLabels = {
        [11] = {'Stock Engine', 'Level 1 Engine', 'Level 2 Engine', 'Level 3 Engine', 'Level 4 Engine'},
        [12] = {'Stock Brakes', 'Street Brakes', 'Sport Brakes', 'Race Brakes'},
        [13] = {'Stock Transmission', 'Street Transmission', 'Sport Transmission', 'Race Transmission'},
        [15] = {'Stock Suspension', 'Lowered Suspension', 'Street Suspension', 'Sport Suspension', 'Competition Suspension'},
        [16] = {'No Armor', 'Armor Upgrade 20%', 'Armor Upgrade 40%', 'Armor Upgrade 60%', 'Armor Upgrade 80%', 'Armor Upgrade 100%'}
    }
    
    local options = {}
    
    -- Stock/Remove option
    table.insert(options, {
        title = 'Stock / Remove',
        description = currentMod == -1 and 'Currently Active' or 'Click to apply',
        icon = 'xmark',
        iconColor = currentMod == -1 and '#00ff00' or '#ff0000',
        onSelect = function()
            RemoveVehicleMod(vehicle, modType)
            lib.notify({title = modName, description = 'Removed', type = 'success'})
            openSpecificModMenu(modType, modName, parentMenu)
        end
    })
    
    -- Mod options
    for i = 0, maxMod - 1 do
        local modDisplayName
        
        -- Check if we have a custom label for this performance mod
        if performanceLabels[modType] and performanceLabels[modType][i + 1] then
            modDisplayName = performanceLabels[modType][i + 1]
        else
            -- Try to get the label from the game
            local modLabel = GetModTextLabel(vehicle, modType, i)
            local labelText = GetLabelText(modLabel)
            
            -- If label is valid and not the same as input (which means it wasn't found)
            if labelText and labelText ~= modLabel and labelText ~= 'NULL' then
                modDisplayName = labelText
            else
                -- Fallback to generic names
                modDisplayName = 'Upgrade ' .. (i + 1)
            end
        end
        
        local isActive = currentMod == i
        
        table.insert(options, {
            title = modDisplayName,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'check',
            iconColor = isActive and '#00ff00' or '#1E90FF',
            onSelect = function()
                SetVehicleMod(vehicle, modType, i, false)
                lib.notify({title = modName, description = modDisplayName, type = 'success'})
                openSpecificModMenu(modType, modName, parentMenu)
            end
        })
    end
    
    lib.registerContext({
        id = 'specific_mod_menu',
        title = modName,
        menu = parentMenu,
        options = options
    })
    lib.showContext('specific_mod_menu')
end

local function openWindowTintMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local tints = {
        {name = 'None', id = 0},
        {name = 'Pure Black', id = 1},
        {name = 'Dark Smoke', id = 2},
        {name = 'Light Smoke', id = 3},
        {name = 'Stock', id = 4},
        {name = 'Limo', id = 5},
        {name = 'Green', id = 6}
    }
    
    local options = {}
    local currentTint = GetVehicleWindowTint(vehicle)
    
    for _, tint in ipairs(tints) do
        local isActive = currentTint == tint.id
        table.insert(options, {
            title = tint.name,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'window-maximize',
            iconColor = isActive and '#00ff00' or '#696969',
            onSelect = function()
                SetVehicleWindowTint(vehicle, tint.id)
                lib.notify({title = 'Window Tint Changed', description = tint.name, type = 'success'})
                openWindowTintMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'window_tint_menu',
        title = 'Window Tint',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('window_tint_menu')
end

local function openNeonLightsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local neonPositions = {
        {id = 0, name = 'Left'},
        {id = 1, name = 'Right'},
        {id = 2, name = 'Front'},
        {id = 3, name = 'Back'}
    }
    
    local options = {}
    
    -- Toggle all neons
    local allEnabled = true
    for _, pos in ipairs(neonPositions) do
        if not IsVehicleNeonLightEnabled(vehicle, pos.id) then
            allEnabled = false
            break
        end
    end
    
    table.insert(options, {
        title = allEnabled and 'Disable All Neons' or 'Enable All Neons',
        icon = 'lightbulb',
        iconColor = allEnabled and '#ff0000' or '#00ff00',
        onSelect = function()
            for _, pos in ipairs(neonPositions) do
                SetVehicleNeonLightEnabled(vehicle, pos.id, not allEnabled)
            end
            lib.notify({title = 'Neon Lights', description = allEnabled and 'All Disabled' or 'All Enabled', type = 'success'})
            openNeonLightsMenu()
        end
    })
    
    -- Individual neon positions
    for _, pos in ipairs(neonPositions) do
        local isEnabled = IsVehicleNeonLightEnabled(vehicle, pos.id)
        table.insert(options, {
            title = pos.name .. ' Neon',
            description = isEnabled and 'Currently ON' or 'Currently OFF',
            icon = 'lightbulb',
            iconColor = isEnabled and '#00ff00' or '#ff0000',
            onSelect = function()
                SetVehicleNeonLightEnabled(vehicle, pos.id, not isEnabled)
                lib.notify({title = pos.name .. ' Neon', description = isEnabled and 'Disabled' or 'Enabled', type = 'success'})
                openNeonLightsMenu()
            end
        })
    end
    
    -- Neon color option
    table.insert(options, {
        title = 'Change Neon Color',
        description = 'Set custom RGB color',
        icon = 'palette',
        iconColor = '#FF1493',
        onSelect = function()
            local r, g, b = GetVehicleNeonLightsColour(vehicle)
            local input = lib.inputDialog('Neon Color (RGB)', {
                {type = 'number', label = 'Red (0-255)', default = r, min = 0, max = 255, required = true},
                {type = 'number', label = 'Green (0-255)', default = g, min = 0, max = 255, required = true},
                {type = 'number', label = 'Blue (0-255)', default = b, min = 0, max = 255, required = true}
            })
            
            if input then
                SetVehicleNeonLightsColour(vehicle, input[1], input[2], input[3])
                lib.notify({title = 'Neon Color Changed', type = 'success'})
            end
            openNeonLightsMenu()
        end
    })
    
    lib.registerContext({
        id = 'neon_lights_menu',
        title = 'Neon Lights',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('neon_lights_menu')
end

local function openPerformanceModsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    
    local performanceMods = {
        {modType = 11, name = 'Engine', icon = 'gears'},
        {modType = 12, name = 'Brakes', icon = 'circle-stop'},
        {modType = 13, name = 'Transmission', icon = 'gauge-high'},
        {modType = 15, name = 'Suspension', icon = 'car-side'},
        {modType = 16, name = 'Armor', icon = 'shield-halved'}
    }
    
    local options = {}
    
    -- Turbo option
    local hasTurbo = IsToggleModOn(vehicle, 18)
    table.insert(options, {
        title = 'Turbo',
        description = hasTurbo and 'Currently ON' or 'Currently OFF',
        icon = 'wind',
        iconColor = hasTurbo and '#00ff00' or '#ff0000',
        onSelect = function()
            ToggleVehicleMod(vehicle, 18, not hasTurbo)
            lib.notify({title = 'Turbo', description = hasTurbo and 'Disabled' or 'Enabled', type = 'success'})
            openPerformanceModsMenu()
        end
    })
    
    -- Performance mods
    for _, mod in ipairs(performanceMods) do
        local maxMod = GetNumVehicleMods(vehicle, mod.modType)
        if maxMod > 0 then
            table.insert(options, {
                title = mod.name,
                description = 'Configure ' .. mod.name:lower() .. ' upgrades',
                icon = mod.icon,
                iconColor = '#1E90FF',
                onSelect = function()
                    openSpecificModMenu(mod.modType, mod.name, 'performance_mods_menu')
                end
            })
        end
    end
    
    if #options == 1 then
        table.insert(options, {
            title = 'No Performance Mods Available',
            icon = 'circle-xmark',
            disabled = true
        })
    end
    
    lib.registerContext({
        id = 'performance_mods_menu',
        title = 'Performance Upgrades',
        menu = 'vehicle_customization_menu',
        options = options
    })
    lib.showContext('performance_mods_menu')
end

local function openVisualModsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    
    local visualMods = {
        {modType = 0, name = 'Spoilers', icon = 'car-rear'},
        {modType = 1, name = 'Front Bumper', icon = 'car-burst'},
        {modType = 2, name = 'Rear Bumper', icon = 'car-burst'},
        {modType = 3, name = 'Side Skirt', icon = 'car-side'},
        {modType = 4, name = 'Exhaust', icon = 'wind'},
        {modType = 5, name = 'Frame', icon = 'border-all'},
        {modType = 6, name = 'Grille', icon = 'table-cells'},
        {modType = 7, name = 'Hood', icon = 'car'},
        {modType = 8, name = 'Fender', icon = 'car'},
        {modType = 9, name = 'Right Fender', icon = 'car'},
        {modType = 10, name = 'Roof', icon = 'house'},
        {modType = 25, name = 'Plate Holder', icon = 'address-card'},
        {modType = 26, name = 'Vanity Plates', icon = 'address-card'},
        {modType = 27, name = 'Trim', icon = 'paintbrush'},
        {modType = 28, name = 'Ornaments', icon = 'star'},
        {modType = 29, name = 'Dashboard', icon = 'gauge'},
        {modType = 30, name = 'Dial', icon = 'clock'},
        {modType = 31, name = 'Door Speaker', icon = 'volume-high'},
        {modType = 32, name = 'Seats', icon = 'chair'},
        {modType = 33, name = 'Steering Wheel', icon = 'circle-notch'},
        {modType = 34, name = 'Shifter Leavers', icon = 'gear'},
        {modType = 35, name = 'Plaques', icon = 'award'},
        {modType = 36, name = 'Speakers', icon = 'volume-up'},
        {modType = 37, name = 'Trunk', icon = 'box'},
        {modType = 38, name = 'Hydraulics', icon = 'arrows-up-down'},
        {modType = 39, name = 'Engine Block', icon = 'gears'},
        {modType = 40, name = 'Air Filter', icon = 'filter'},
        {modType = 41, name = 'Struts', icon = 'bars'},
        {modType = 42, name = 'Arch Cover', icon = 'car'},
        {modType = 43, name = 'Aerials', icon = 'tower-broadcast'},
        {modType = 44, name = 'Trim 2', icon = 'paintbrush'},
        {modType = 45, name = 'Tank', icon = 'gas-pump'},
        {modType = 46, name = 'Windows', icon = 'window-maximize'},
        {modType = 48, name = 'Livery', icon = 'palette'}
    }
    
    local options = {}
    
    -- Window tint option
    table.insert(options, {
        title = 'Window Tint',
        description = 'Change window tint level',
        icon = 'window-maximize',
        iconColor = '#696969',
        onSelect = function()
            openWindowTintMenu()
        end
    })
    
    -- Neon lights option
    table.insert(options, {
        title = 'Neon Lights',
        description = 'Configure neon underglow',
        icon = 'lightbulb',
        iconColor = '#FF1493',
        onSelect = function()
            openNeonLightsMenu()
        end
    })
    
    -- Wheels option (new categorized menu)
    table.insert(options, {
        title = 'Wheels',
        description = 'Browse wheels by category',
        icon = 'circle',
        iconColor = '#FFD700',
        onSelect = function()
            openWheelsMenu()
        end
    })
    
    -- Visual mods
    for _, mod in ipairs(visualMods) do
        local maxMod = GetNumVehicleMods(vehicle, mod.modType)
        if maxMod > 0 then
            table.insert(options, {
                title = mod.name,
                description = 'Configure ' .. mod.name:lower(),
                icon = mod.icon,
                iconColor = '#9370DB',
                onSelect = function()
                    openSpecificModMenu(mod.modType, mod.name, 'visual_mods_menu')
                end
            })
        end
    end
    
    lib.registerContext({
        id = 'visual_mods_menu',
        title = 'Visual Modifications',
        menu = 'vehicle_customization_menu',
        options = options
    })
    lib.showContext('visual_mods_menu')
end

local function openWindowTintMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local tints = {
        {name = 'None', id = 0},
        {name = 'Pure Black', id = 1},
        {name = 'Dark Smoke', id = 2},
        {name = 'Light Smoke', id = 3},
        {name = 'Stock', id = 4},
        {name = 'Limo', id = 5},
        {name = 'Green', id = 6}
    }
    
    local options = {}
    local currentTint = GetVehicleWindowTint(vehicle)
    
    for _, tint in ipairs(tints) do
        local isActive = currentTint == tint.id
        table.insert(options, {
            title = tint.name,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'window-maximize',
            iconColor = isActive and '#00ff00' or '#696969',
            onSelect = function()
                SetVehicleWindowTint(vehicle, tint.id)
                lib.notify({title = 'Window Tint Changed', description = tint.name, type = 'success'})
                openWindowTintMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'window_tint_menu',
        title = 'Window Tint',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('window_tint_menu')
end

local function openNeonLightsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local neonPositions = {
        {id = 0, name = 'Left'},
        {id = 1, name = 'Right'},
        {id = 2, name = 'Front'},
        {id = 3, name = 'Back'}
    }
    
    local options = {}
    
    -- Toggle all neons
    local allEnabled = true
    for _, pos in ipairs(neonPositions) do
        if not IsVehicleNeonLightEnabled(vehicle, pos.id) then
            allEnabled = false
            break
        end
    end
    
    table.insert(options, {
        title = allEnabled and 'Disable All Neons' or 'Enable All Neons',
        icon = 'lightbulb',
        iconColor = allEnabled and '#ff0000' or '#00ff00',
        onSelect = function()
            for _, pos in ipairs(neonPositions) do
                SetVehicleNeonLightEnabled(vehicle, pos.id, not allEnabled)
            end
            lib.notify({title = 'Neon Lights', description = allEnabled and 'All Disabled' or 'All Enabled', type = 'success'})
            openNeonLightsMenu()
        end
    })
    
    -- Individual neon positions
    for _, pos in ipairs(neonPositions) do
        local isEnabled = IsVehicleNeonLightEnabled(vehicle, pos.id)
        table.insert(options, {
            title = pos.name .. ' Neon',
            description = isEnabled and 'Currently ON' or 'Currently OFF',
            icon = 'lightbulb',
            iconColor = isEnabled and '#00ff00' or '#ff0000',
            onSelect = function()
                SetVehicleNeonLightEnabled(vehicle, pos.id, not isEnabled)
                lib.notify({title = pos.name .. ' Neon', description = isEnabled and 'Disabled' or 'Enabled', type = 'success'})
                openNeonLightsMenu()
            end
        })
    end
    
    -- Neon color option
    table.insert(options, {
        title = 'Change Neon Color',
        description = 'Set custom RGB color',
        icon = 'palette',
        iconColor = '#FF1493',
        onSelect = function()
            local r, g, b = GetVehicleNeonLightsColour(vehicle)
            local input = lib.inputDialog('Neon Color (RGB)', {
                {type = 'number', label = 'Red (0-255)', default = r, min = 0, max = 255, required = true},
                {type = 'number', label = 'Green (0-255)', default = g, min = 0, max = 255, required = true},
                {type = 'number', label = 'Blue (0-255)', default = b, min = 0, max = 255, required = true}
            })
            
            if input then
                SetVehicleNeonLightsColour(vehicle, input[1], input[2], input[3])
                lib.notify({title = 'Neon Color Changed', type = 'success'})
            end
            openNeonLightsMenu()
        end
    })
    
    lib.registerContext({
        id = 'neon_lights_menu',
        title = 'Neon Lights',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('neon_lights_menu')
end

local function openWheelModMenu(wheelType, wheelTypeName, parentMenu)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    
    -- Set the wheel type first
    SetVehicleWheelType(vehicle, wheelType)
    
    local maxMod = GetNumVehicleMods(vehicle, 23) -- 23 is front wheels
    local currentMod = GetVehicleMod(vehicle, 23)
    
    local options = {}
    
    -- Stock wheels option
    table.insert(options, {
        title = 'Stock Wheels',
        description = currentMod == -1 and 'Currently Active' or 'Click to apply',
        icon = 'circle',
        iconColor = currentMod == -1 and '#00ff00' or '#ff0000',
        onSelect = function()
            RemoveVehicleMod(vehicle, 23)
            lib.notify({title = 'Wheels', description = 'Stock wheels applied', type = 'success'})
            openWheelModMenu(wheelType, wheelTypeName, parentMenu)
        end
    })
    
    -- Wheel options
    for i = 0, maxMod - 1 do
        local modLabel = GetModTextLabel(vehicle, 23, i)
        local labelText = GetLabelText(modLabel)
        local modDisplayName
        
        if labelText and labelText ~= modLabel and labelText ~= 'NULL' then
            modDisplayName = labelText
        else
            modDisplayName = wheelTypeName .. ' Wheel ' .. (i + 1)
        end
        
        local isActive = currentMod == i
        
        table.insert(options, {
            title = modDisplayName,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'circle',
            iconColor = isActive and '#00ff00' or '#1E90FF',
            onSelect = function()
                SetVehicleWheelType(vehicle, wheelType)
                SetVehicleMod(vehicle, 23, i, false)
                lib.notify({title = 'Wheels', description = modDisplayName, type = 'success'})
                openWheelModMenu(wheelType, wheelTypeName, parentMenu)
            end
        })
    end
    
    lib.registerContext({
        id = 'wheel_mod_menu',
        title = wheelTypeName .. ' Wheels',
        menu = parentMenu,
        options = options
    })
    lib.showContext('wheel_mod_menu')
end

local function openWheelAccessoriesMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    
    local options = {}
    
    -- Custom Tires
    local hasCustomTires = GetVehicleModVariation(vehicle, 23)
    table.insert(options, {
        title = 'Custom Tires',
        description = hasCustomTires and 'Currently ON' or 'Currently OFF',
        icon = 'circle-notch',
        iconColor = hasCustomTires and '#00ff00' or '#ff0000',
        onSelect = function()
            local currentMod = GetVehicleMod(vehicle, 23)
            if currentMod ~= -1 then
                SetVehicleMod(vehicle, 23, currentMod, not hasCustomTires)
                lib.notify({title = 'Custom Tires', description = hasCustomTires and 'Disabled' or 'Enabled', type = 'success'})
            else
                lib.notify({title = 'Error', description = 'Install custom wheels first', type = 'error'})
            end
            openWheelAccessoriesMenu()
        end
    })
    
    -- Tire Smoke Color
    table.insert(options, {
        title = 'Tire Smoke Color',
        description = 'Set custom RGB color',
        icon = 'cloud',
        iconColor = '#B0C4DE',
        onSelect = function()
            local r, g, b = GetVehicleTyreSmokeColor(vehicle)
            local input = lib.inputDialog('Tire Smoke Color (RGB)', {
                {type = 'number', label = 'Red (0-255)', default = r, min = 0, max = 255, required = true},
                {type = 'number', label = 'Green (0-255)', default = g, min = 0, max = 255, required = true},
                {type = 'number', label = 'Blue (0-255)', default = b, min = 0, max = 255, required = true}
            })
            
            if input then
                SetVehicleModKit(vehicle, 0)
                ToggleVehicleMod(vehicle, 20, true)
                SetVehicleTyreSmokeColor(vehicle, input[1], input[2], input[3])
                lib.notify({title = 'Tire Smoke Color Changed', type = 'success'})
            end
            openWheelAccessoriesMenu()
        end
    })
    
    -- Bulletproof Tires
    local hasBulletproofTires = GetVehicleTyresCanBurst(vehicle) == false
    table.insert(options, {
        title = 'Bulletproof Tires',
        description = hasBulletproofTires and 'Currently ON' or 'Currently OFF',
        icon = 'shield',
        iconColor = hasBulletproofTires and '#00ff00' or '#ff0000',
        onSelect = function()
            SetVehicleTyresCanBurst(vehicle, hasBulletproofTires)
            lib.notify({title = 'Bulletproof Tires', description = hasBulletproofTires and 'Disabled' or 'Enabled', type = 'success'})
            openWheelAccessoriesMenu()
        end
    })
    
    -- Wheel Color (if custom wheels are installed)
    local currentMod = GetVehicleMod(vehicle, 23)
    if currentMod ~= -1 then
        table.insert(options, {
            title = 'Change Wheel Color',
            description = 'Modify wheel rim color',
            icon = 'palette',
            iconColor = '#FFD700',
            onSelect = function()
                openWheelColorMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'wheel_accessories_menu',
        title = 'Wheel Accessories',
        menu = 'wheels_main_menu',
        options = options
    })
    lib.showContext('wheel_accessories_menu')
end

local function openWheelColorMenu()
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
        {name = 'Blaze Red', id = 30}, {name = 'Hot Pink', id = 135}, {name = 'Salmon Pink', id = 136},
        {name = 'Orange', id = 38}, {name = 'Bright Orange', id = 138}, {name = 'Yellow', id = 88},
        {name = 'Race Yellow', id = 89}, {name = 'Dark Green', id = 49}, {name = 'Racing Green', id = 50},
        {name = 'Lime Green', id = 92}, {name = 'Midnight Blue', id = 141}, {name = 'Galaxy Blue', id = 61},
        {name = 'Dark Blue', id = 62}, {name = 'Blue', id = 64}, {name = 'Light Blue', id = 74},
        {name = 'Purple', id = 145}, {name = 'Spin Purple', id = 146}, {name = 'Gold', id = 37},
        {name = 'Bronze', id = 90}
    }
    
    local options = {}
    local currentColor = GetVehicleExtraColours(vehicle)
    
    for _, color in ipairs(colors) do
        local isActive = currentColor == color.id
        table.insert(options, {
            title = color.name,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'circle',
            iconColor = isActive and '#00ff00' or '#1E90FF',
            onSelect = function()
                local _, pearl = GetVehicleExtraColours(vehicle)
                SetVehicleExtraColours(vehicle, pearl or 0, color.id)
                lib.notify({title = 'Wheel Color Changed', description = color.name, type = 'success'})
                openWheelColorMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'wheel_color_menu',
        title = 'Wheel Color',
        menu = 'wheel_accessories_menu',
        options = options
    })
    lib.showContext('wheel_color_menu')
end

local function openWheelsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local wheelCategories = {
        {type = 0, name = 'Sport', icon = 'gauge'},
        {type = 1, name = 'Muscle', icon = 'fire'},
        {type = 2, name = 'Lowrider', icon = 'car-side'},
        {type = 3, name = 'SUV', icon = 'truck'},
        {type = 4, name = 'Offroad', icon = 'mountain'},
        {type = 5, name = 'Tuner', icon = 'wrench'},
        {type = 6, name = 'Bike Wheels', icon = 'motorcycle'},
        {type = 7, name = 'High End', icon = 'gem'},
        {type = 8, name = 'Benny\'s Original', icon = 'star'},
        {type = 9, name = 'Benny\'s Bespoke', icon = 'crown'},
        {type = 10, name = 'Open Wheel', icon = 'circle-notch'},
        {type = 11, name = 'Street', icon = 'road'},
        {type = 12, name = 'Track', icon = 'flag-checkered'}
    }
    
    local options = {}
    
    -- Wheel Accessories at the top
    table.insert(options, {
        title = 'Wheel Accessories',
        description = 'Custom tires, smoke, bulletproof',
        icon = 'gears',
        iconColor = '#FFA500',
        onSelect = function()
            openWheelAccessoriesMenu()
        end
    })
    
    -- Wheel categories
    for _, category in ipairs(wheelCategories) do
        table.insert(options, {
            title = category.name,
            description = 'Browse ' .. category.name:lower() .. ' wheels',
            icon = category.icon,
            iconColor = '#1E90FF',
            onSelect = function()
                openWheelModMenu(category.type, category.name, 'wheels_main_menu')
            end
        })
    end
    
    lib.registerContext({
        id = 'wheels_main_menu',
        title = 'Wheels',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('wheels_main_menu')
end

local function openSpecificModMenu(modType, modName, parentMenu)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    local maxMod = GetNumVehicleMods(vehicle, modType)
    local currentMod = GetVehicleMod(vehicle, modType)
    
    -- Performance mod level names
    local performanceLabels = {
        [11] = {'Stock Engine', 'Level 1 Engine', 'Level 2 Engine', 'Level 3 Engine', 'Level 4 Engine'},
        [12] = {'Stock Brakes', 'Street Brakes', 'Sport Brakes', 'Race Brakes'},
        [13] = {'Stock Transmission', 'Street Transmission', 'Sport Transmission', 'Race Transmission'},
        [15] = {'Stock Suspension', 'Lowered Suspension', 'Street Suspension', 'Sport Suspension', 'Competition Suspension'},
        [16] = {'No Armor', 'Armor Upgrade 20%', 'Armor Upgrade 40%', 'Armor Upgrade 60%', 'Armor Upgrade 80%', 'Armor Upgrade 100%'}
    }
    
    local options = {}
    
    -- Stock/Remove option
    table.insert(options, {
        title = 'Stock / Remove',
        description = currentMod == -1 and 'Currently Active' or 'Click to apply',
        icon = 'xmark',
        iconColor = currentMod == -1 and '#00ff00' or '#ff0000',
        onSelect = function()
            RemoveVehicleMod(vehicle, modType)
            lib.notify({title = modName, description = 'Removed', type = 'success'})
            openSpecificModMenu(modType, modName, parentMenu)
        end
    })
    
    -- Mod options
    for i = 0, maxMod - 1 do
        local modDisplayName
        
        -- Check if we have a custom label for this performance mod
        if performanceLabels[modType] and performanceLabels[modType][i + 1] then
            modDisplayName = performanceLabels[modType][i + 1]
        else
            -- Try to get the label from the game
            local modLabel = GetModTextLabel(vehicle, modType, i)
            local labelText = GetLabelText(modLabel)
            
            -- If label is valid and not the same as input (which means it wasn't found)
            if labelText and labelText ~= modLabel and labelText ~= 'NULL' then
                modDisplayName = labelText
            else
                -- Fallback to generic names
                modDisplayName = 'Upgrade ' .. (i + 1)
            end
        end
        
        local isActive = currentMod == i
        
        table.insert(options, {
            title = modDisplayName,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'check',
            iconColor = isActive and '#00ff00' or '#1E90FF',
            onSelect = function()
                SetVehicleMod(vehicle, modType, i, false)
                lib.notify({title = modName, description = modDisplayName, type = 'success'})
                openSpecificModMenu(modType, modName, parentMenu)
            end
        })
    end
    
    lib.registerContext({
        id = 'specific_mod_menu',
        title = modName,
        menu = parentMenu,
        options = options
    })
    lib.showContext('specific_mod_menu')
end

local function openWindowTintMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local tints = {
        {name = 'None', id = 0},
        {name = 'Pure Black', id = 1},
        {name = 'Dark Smoke', id = 2},
        {name = 'Light Smoke', id = 3},
        {name = 'Stock', id = 4},
        {name = 'Limo', id = 5},
        {name = 'Green', id = 6}
    }
    
    local options = {}
    local currentTint = GetVehicleWindowTint(vehicle)
    
    for _, tint in ipairs(tints) do
        local isActive = currentTint == tint.id
        table.insert(options, {
            title = tint.name,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'window-maximize',
            iconColor = isActive and '#00ff00' or '#696969',
            onSelect = function()
                SetVehicleWindowTint(vehicle, tint.id)
                lib.notify({title = 'Window Tint Changed', description = tint.name, type = 'success'})
                openWindowTintMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'window_tint_menu',
        title = 'Window Tint',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('window_tint_menu')
end

local function openNeonLightsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local neonPositions = {
        {id = 0, name = 'Left'},
        {id = 1, name = 'Right'},
        {id = 2, name = 'Front'},
        {id = 3, name = 'Back'}
    }
    
    local options = {}
    
    -- Toggle all neons
    local allEnabled = true
    for _, pos in ipairs(neonPositions) do
        if not IsVehicleNeonLightEnabled(vehicle, pos.id) then
            allEnabled = false
            break
        end
    end
    
    table.insert(options, {
        title = allEnabled and 'Disable All Neons' or 'Enable All Neons',
        icon = 'lightbulb',
        iconColor = allEnabled and '#ff0000' or '#00ff00',
        onSelect = function()
            for _, pos in ipairs(neonPositions) do
                SetVehicleNeonLightEnabled(vehicle, pos.id, not allEnabled)
            end
            lib.notify({title = 'Neon Lights', description = allEnabled and 'All Disabled' or 'All Enabled', type = 'success'})
            openNeonLightsMenu()
        end
    })
    
    -- Individual neon positions
    for _, pos in ipairs(neonPositions) do
        local isEnabled = IsVehicleNeonLightEnabled(vehicle, pos.id)
        table.insert(options, {
            title = pos.name .. ' Neon',
            description = isEnabled and 'Currently ON' or 'Currently OFF',
            icon = 'lightbulb',
            iconColor = isEnabled and '#00ff00' or '#ff0000',
            onSelect = function()
                SetVehicleNeonLightEnabled(vehicle, pos.id, not isEnabled)
                lib.notify({title = pos.name .. ' Neon', description = isEnabled and 'Disabled' or 'Enabled', type = 'success'})
                openNeonLightsMenu()
            end
        })
    end
    
    -- Neon color option
    table.insert(options, {
        title = 'Change Neon Color',
        description = 'Set custom RGB color',
        icon = 'palette',
        iconColor = '#FF1493',
        onSelect = function()
            local r, g, b = GetVehicleNeonLightsColour(vehicle)
            local input = lib.inputDialog('Neon Color (RGB)', {
                {type = 'number', label = 'Red (0-255)', default = r, min = 0, max = 255, required = true},
                {type = 'number', label = 'Green (0-255)', default = g, min = 0, max = 255, required = true},
                {type = 'number', label = 'Blue (0-255)', default = b, min = 0, max = 255, required = true}
            })
            
            if input then
                SetVehicleNeonLightsColour(vehicle, input[1], input[2], input[3])
                lib.notify({title = 'Neon Color Changed', type = 'success'})
            end
            openNeonLightsMenu()
        end
    })
    
    lib.registerContext({
        id = 'neon_lights_menu',
        title = 'Neon Lights',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('neon_lights_menu')
end

local function openPerformanceModsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    
    local performanceMods = {
        {modType = 11, name = 'Engine', icon = 'gears'},
        {modType = 12, name = 'Brakes', icon = 'circle-stop'},
        {modType = 13, name = 'Transmission', icon = 'gauge-high'},
        {modType = 15, name = 'Suspension', icon = 'car-side'},
        {modType = 16, name = 'Armor', icon = 'shield-halved'}
    }
    
    local options = {}
    
    -- Turbo option
    local hasTurbo = IsToggleModOn(vehicle, 18)
    table.insert(options, {
        title = 'Turbo',
        description = hasTurbo and 'Currently ON' or 'Currently OFF',
        icon = 'wind',
        iconColor = hasTurbo and '#00ff00' or '#ff0000',
        onSelect = function()
            ToggleVehicleMod(vehicle, 18, not hasTurbo)
            lib.notify({title = 'Turbo', description = hasTurbo and 'Disabled' or 'Enabled', type = 'success'})
            openPerformanceModsMenu()
        end
    })
    
    -- Performance mods
    for _, mod in ipairs(performanceMods) do
        local maxMod = GetNumVehicleMods(vehicle, mod.modType)
        if maxMod > 0 then
            table.insert(options, {
                title = mod.name,
                description = 'Configure ' .. mod.name:lower() .. ' upgrades',
                icon = mod.icon,
                iconColor = '#1E90FF',
                onSelect = function()
                    openSpecificModMenu(mod.modType, mod.name, 'performance_mods_menu')
                end
            })
        end
    end
    
    if #options == 1 then
        table.insert(options, {
            title = 'No Performance Mods Available',
            icon = 'circle-xmark',
            disabled = true
        })
    end
    
    lib.registerContext({
        id = 'performance_mods_menu',
        title = 'Performance Upgrades',
        menu = 'vehicle_customization_menu',
        options = options
    })
    lib.showContext('performance_mods_menu')
end

local function openVisualModsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    
    local visualMods = {
        {modType = 0, name = 'Spoilers', icon = 'car-rear'},
        {modType = 1, name = 'Front Bumper', icon = 'car-burst'},
        {modType = 2, name = 'Rear Bumper', icon = 'car-burst'},
        {modType = 3, name = 'Side Skirt', icon = 'car-side'},
        {modType = 4, name = 'Exhaust', icon = 'wind'},
        {modType = 5, name = 'Frame', icon = 'border-all'},
        {modType = 6, name = 'Grille', icon = 'table-cells'},
        {modType = 7, name = 'Hood', icon = 'car'},
        {modType = 8, name = 'Fender', icon = 'car'},
        {modType = 9, name = 'Right Fender', icon = 'car'},
        {modType = 10, name = 'Roof', icon = 'house'},
        {modType = 25, name = 'Plate Holder', icon = 'address-card'},
        {modType = 26, name = 'Vanity Plates', icon = 'address-card'},
        {modType = 27, name = 'Trim', icon = 'paintbrush'},
        {modType = 28, name = 'Ornaments', icon = 'star'},
        {modType = 29, name = 'Dashboard', icon = 'gauge'},
        {modType = 30, name = 'Dial', icon = 'clock'},
        {modType = 31, name = 'Door Speaker', icon = 'volume-high'},
        {modType = 32, name = 'Seats', icon = 'chair'},
        {modType = 33, name = 'Steering Wheel', icon = 'circle-notch'},
        {modType = 34, name = 'Shifter Leavers', icon = 'gear'},
        {modType = 35, name = 'Plaques', icon = 'award'},
        {modType = 36, name = 'Speakers', icon = 'volume-up'},
        {modType = 37, name = 'Trunk', icon = 'box'},
        {modType = 38, name = 'Hydraulics', icon = 'arrows-up-down'},
        {modType = 39, name = 'Engine Block', icon = 'gears'},
        {modType = 40, name = 'Air Filter', icon = 'filter'},
        {modType = 41, name = 'Struts', icon = 'bars'},
        {modType = 42, name = 'Arch Cover', icon = 'car'},
        {modType = 43, name = 'Aerials', icon = 'tower-broadcast'},
        {modType = 44, name = 'Trim 2', icon = 'paintbrush'},
        {modType = 45, name = 'Tank', icon = 'gas-pump'},
        {modType = 46, name = 'Windows', icon = 'window-maximize'},
        {modType = 48, name = 'Livery', icon = 'palette'}
    }
    
    local options = {}
    
    -- Window tint option
    table.insert(options, {
        title = 'Window Tint',
        description = 'Change window tint level',
        icon = 'window-maximize',
        iconColor = '#696969',
        onSelect = function()
            openWindowTintMenu()
        end
    })
    
    -- Neon lights option
    table.insert(options, {
        title = 'Neon Lights',
        description = 'Configure neon underglow',
        icon = 'lightbulb',
        iconColor = '#FF1493',
        onSelect = function()
            openNeonLightsMenu()
        end
    })
    
    -- Wheels option (new categorized menu)
    table.insert(options, {
        title = 'Wheels',
        description = 'Browse wheels by category',
        icon = 'circle',
        iconColor = '#FFD700',
        onSelect = function()
            openWheelsMenu()
        end
    })
    
    -- Visual mods
    for _, mod in ipairs(visualMods) do
        local maxMod = GetNumVehicleMods(vehicle, mod.modType)
        if maxMod > 0 then
            table.insert(options, {
                title = mod.name,
                description = 'Configure ' .. mod.name:lower(),
                icon = mod.icon,
                iconColor = '#9370DB',
                onSelect = function()
                    openSpecificModMenu(mod.modType, mod.name, 'visual_mods_menu')
                end
            })
        end
    end
    
    lib.registerContext({
        id = 'visual_mods_menu',
        title = 'Visual Modifications',
        menu = 'vehicle_customization_menu',
        options = options
    })
    lib.showContext('visual_mods_menu')
end

local function openWindowTintMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local tints = {
        {name = 'None', id = 0},
        {name = 'Pure Black', id = 1},
        {name = 'Dark Smoke', id = 2},
        {name = 'Light Smoke', id = 3},
        {name = 'Stock', id = 4},
        {name = 'Limo', id = 5},
        {name = 'Green', id = 6}
    }
    
    local options = {}
    local currentTint = GetVehicleWindowTint(vehicle)
    
    for _, tint in ipairs(tints) do
        local isActive = currentTint == tint.id
        table.insert(options, {
            title = tint.name,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'window-maximize',
            iconColor = isActive and '#00ff00' or '#696969',
            onSelect = function()
                SetVehicleWindowTint(vehicle, tint.id)
                lib.notify({title = 'Window Tint Changed', description = tint.name, type = 'success'})
                openWindowTintMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'window_tint_menu',
        title = 'Window Tint',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('window_tint_menu')
end

local function openNeonLightsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local neonPositions = {
        {id = 0, name = 'Left'},
        {id = 1, name = 'Right'},
        {id = 2, name = 'Front'},
        {id = 3, name = 'Back'}
    }
    
    local options = {}
    
    -- Toggle all neons
    local allEnabled = true
    for _, pos in ipairs(neonPositions) do
        if not IsVehicleNeonLightEnabled(vehicle, pos.id) then
            allEnabled = false
            break
        end
    end
    
    table.insert(options, {
        title = allEnabled and 'Disable All Neons' or 'Enable All Neons',
        icon = 'lightbulb',
        iconColor = allEnabled and '#ff0000' or '#00ff00',
        onSelect = function()
            for _, pos in ipairs(neonPositions) do
                SetVehicleNeonLightEnabled(vehicle, pos.id, not allEnabled)
            end
            lib.notify({title = 'Neon Lights', description = allEnabled and 'All Disabled' or 'All Enabled', type = 'success'})
            openNeonLightsMenu()
        end
    })
    
    -- Individual neon positions
    for _, pos in ipairs(neonPositions) do
        local isEnabled = IsVehicleNeonLightEnabled(vehicle, pos.id)
        table.insert(options, {
            title = pos.name .. ' Neon',
            description = isEnabled and 'Currently ON' or 'Currently OFF',
            icon = 'lightbulb',
            iconColor = isEnabled and '#00ff00' or '#ff0000',
            onSelect = function()
                SetVehicleNeonLightEnabled(vehicle, pos.id, not isEnabled)
                lib.notify({title = pos.name .. ' Neon', description = isEnabled and 'Disabled' or 'Enabled', type = 'success'})
                openNeonLightsMenu()
            end
        })
    end
    
    -- Neon color option
    table.insert(options, {
        title = 'Change Neon Color',
        description = 'Set custom RGB color',
        icon = 'palette',
        iconColor = '#FF1493',
        onSelect = function()
            local r, g, b = GetVehicleNeonLightsColour(vehicle)
            local input = lib.inputDialog('Neon Color (RGB)', {
                {type = 'number', label = 'Red (0-255)', default = r, min = 0, max = 255, required = true},
                {type = 'number', label = 'Green (0-255)', default = g, min = 0, max = 255, required = true},
                {type = 'number', label = 'Blue (0-255)', default = b, min = 0, max = 255, required = true}
            })
            
            if input then
                SetVehicleNeonLightsColour(vehicle, input[1], input[2], input[3])
                lib.notify({title = 'Neon Color Changed', type = 'success'})
            end
            openNeonLightsMenu()
        end
    })
    
    lib.registerContext({
        id = 'neon_lights_menu',
        title = 'Neon Lights',
        menu = 'visual_mods_menu',
        options = options
    })
    lib.showContext('neon_lights_menu')
end

local function openSpecificModMenu(modType, modName, parentMenu)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    local maxMod = GetNumVehicleMods(vehicle, modType)
    local currentMod = GetVehicleMod(vehicle, modType)
    
    local options = {}
    
    -- Stock/Remove option
    table.insert(options, {
        title = 'Stock / Remove',
        description = currentMod == -1 and 'Currently Active' or 'Click to apply',
        icon = 'xmark',
        iconColor = currentMod == -1 and '#00ff00' or '#ff0000',
        onSelect = function()
            RemoveVehicleMod(vehicle, modType)
            lib.notify({title = modName, description = 'Removed', type = 'success'})
            openSpecificModMenu(modType, modName, parentMenu)
        end
    })
    
    -- Mod options
    for i = 0, maxMod - 1 do
        local modLabel = GetModTextLabel(vehicle, modType, i)
        local modDisplayName = modLabel ~= 'NULL' and GetLabelText(modLabel) or ('Upgrade ' .. (i + 1))
        local isActive = currentMod == i
        
        table.insert(options, {
            title = modDisplayName,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'check',
            iconColor = isActive and '#00ff00' or '#1E90FF',
            onSelect = function()
                SetVehicleMod(vehicle, modType, i, false)
                lib.notify({title = modName, description = modDisplayName, type = 'success'})
                openSpecificModMenu(modType, modName, parentMenu)
            end
        })
    end
    
    lib.registerContext({
        id = 'specific_mod_menu',
        title = modName,
        menu = parentMenu,
        options = options
    })
    lib.showContext('specific_mod_menu')
end


local function openHornMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    SetVehicleModKit(vehicle, 0)
    local currentHorn = GetVehicleMod(vehicle, 14) -- 14 is horn mod type
    
    local horns = {
        {name = 'Stock Horn', id = -1},
        {name = 'Truck Horn', id = 0},
        {name = 'Police Horn', id = 1},
        {name = 'Clown Horn', id = 2},
        {name = 'Musical Horn 1', id = 3},
        {name = 'Musical Horn 2', id = 4},
        {name = 'Musical Horn 3', id = 5},
        {name = 'Musical Horn 4', id = 6},
        {name = 'Musical Horn 5', id = 7},
        {name = 'Sad Trombone', id = 8},
        {name = 'Classical Horn 1', id = 9},
        {name = 'Classical Horn 2', id = 10},
        {name = 'Classical Horn 3', id = 11},
        {name = 'Classical Horn 4', id = 12},
        {name = 'Classical Horn 5', id = 13},
        {name = 'Classical Horn 6', id = 14},
        {name = 'Classical Horn 7', id = 15},
        {name = 'Scale - Do', id = 16},
        {name = 'Scale - Re', id = 17},
        {name = 'Scale - Mi', id = 18},
        {name = 'Scale - Fa', id = 19},
        {name = 'Scale - Sol', id = 20},
        {name = 'Scale - La', id = 21},
        {name = 'Scale - Ti', id = 22},
        {name = 'Scale - Do (High)', id = 23},
        {name = 'Jazz Horn 1', id = 24},
        {name = 'Jazz Horn 2', id = 25},
        {name = 'Jazz Horn 3', id = 26},
        {name = 'Jazz Horn Loop', id = 27},
        {name = 'Star Spangled Banner 1', id = 28},
        {name = 'Star Spangled Banner 2', id = 29},
        {name = 'Star Spangled Banner 3', id = 30},
        {name = 'Star Spangled Banner 4', id = 31},
        {name = 'Classical Horn 8 (Loop)', id = 32},
        {name = 'Classical Horn 9 (Loop)', id = 33},
        {name = 'Classical Horn 10 (Loop)', id = 34},
        {name = 'Funeral March (Loop)', id = 35},
        {name = 'Epiphany (Loop)', id = 36},
        {name = 'Chinatown (Loop)', id = 37},
        {name = 'San Andreas (Loop)', id = 38},
        {name = 'Liberty City (Loop)', id = 39},
        {name = 'Festive 1 (Loop)', id = 40},
        {name = 'Festive 2 (Loop)', id = 41},
        {name = 'Festive 3 (Loop)', id = 42}
    }
    
    local options = {}
    
    for _, horn in ipairs(horns) do
        local isActive = currentHorn == horn.id
        table.insert(options, {
            title = horn.name,
            description = isActive and 'Currently Active' or 'Click to apply',
            icon = 'bullhorn',
            iconColor = isActive and '#00ff00' or '#FFA500',
            onSelect = function()
                if horn.id == -1 then
                    RemoveVehicleMod(vehicle, 14)
                    lib.notify({title = 'Horn Changed', description = horn.name, type = 'success'})
                else
                    SetVehicleMod(vehicle, 14, horn.id, false)
                    lib.notify({title = 'Horn Changed', description = horn.name, type = 'success'})
                end
                openHornMenu()
            end
        })
    end
    
    lib.registerContext({
        id = 'horn_menu',
        title = 'Vehicle Horn',
        menu = 'vehicle_customization_menu',
        options = options
    })
    lib.showContext('horn_menu')
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
            title = 'Performance Mods',
            description = 'Engine, transmission, turbo, etc.',
            icon = 'gauge-high',
            iconColor = '#FF4500',
            onSelect = function()
                openPerformanceModsMenu()
            end
        },
        {
            title = 'Visual Mods',
            description = 'Spoilers, bumpers, wheels, etc.',
            icon = 'car',
            iconColor = '#9370DB',
            onSelect = function()
                openVisualModsMenu()
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
        },
        {
            title = 'Vehicle Horn',
            description = 'Change horn sound',
            icon = 'bullhorn',
            iconColor = '#FFA500',
            onSelect = function()
                openHornMenu()
            end
        },
        {
            title = noHelmet and 'No Helmet: ON' or 'No Helmet: OFF',
            description = 'Toggle automatic helmet removal',
            icon = noHelmet and 'toggle-on' or 'toggle-off',
            iconColor = noHelmet and '#00ff00' or '#ff0000',
            onSelect = function()
                noHelmet = not noHelmet
                lib.notify({title = 'No Helmet', description = noHelmet and 'Enabled' or 'Disabled', type = 'info'})
                openVehicleCustomizationMenu()
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



local function openDoorsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local doors = {
        {id = 0, name = 'Front Left Door'},
        {id = 1, name = 'Front Right Door'},
        {id = 2, name = 'Rear Left Door'},
        {id = 3, name = 'Rear Right Door'},
        {id = 4, name = 'Hood'},
        {id = 5, name = 'Trunk'}
    }
    
    local options = {}
    
    -- Door controls
    for _, door in ipairs(doors) do
        local isOpen = GetVehicleDoorAngleRatio(vehicle, door.id) > 0
        table.insert(options, {
            title = door.name,
            description = isOpen and 'Currently OPEN' or 'Currently CLOSED',
            icon = 'door-open',
            iconColor = isOpen and '#00ff00' or '#ff0000',
            onSelect = function()
                local currentVeh = GetVehiclePedIsIn(PlayerPedId(), false)
                local currentState = GetVehicleDoorAngleRatio(currentVeh, door.id) > 0
                
                if currentState then
                    SetVehicleDoorShut(currentVeh, door.id, false)
                    lib.notify({title = door.name, description = 'Closed', type = 'success'})
                else
                    SetVehicleDoorOpen(currentVeh, door.id, false, false)
                    lib.notify({title = door.name, description = 'Opened', type = 'success'})
                end
                
                -- Small delay to let door position update
                Wait(100)
                openDoorsMenu()
            end
        })
    end
    
    -- Close all doors option
    table.insert(options, {
        title = 'Close All Doors',
        icon = 'door-closed',
        iconColor = '#FFA500',
        onSelect = function()
            for i = 0, 5 do
                SetVehicleDoorShut(vehicle, i, false)
            end
            lib.notify({title = 'Corey Vehicle Actions', description = 'All doors closed', type = 'success'})
            openDoorsMenu()
        end
    })
    
    lib.registerContext({
        id = 'doors_menu',
        title = 'Vehicle Doors',
        menu = 'vehicle_main_menu',
        options = options
    })
    lib.showContext('doors_menu')
end

local function openWindowsMenu()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    
    if vehicle == 0 then
        lib.notify({title = 'Error', description = 'You must be in a vehicle', type = 'error'})
        return
    end
    
    local windows = {
        {id = 0, name = 'Front Left Window'},
        {id = 1, name = 'Front Right Window'},
        {id = 2, name = 'Rear Left Window'},
        {id = 3, name = 'Rear Right Window'}
    }
    
    local options = {}
    
    -- Window controls
    for _, window in ipairs(windows) do
        table.insert(options, {
            title = window.name,
            description = 'Control window',
            icon = 'window-maximize',
            iconColor = '#4169E1',
            onSelect = function()
                if IsVehicleWindowIntact(vehicle, window.id) then
                    RollDownWindow(vehicle, window.id)
                    lib.notify({title = window.name, description = 'Rolled down', type = 'success'})
                else
                    RollUpWindow(vehicle, window.id)
                    lib.notify({title = window.name, description = 'Rolled up', type = 'success'})
                end
                openWindowsMenu()
            end
        })
    end
    
    -- Roll down all windows
    table.insert(options, {
        title = 'Roll Down All Windows',
        icon = 'arrows-down-to-line',
        iconColor = '#00BFFF',
        onSelect = function()
            RollDownWindows(vehicle)
            lib.notify({title = 'Corey Vehicle Actions', description = 'All windows rolled down', type = 'success'})
            openWindowsMenu()
        end
    })
    
    lib.registerContext({
        id = 'windows_menu',
        title = 'Vehicle Windows',
        menu = 'vehicle_main_menu',
        options = options
    })
    lib.showContext('windows_menu')
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
        },
        {
            title = 'Vehicle Doors',
            description = 'Control vehicle doors',
            icon = 'door-open',
            iconColor = '#9370DB',
            onSelect = function()
                openDoorsMenu()
            end
        },
        {
            title = 'Vehicle Windows',
            description = 'Control vehicle windows',
            icon = 'window-maximize',
            iconColor = '#4169E1',
            onSelect = function()
                openWindowsMenu()
            end
        }
    }

    lib.registerContext({id = 'vehicle_main_menu', title = 'Vehicle Menu', options = options})
    lib.showContext('vehicle_main_menu')
end
RegisterCommand('veh', function() openVehicleMenu() end, false)