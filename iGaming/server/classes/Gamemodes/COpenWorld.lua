--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 01.05.2015 - Time: 23:27
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
COpenWorld = inherit(CGamemode)

function COpenWorld:constructor()
    CGamemode.constructor(self, "OpenWorld")
    self.PlayerTable = {}
    self.spawns = {{0, 0, 5, 90}}
    self.dimension = 100
end

function COpenWorld:destructor()

end

function COpenWorld:playerJoin(ePlayer)
    self:addPlayer(ePlayer)

    local x, y, z, r = unpack(self.spawns[math.random(1, #self.spawns)])
    ePlayer:spawn(x, y, z, r, 90, 0, self.dimension)
    local vehicle = createVehicle(411, x + 2, y + 2, z + 5)
    setElementDimension(vehicle, self.dimension)
    ePlayer:setCameraTarget()
end

function COpenWorld:playerLeave(ePlayer)
    self:removePlayer(ePlayer)
    ePlayer:setCameraTarget()
end