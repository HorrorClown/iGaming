--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 10.01.2015 - Time: 17:14
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CPlayer = {}

function CPlayer:constructor()
    self.loggedIn = false
    self.userID = nil
    self.playerName = self:getName(self)
    self.clearName = getPlayerName(self) --Todo: Without colorcodes
end

function CPlayer:destructor()

end

function CPlayer:isRegistered()

end

function CPlayer:onLogin()

end