--
-- PewX
-- Using: IntelliJ IDEA 13 Ultimate
-- Date: 24.12.2014 - Time: 04:27
-- iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CCore = {}

function Core:constructor()

end

function Core:destructor()

end

function CCore:initScript()
    --DB = new() --Add DB Class
    --WBB = new(Cwbbc, "localhost", "iGaming", "dbPass", "iGamingBoard", 3306)
    self.file = fileOpen("server/system/files.xml")
    if not self.file then debugOutput("Starting gamemode scripts failed!") return end
    
    self.files = {server = {}, client = {}}
    for _, v in ipairs(xmlNodeGetChildren(self.file)) do
        if xmlNodeGetAttribute(v, "enabled") == 1 then
            table.insert(self.files[xmlNodeGetAttribute(v, "type")], xmlNodeGetAttribute(v, "src"))
        end
    end
    fileClose(self.file)
end

function CCore:startScripts()
    if self.files and #self.files.server > 0 then
        for _, file in ipairs(self.files.server) do
            local f = fileOpen(file)
            local sf = loadstring(fileRead(f, fileGetSize(f)))
            local b, e = pcall(sf)
            debugOutput(b .. "| " .. e)
            fileClose(f)
        end
    end
end

addEventHandler("onReosurceStart", resourceRoot,
    function()
        local sT = getTickCount()
        debugOutput("Starting iGaming")
        Core = new(CCore)
        Core:initScript()
        Core:startScripts()
        --Core:initDefaultSettings()
        debugOutput(("Starting finished in %s"):format(math.floor(getTickCount()-sT)))
    end
)
