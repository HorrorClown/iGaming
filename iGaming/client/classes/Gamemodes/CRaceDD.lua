--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 02.05.2015 - Time: 23:44
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CRaceDD = {}

function CRaceDD:constructor()
    CGamemode.constructor(self, "RaceDD")
    self.PlayerVehicles = {}
    self.state = "none"


    --Player states
    self.alivePlayers = {}
    self.failedPlayers = {}
    self.spectatingPlayers = {}

    self.Maps = {}
    self.CurrentMap = false
    self:reloadMaps()
    self:loadNextMap()
end

function CRaceDD:destructor()

end

function CRaceDD:reloadMaps()

end

function CRaceDD:loadNextMap()

end