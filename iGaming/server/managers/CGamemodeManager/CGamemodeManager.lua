--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 01.05.2015 - Time: 12:23
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CGamemodeManager = {}

function CGamemodeManager:constructor()
    self.gamemodes = {}

    table.insert(self.gamemodes, {"CLobby", {}})
    table.insert(self.gamemodes, {"COpenWorld", {name = "Open World", desc = "LoremIpsum", maxPlayers = 100}})
    --table.insert(self.gamemodes, {"CRaceDM", {name = "DM", desc = "LoremIpsum", maxPlayers = 50}})
    --table.insert(self.gamemodes, {"CRaceDD", {name = "DD", desc = "LoremIpsum", maxPlayers = 100}})
    --table.insert(self.gamemodes, {"CiSurvival", {name = "iSurvival", desc = "LoremIpsum", maxPlayers = 100}})
    self:createGamemodes()
end

function CGamemodeManager:destructor()

end

function CGamemodeManager:createGamemodes()
    for _, v in ipairs(self.gamemodes) do
        if (type(_G[v[1]]) == "table") then
            self[tostring(v[1])] = new(_G[v[1]], unpack(v[2]))
            debugOutput(("[GamemodeManager] Loading gamemode '%s'"):format(tostring(v[1])))
        else
            debugOutput(("[GamemodeManager] Couldn't find gamemode '%s'"):format(tostring(v[1])))
        end
    end
end

function CGamemodeManager:getGamemode(sName)
    return self[sName]
end