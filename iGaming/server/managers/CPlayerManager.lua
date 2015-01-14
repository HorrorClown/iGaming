--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 10.01.2015 - Time: 17:12
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CPlayerManager = {}

function CPlayerManager:constructor()
    addEvent("onClientResourceStarted", true)
    addEventHandler("onClientResourceStarted", resourceRoot,
        function()
            enew(client, CPlayer)
        end
    )
end

function CPlayerManager:destructor()

end
