--
-- PewX
-- Using: IntelliJ IDEA 13 Ultimate
-- Date: 24.12.2014 - Time: 04:27
-- iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CCore = {}

function CCore:constructor()
    self.managers = {}
    --Manager Table: {"ManagerName", {arguments}}
    table.insert(self.managers, {"CPlayerManager", {}})
end

function CCore:destructor()

end

function CCore:initScript()
    --DB = new() --Add DB Class
    --WBB = new(Cwbbc, "localhost", "iGaming", "dbPass", "iGamingBoard", 3306)
    self.file = xmlLoadFile("server/system/files.xml")
    if not self.file then debugOutput("Starting gamemode scripts failed!") return end

    self.files = {server = {}, client = {}}
    for _, v in ipairs(xmlNodeGetChildren(self.file)) do
        if xmlNodeGetAttribute(v, "enabled") == "1" then
            if fileExists(xmlNodeGetAttribute(v, "src")) then
                table.insert(self.files[xmlNodeGetAttribute(v, "type")], xmlNodeGetAttribute(v, "src"))
            else
                debugOutput("Can't find file '" .. xmlNodeGetAttribute(v, "src") .. "'", 1)
            end
        end
    end
    xmlUnloadFile(self.file)
end

function CCore:startScripts()
    if self.files and #self.files.server > 0 then
        for _, file in ipairs(self.files.server) do
            local f = fileOpen(file)
            local sf = loadstring(fileRead(f, fileGetSize(f)))
            local b, e = pcall(sf)
            fileClose(f)
        end
    end
end

function CCore:loadManagers()
    for _, v in ipairs(self.managers) do
        if (type(_G[v[1]]) == "table") then
            self[tostring(v[1])] = new(_G[v[1]], unpack(v[2]))
            debugOutput(("[CCore] Loading manager '%s'"):format(tostring(v[1])))
        else
            debugOutput(("[CCore] Couldn't find manager '%s'"):format(tostring(v[1])))
        end
    end
end

addEventHandler("onResourceStart", resourceRoot,
    function()
        local sT = getTickCount()
        debugOutput("[CCore] Starting iGaming")
        Core = new(CCore)
        Core:initScript()
        Core:startScripts()
        Core:loadManagers()
        --Core:initDefaultSettings()
        debugOutput(("[CCore] Starting finished in %s"):format(math.floor(getTickCount()-sT)))
    end
)
