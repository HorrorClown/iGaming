--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 17.01.2015 - Time: 19:09
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CLobby = {}

function CLobby:constructor()
    debugOutput("[CLobby] Creating Lobby")
    addCommandHandler("gm", bind(CLobby.joinGamemode, self))

    self.cams = {
        {2054.9406738281, 1298.5733642578, 95.947769165039, 2120.7822265625, 1230.1296386719, 64.637092590332},
        {1814.2286376953, -1888.7556152344, 53.846141815186, 1734.5378417969, -1832.7844238281, 31.117233276367},
        {1578.1954345703, -1610.4873046875, 78.673355102539, 1501.4410400391, -1658.9365234375, 36.703880310059}
    }

    setTime(12, 0)
    setMinuteDuration(600000)
    setPlayerHudComponentVisible("all", false)
    fadeCamera(true)
    setCloudsEnabled(false)

    setCameraMatrix(unpack(self.cams[math.random(1, #self.cams)]))
end

function CLobby:destructor()
    removeCommandHandler("gm")
end

function CLobby:joinGamemode(_, sGamemode)
    outputChatBox("Player wants to join gamemode: " .. sGamemode)
    triggerServerEvent("client:joinGamemode", resourceRoot, sGamemode)
end