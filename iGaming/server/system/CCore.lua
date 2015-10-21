--
-- PewX
-- Using: IntelliJ IDEA 13 Ultimate
-- Date: 24.12.2014 - Time: 04:27
-- iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CCore = inherit(CSingleton)         --Server Core

function CCore:constructor()
    self.managers = {}

    --Manager Table: {"ManagerName", {arguments}}
    table.insert(self.managers, {"CPlayerManager", {}})
    table.insert(self.managers, {"CDownloadManager", {}})
    table.insert(self.managers, {"CLoginManager", {}})
    table.insert(self.managers, {"CMapManager", {}})
    table.insert(self.managers, {"CGamemodeManager", {}})
    table.insert(self.managers, {"CPickupManager", {}})
end

function CCore:destructor()

end

function CCore:initGamemode()
    DB = new(CDatabase, "localhost", "igaming", "f3CMBGVPnuUP4EjN", "igaming_main", 3306)
    WBB = new(Cwbbc, "localhost", "igaming", "f3CMBGVPnuUP4EjN", "igaming_board", 3306)

    --DB = new(CDatabase, "pewx.de", "igaming", "f3CMBGVPnuUP4EjN", "igaming_main", 3306)
    --WBB = new(Cwbbc, "pewx.de", "igaming", "f3CMBGVPnuUP4EjN", "igaming_board", 3306)
end

function CCore:loadManagers()
    for _, v in ipairs(self.managers) do
        if (type(_G[v[1]]) == "table") then
            debugOutput(("[CCore] Loading manager '%s'"):format(tostring(v[1])))
            self[tostring(v[1])] = new(_G[v[1]], unpack(v[2]))
        else
            debugOutput(("[CCore] Couldn't find manager '%s'"):format(tostring(v[1])))
        end
    end
end

function CCore:getManager(sName)
    return self[sName]
end

addEventHandler("onResourceStart", resourceRoot,
    function()
        local sT = getTickCount()
        debugOutput("[CCore] Starting iGaming")
        RPC = new(CRPC)
        Event = new(CEvent)
        Core = new(CCore)
        Core:initGamemode()
        Core:loadManagers()
        --Core:initDefaultSettings()
        debugOutput(("[CCore] Starting finished (%sms)"):format(math.floor(getTickCount()-sT)))
    end
)
