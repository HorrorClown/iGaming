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
    self.playerName = self:getName()
    self.clearName = utils.clearText(self:getName()) --Todo: Utils Without colorcodes
    self.CurrentGamemode = false
    bindKey(self, "F1", "down", bind(CPlayer.returnToLobby, self))
    outputChatBox("Welcome " .. self.clearName)
end

function CPlayer:destructor()

end

--isRegistered: To check, if the userID from board in main database available!
function CPlayer:isRegistered()
   return DB:get("player_accounts", "userID", "userID", self.userID) == self.userID
end

--register: To add a registered board player to main database!
function CPlayer:register()
    return DB:insert("player_accounts", "userID, accountname, username, email, serial", "?, ?, ?, ?, ?", self.userID, self.accountName, self.clearName, self.email, self.serial)
end

function CPlayer:onLogin()
    triggerClientEvent(self, "server:onLogin", self, true)
    self:joinGamemode(Gamemodes["Lobby"])
    --Core:getManager("CGamemodeManager"):getGamemode("CLobby"):addPlayer(self)
end

function CPlayer:joinGamemode(sGamemode)
    if self.CurrentGamemode then self.CurrentGamemode:playerLeave(self) end
    self.CurrentGamemode = sGamemode
    sGamemode:playerJoin(self)
end

function CPlayer:returnToLobby()
    if self.CurrentGamemode and self.CurrentGamemode ~= Gamemodes["Lobby"] then
        if self.CurrentGamemode then self.CurrentGamemode:playerLeave(self) end
        self.CurrentGamemode = Gamemodes["Lobby"]
        Gamemodes["Lobby"]:playerJoin(self)
    end
end

function CPlayer:message(sText)
    self:outputChat(sText, 255, 255, 255, true)
end
--[[addCommandHandler("load",
    function(_, _, moduleString)
        Core:loadModule(moduleString)
    end
)

addCommandHandler("unload",
    function(_, _, moduleString)
        Core:unloadModule(moduleString)
    end
)]]