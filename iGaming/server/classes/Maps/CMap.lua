--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 03.05.2015 - Time: 05:14
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
Maps = {}                                      --Alls Maps name to instance like Maps[mapName] = self
CMap = {}

function CMap:constructor(eResource, sType)
    self.Resource = eResource
    self.Type = sType
    self.Name = self.Resource:getInfo("name") or ("[%s] Undefined"):format(self.Type)
    self.Author = self.Resource:getInfo("author") or "undefined"
    self.ResourceName = self.Resource:getName()

    self.ContentTable = {
        ["Object"] = {},
        ["Ped"] = {},
        ["Vehicle"] = {},
        ["Racepickup"] = {},
        ["Spawnpoint"] = {},
        ["Marker"] = {},
        ["Settings"] = {},
        ["ServerScript"] = "",
        ["ClientScript"] = "",
        ["ClientFiles"] = {},
        ["ClientFileHashes"] = {},
        ["ResourceName"] = self.ResourceName
    }

    local mapData = DB:query("SELECT * FROM system_maps WHERE ResourceName = ?", self.ResourceName)
    if mapData then
        self.ID = mapData[1].ID
        self.CountStarted = mapData[1].CountStarted
        self.CountFinished = mapData[1].CountFinished
        self.TopTimes = fromJSON(mapData[1].TopTimes)
        self.Rating = fromJSON(mapData[1].Rating)
    else
        self.CountStarted = 0
        self.CountFinished = 0
        self.TopTimes = {}
        self.Rating = {}
        DB:insert("system_maps", "ID, ResourceName, TopTimes, Rating", "NULL, ?, ?, ?", self.ResourceName, toJSON(self.TopTimes), toJSON(self.Rating))
    end

    Maps[self.Name] = self
    self.Extracted = false
    self:extractMapData()
end

function CMap:destructor()

end

function CMap:extractMapData()
    if self.Extracted then return end
    self.Extracted = true

    local meta = XML.load((":%s/meta.xml"):format(self.ResourceName))
    if not meta then debugOutput(("[CMap] Error while loading %s/meta.xml"):format(self.ResourceName)) return end

    --//Get map datas
    local mapNode = meta:findChild("map", 0)
    local mapPath = mapNode:getAttributes()
    local mapFile = XML.load((":%s/%s"):format(self.ResourceName, mapPath.src))
    if not mapFile then debugOutput(("[CMap] Error while loading %s/%s.map"):format(self.ResourceName, mapPath.src)) return end
    
    local mapNodes = mapFile:getAttributes()
    for k, v in ipairs(mapNodes) do
        local type = v:getName()
        local attributes = v:getAttributes()
        if type == "object" then
            local col = attributes["collisions"] or true
            local a = attributes["alpha"] or 255
            local int = attributes["interior"] or 0
            local scale = attributes["scale"] or 1
            table.insert(self.ContentTable["Object"], {attributes["model"], attributes["posX"], attributes["posY"], attributes["posZ"], attributes["rotX"], attributes["rotY"], attributes["rotZ"], int, col, a, scale})
        elseif type == "marker" then
            table.insert(self.ContentTable["Marker"], {attributes["posX"], attributes["posY"], attributes["posZ"], attributes["type"], attributes["size"], attributes["color"], attributes["interior"]})
         elseif type == "vehicle" then
            table.insert(self.ContentTable["Vehicle"], {attributes["model"], attributes["posX"], attributes["posY"], attributes["posZ"], attributes["rotX"], attributes["rotY"], attributes["rotZ"]})
        elseif type == "racepickup" then
            table.insert(self.ContentTable["Racepickup"], {attributes["type"], attributes["vehicle"], attributes["posX"], attributes["posY"], attributes["posZ"], attributes["rotX"], attributes["rotY"], attributes["rotZ"]})
        elseif type == "spawnpoint" then
            table.insert(self.ContentTable["Spawnpoint"], {attributes["vehicle"], attributes["posX"], attributes["posY"], attributes["posZ"], attributes["rotX"], attributes["rotY"], attributes["rotZ"]}})
        elseif type == "ped" then
            table.insert(self.ContentTable["Ped"], {attributes["model"], attributes["posX"], attributes["posY"], attributes["posZ"], attributes["rotX"], attributes["rotY"], attributes["rotZ"]})
        else
            debugOutput("[CMap] Warning: Undefined type to extract in map " .. self.Name)
        end
    end
       
    --//Load awesome Map scripts
    local nodes = meta:getChildreen()
    for k, v in ipairs(nodes) do
        if v:getName() == "script" then
            local scriptInfo = v:getAttributes()
            if scriptInfo.type and scriptInfo.type == "client" then
                local scriptFile = File((":%s/%s"):format(self.ResourceName, scriptInfo.src), true)
                if scriptFile then
                    self.ContentTable["ClientScript"] = ("%s %s"):format(self.ContentTable["ClientScript"], scriptFile:read(scriptFile:getSize()))
                    scriptFile:close()
                end
            else
                local scriptFile = File((":%s/%s"):format(self.ResourceName, scriptInfo.src), true)
                if scriptFile then
                    self.ContentTable["ServerScript"] = ("%s %s"):format(self.ContentTable["ServerScript"], scriptFile:read(scriptFile:getSize()))
                    scriptFile:close()
                end
            end
        elseif v:getName() == "file" then
            local fileInfo = v:getAttributes()
            if fileInfo.src then
                local fileFile = File((":%s/%s"):format(self.ResourceName, fileInfo.src), true)
                if fileFile then
                    table.insert(ContentTable["ClientFiles"], {src = fileInfo.src, content = fileFile:read(fileFile:getSize())})
                    table.insert(ContentTable["ClientFileHashes"], {src = fileInfo.src, hash = fileFile:getSize()})
                    fileFile:close()
                end
            end
        end
    end
       
    --//Load Map settings
    self.ContentTable["Settings"].Weather = tonumber(get(("#%s.weather"):format(self.ResourceName))) or 0
    self.ContentTable["Settings"].Time = get(("#%s.time"):format(self.ResourceName)) or "12:00"
    self.ContentTable["Settings"].Gravity = tonumber(get(("#%s.gravity"):format(self.ResourceName))) or 0.008000
	self.ContentTable["Settings"].Waveheight = tonumber(get(("#%s.waveheight"):format(self.ResourceName)))

end
