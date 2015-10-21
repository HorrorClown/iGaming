--
-- PewX (HorrorClown)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 15.10.2015 - Time: 15:56
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CMapManager = {}

function CMapManager:constructor()
    self.Objects = {}
    self.Markers = {}
    self.Vehicles = {}
    self.RacePickups = {}
    self.Peds = {}

    Event:addRemote(self, "MapManager:sendMap", "receiveMap")
end

function CMapManager:destructor()

end

function CMapManager:receiveMap(Map)
    self:unloadMap()
    debugOutput("[MapManager] Receive Map")

    if not Map then
        debugOutput("[MapManager] Can't load next map (Map = nil/false)")
    end

    self.MapScript = Map.script
    self:loadMap(Map.map)
    self:validateClientFiles(Map.fileHashes)

    --Todo: Load script if clients files are valid
    Core:getManager("CScriptManager"):loadScript(Map.script)

    --Todo: DEV! This have to be triggered, if all files downloaded and scripts started
    Core:getManager("CGamemodeManager").Gamemode:ready()
end

function CMapManager:loadMap(Map)
    debugOutput("[MapManager] Load next map")
    self.MapLoaded = true

    --Create Objects
    for _, v in ipairs(Map["Object"]) do
        local Object = Object(v[1], v[2], v[3], v[4], v[5], v[6], v[7])
        if v[8] then Object:setInterior(v[8]) end
        --if v[9] then Object:setCollisionsEnabled(v[9]) end        --Todo: String to bool
        if v[10] then Object:setAlpha(v[10]) end
        if v[11] then Object:setScale(v[11]) end
        Object:setDimension(localPlayer.dimension)
        table.insert(self.Objects, Object)
    end

    --Create Markers
    for _, v in ipairs(Map["Marker"]) do
        local r, g, b, a = getColorFromString(v[7])
        local Marker = Marker(v[1], v[2], v[3], v[4], v[5], v[6], r, g, b, a or 255)
        if v[8] then Marker:setInterior(v[8]) end
        if v[9] then Marker:setID(v[9]) end
        Marker:setDimension(localPlayer.dimension)
        table.insert(self.Markers, Marker)
    end

    --Create vehicles
    for _, v in ipairs(Map["Vehicle"]) do
        local Vehicle = Vehicle(v[1], v[2], v[3], v[4], v[5], v[6], v[7])
        if Vehicle and isElement(Vehicle) then
            Vehicle:setFrozen(true)
            Vehicle:setDimension(localPlayer.dimension)
            table.insert(self.Vehicles, Vehicle)
        end
    end

    --Create Peds
    for _, v in ipairs(Map["Ped"]) do
        local Ped = createPed(v[1], v[2], v[3], v[4], v[5])
        Ped:setDimension(localPlayer.dimension)
        table.insert(self.Peds, Ped)
    end

    --Handle Race pickups
    for _, v in ipairs(Map["Racepickup"]) do
        table.insert(self.RacePickups, new(CRacePickup, v[1], v[2], v[3], v[4], v[5], v[6], v[7], v[8]))
    end

    local h, m = gettok(Map["Settings"].Time, 1, ":"), gettok(Map["Settings"].Time, 2, ":")

    setTime(h, m)
    setWeather(Map["Settings"].Weather)
    setGravity(Map["Settings"].Gravity)
    setWaveHeight(Map["Settings"].Waveheight)
end

function CMapManager:unloadMap()
    if not self.MapLoaded then return end
    debugOutput("[MapManager] Unload map")

    --Destroy Objects
    for _, v in ipairs(self.Objects) do
        v:destroy()
    end

    --Destroy Markers
    for _, v in ipairs(self.Markers) do
        v:destroy()
    end

    --Destroy Vehicles
    for _, v in ipairs(self.Vehicles) do
        v:destroy()
    end

    --Destroy Peds
    for _, v in ipairs(self.Peds) do
        v:destroy()
    end

    --Destroy Racepickup
    for _, v in ipairs(self.RacePickups) do
        v:delete()
    end

    self.Objects = {}
    self.Markers = {}
    self.Vehicles = {}
    self.RacePickups = {}
    self.Peds = {}

    self.MapLoaded = false
end

function CMapManager:validateClientFiles()
    --Todo
    --Todo: After validating and receiving unvalidated files.. load the script.. !! :)
    --Like:
    --Core:getManager("CScriptManager"):loadMapScript(self.MapScript)
end