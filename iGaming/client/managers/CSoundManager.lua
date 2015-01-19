--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 15.01.2015 - Time: 14:44
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CSoundManager = {}

function CSoundManager:constructor()
    addEvent("onCreateClientSound", true)
    addEventHandler("onCreateClientSound", root,
        function()

        end
    )
end

function CSoundManager:destructor()

end