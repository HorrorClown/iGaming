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
                    table.insert(self.Maps[mapType], {["Name"] = mapName, ["Resource"] = mapInstance})
                   self.MapCount = self.MapCount + 1
               end
           end
       end
    end
end

function CMapManager:printLoadedMaps()
    for mapType in pairs(self.Maps) do
        debugOutput(("[MapManager] %s: %s"):format(mapType, #self.Maps[mapType]))
    end
end

function CMapManager:getRandomMap(sType)
    return self.Maps[sType][math.random(1, #self.Maps[sType])]["Resource"]
end

function CMapManager:getMapsByType(sType)
    return self.Maps[sType]
end
