--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 13 Ultimate
-- Date: 24.12.2014 - Time: 04:34
-- iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
SERVER = triggerServerEvent == nil
CLIENT = not SERVER
DEBUG = DEBUG or false

function debugOutput(sText)
    if DEBUG then
        outputDebugString(("[%s] %s"):format(SERVER and "Server" or "Client", sText), 0, 0, 255, 0)
    end
end