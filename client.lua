local locations = {}
local cam

for i = 1, #Config.Locations do
    locations[#locations + 1] =
    {
        title = Config.Locations[i].title,
        onSelect = function()
            SetEntityCoords(cache.ped, Config.Locations[i].coords.x, Config.Locations[i].coords.y, Config.Locations[i].coords.z, true, false, false, false)
            SetEntityHeading(cache.ped, Config.Locations[i].coords.w)
            RenderScriptCams(false, true, 1000, true, true)
            SetCamActive(cam, false)
            DestroyCam(cam, true)
        end
    }
end

local function createCamera()
    local camCoords = GetOffsetFromEntityInWorldCoords(cache.ped, 0.0, 0.0, 500.0)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", camCoords.x, camCoords.y, camCoords.z, 300.00, 0.00, 0.00, 110.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
end

local function regsiterSpawnMenu()
    lib.registerContext({
        id = 'spawn_menu',
        title = 'Spawn Select',
        options = locations
    })
end


local function openSpawnMenu()
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()
    createCamera()
    regsiterSpawnMenu()
    lib.showContext('spawn_menu')
end

exports('openSpawnMenu', openSpawnMenu)