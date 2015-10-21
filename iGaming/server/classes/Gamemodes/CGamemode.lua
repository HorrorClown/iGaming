--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 02.05.2015 - Time: 00:39
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
Gamemodes = {}
CGamemode = {}

function CGamemode:constructor(sName)
    self.players = {}
    self.Name = sName
    Gamemodes[self.Name] = self
end

function CGamemode:destructor()
    self.Name = nil
end

function CGamemode:isPlayerInLobby(ePlayer)
    for index, player in ipairs(self.players) do
        if player == ePlayer then return index end
    end
end

function CGamemode:addPlayer(ePlayer)
    if self:isPlayerInLobby(ePlayer) then return false end
    table.insert(self.players, ePlayer)
    triggerClientEvent(ePlayer, "server:onJoinGamemode", ePlayer, self.Name)    --Todo: Use RPC
    outputChatBox("You joined Gamemode: " .. self.Name) --Todo: Just a dev output
end

function CGamemode:removePlayer(ePlayer)
    local index = self:isPlayerInLobby(ePlayer)
    if index then table.remove(self.players, i) outputChatBox("Lobby " .. self.Name .. " left!") end
end

function CGamemode:getPlayers()
    return self.players
end

function CGamemode:getName()
    return self.Name
end