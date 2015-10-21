--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 02.05.2015 - Time: 23:44
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CRaceDD = inherit(CGamemode)

function CRaceDD:constructor()
    CGamemode.constructor(self, "RaceDD")
    --self.PlayerVehicles = {}
    self.state = "none"
    self.dimension = 500

    --Player states
    self.players_ready = {}
    self.players_alive = {}
    self.players_dead = {}
    self.players_spec = {}

    self.Maps = Core:getManager("CMapManager"):getMapsByType("DD")
    self.CurrentMap = false
    self.MapQuery = {}

    Event:addRemote(self, "RaceDD:onPlayerIsReady", "onPlayerIsReady")
end

function CRaceDD:destructor()

end

function CRaceDD:playerJoin(ePlayer)
    self:addPlayer(ePlayer)                 --AddPlayer to Gamemode
    ePlayer:setDimension(self.dimension)    --Set Player to Gamemode dimension

    --If not map is loaded
    if #self.players == 1 and self.state == "none" then
        self:setState("LoadingMap")
        --self.CurrentMap = Core:getManager("CMapManager"):getRandomMap("DD")
        --Core:getManager("CMapManager"):loadMapForGamemode(self, self.CurrentMap)
    end
end

function CRaceDD:playerLeave(ePlayer)
    self:removePlayer(ePlayer)
    ePlayer:setCameraTarget()

    --If no player in gamemode, unload the map and reset state
    if #self.players == 0 then
        --self.CurrentMap:unloadMap()
        --self:setState("none")
    end
end

function CRaceDD:onPlayerIsReady(client)
    table.insert(self.players_ready, client)

    if #self.players == #self.players_ready then
        --Todo: DEV! (Set state to PrepareCountdown
       outputChatBox("All players ready.. starting map in 5 seconds")
       setTimer(function()
            self:setState("Running") --PrepareCountdown
       end, 5000, 1)
    end
end

function CRaceDD:loadMap()
    if not self.MapQuery[1] then
        table.insert(self.MapQuery, Core:getManager("CMapManager"):getRandomMap("DD"))
    end

    self.CurrentMap = table.remove(self.MapQuery, 1)
    Core:getManager("CMapManager"):serverLoadMap(self, self.CurrentMap)     --Extract map / Load serversided map scripts
    Core:getManager("CMapManager"):transferMapToPlayers(self.players, self.CurrentMap)

    --table.insert(self.MapQuery, Core:getManager("CMapManager"):getRandomMap("DD"))

    --If the serversided Map- and Scriptmanager called, that the map is loaded serverside, set the gamemode state to
    --WaitingForPlayers
    --This will starts a timer, wich is checking every X (1-5?) seconds if the players are ready
    --There is a timout at 20 seconds.. After 20 seconds the map will force started (at least 1/3 - 2/3 - 1/2 players are ready)
end

function CRaceDD:setState(str_State)
    if self.state == str_State then
        return false
    end

    debugOutput(("[CRaceDD] Set state from '%s' to '%s'"):format(self.state, str_State))
    self.state = str_State

    if self.state == "LoadingMap" then
        self:loadMap()
    end

    if self.state == "Running" then
        --Dev.. Use SpawnManager or eq
       for _, ePlayer in ipairs(self.players) do
          local veh = ePlayer:getOccupiedVehicle()
           veh:setFrozen(false)
       end
    end
end