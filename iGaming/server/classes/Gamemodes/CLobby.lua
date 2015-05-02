--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 28.12.2014 - Time: 06:54
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CLobby = inherit(CGamemode)

function CLobby:constructor()
    CGamemode.constructor(self, "Lobby")

    addEvent("client:joinGamemode", true)
    addEventHandler("client:joinGamemode", resourceRoot, bind(self.joinGamemode, self))
end

function CLobby:destructor()

end

function CLobby:playerJoin(ePlayer)
    self:addPlayer(ePlayer)
end

function CLobby:playerLeave(ePlayer)
    self:removePlayer(ePlayer)
end

function CLobby:joinGamemode(sGamemode)
    client:joinGamemode(Gamemodes[sGamemode])
end