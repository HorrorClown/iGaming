--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 03.05.2015 - Time: 04:46
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CMapManager = {}

function CMapManager:constructor()
    self:refreshMaps()
    self:printLoadedMaps()
end

function CMapManager:destructor()

end

function CMapManager:resetMaps()
    self.MapCount = 0
    self.Maps = {}
    self.Maps["DD"] = {}
    self.Maps["DM"] = {}
    --self.Maps["Shooter"] = {}
    --self.Maps["Hunter"] = {}
end

function CMapManager:refreshMaps()
    refreshResources(false)
    self:resetMaps()

    for k, v in ipairs(getResources()) do
       --if getResourceInfo(v, "type") == "map" and getResourceInfo(v, "gamemodes") == "race" then
       if v:getInfo("type") == "map" and v:getInfo("gamemodes") == "race" then
           for mapType in pairs(self.Maps) do
               local mapName = v:getInfo("name")
               if mapName and mapName:find(("\[%s\]"):format(mapType), 1, true) then
                    local mapInstance = new(CMap, v, mapType)           --ToDo: If map has errors like no name or other, don't create a instance!
                    table.insert(self.Maps[mapType], {["Name"] = mapName, ["Instance"] = mapInstance})
                   self.MapCount = self.MapCount + 1
               end
           end
       end
    end
end

--[[function CMapManager:refreshMapsForType(str_MapType)
    if not self:isMapTypeAvailable(str_MapType) then return false end

    self.MapCount = self.MapCount - #self.Maps[str_MapType]
    self.Maps[str_MapType] = {}

    for k, v in ipairs(getResources()) do
        --if getResourceInfo(v, "type") == "map" and getResourceInfo(v, "gamemodes") == "race" then
        if v:getInfo("type") == "map" and v:getInfo("gamemodes") == "race" then
            local mapName = v:getInfo("name")
            if mapName and mapName:find(("\[%s\]"):format(str_MapType), 1, true) then
                local mapInstance = new(CMap, v, str_MapType)           --ToDo: If map has errors like no name or other, don't create a instance!
                table.insert(self.Maps[str_MapType], {["Name"] = mapName, ["Instance"] = mapInstance})
                self.MapCount = self.MapCount + 1
            end
        end
    end

    debugOutput(("[MapManager] %s: %s"):format(str_MapType, #self.Maps[str_MapType]))
end]]

function CMapManager:printLoadedMaps()
    for mapType in pairs(self.Maps) do
        debugOutput(("[MapManager] %s: %s"):format(mapType, #self.Maps[mapType]))
    end
end

function CMapManager:getRandomMap(sType)
    return self.Maps[sType][math.random(1, #self.Maps[sType])]["Instance"]
end

function CMapManager:getMapsByType(sType)
    return self.Maps[sType]
end

function CMapManager:isMapTypeAvailable(str_MapType)
    for mapType in pairs(self.Maps) do
       if mapType == str_MapType then
            return true
       end
    end
    return false
end

function CMapManager:serverLoadMap(Gamemode, Map)
    Map:extractMapData()
    Map:prepareClientDatas()

    --Load Map Pickups

    Core:getManager("CPickupManager"):loadPickups(Gamemode, Map.ContentTable["Racepickup"])
    --Core:getManager("CScriptManager"):loadScript(Gamemode, Map.ContentTable["ServerScript"])
end

function CMapManager:transferMapToPlayers(tbl_Players, Map)
    for _, ePlayer in ipairs(tbl_Players) do
        for _, latentEvent in pairs(getLatentEventHandles(ePlayer)) do
            cancelLatentEvent(ePlayer, latentEvent)
        end

        RPC:latentCall(ePlayer, "MapManager:sendMap", Map.clientDatas)

        --todo Spawnpoints : DEV
        local spawnpoints = Map:getSpawnpoints()
        local s = spawnpoints[1]
        local veh = Vehicle(s[1], s[2], s[3], s[4], s[5], s[6], s[7])
        veh:setDimension(500)
        veh:setFrozen(true)
        warpPedIntoVehicle(ePlayer, veh)
        setCameraTarget(ePlayer, ePlayer)
    end
end

function CMapManager:playerRequestMap(ePlayer, Map, int_Dimension)--Todo: THIs is shit
    Map:extractMapData()
    Map:loadMap(int_Dimension)

    --todo Spawnpoints : DEV
    local spawnpoints = Map:getSpawnpoints()
    local s = spawnpoints[1]
    local veh = Vehicle(s[1], s[2], s[3], s[4], s[5], s[6], s[7])
    veh:setDimension(int_Dimension)
    ePlayer:setDimension(int_Dimension)
    warpPedIntoVehicle(ePlayer, veh)
    setCameraTarget(ePlayer, ePlayer)
end