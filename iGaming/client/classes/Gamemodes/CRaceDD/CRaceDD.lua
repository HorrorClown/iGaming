--
-- PewX (HorrorClown)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 15.10.2015 - Time: 22:43
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CRaceDD = {}

function CRaceDD:constructor()
    debugOutput("[CRaceDD] Constructor")
end


function CRaceDD:destructor()

end

function CRaceDD:ready()
    RPC:call("RaceDD:onPlayerIsReady")
end