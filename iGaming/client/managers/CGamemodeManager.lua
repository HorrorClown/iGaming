--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 02.05.2015 - Time: 00:19
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CGamemodeManager = {}

function CGamemodeManager:constructor()
    self.Gamemode = false

    addEvent("server:onJoinGamemode", true)
    addEventHandler("server:onJoinGamemode", me, bind(CGamemodeManager.joinGamemode, self))
end

function CGamemodeManager:destructor()

end

function CGamemodeManager:joinGamemode(sGamemode)
    self:clearGamemode()
    if sGamemode == "Lobby" then
        return self:setGamemode(new(CLobby))
    end

    if sGamemode == "OpenWorld" then
        return self:setGamemode(new(COpenWorld))
    end

    if sGamemode == "DD" then
        return self:setGamemode(new(CRaceDD))
    end
end

function CGamemodeManager:setGamemode(gmInstance)
    self.Gamemode = gmInstance
end

function CGamemodeManager:clearGamemode()
   if self.Gamemode then
        delete(self.Gamemode)
        self.Gamemode = false
    end
end