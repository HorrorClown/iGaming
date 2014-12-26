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

function CCore:startScript()
    --DB = new() --Add DB Class
    --WBB = new(Cwbbc, "localhost", "iGaming", "dbPass", "iGamingBoard", 3306)
end

addEventHandler("onReosurceStart", resourceRoot,
    function()
        local sT = getTickCount()
        debugOutput("Starting iGaming")
        Core = new(CCore)
        Core:startScript()
        --Core:initDefaultSettings()
        debugOutput(("Starting finished in %s"):format(math.floor(getTickCount()-sT)))
    end
)