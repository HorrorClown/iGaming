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

--[[addCommandHandler("horror",
    function()
        fadeCamera(true)
        local winsound = new(CSound, "http://pewx.de/res/sounds/irace_background/Desmeon - On That Day (feat. ElDiablo Flint & Zadik).mp3", false, 0)
        winsound:play()
        winsound:fadeIn(8000, "InQuad")
    end
)]]