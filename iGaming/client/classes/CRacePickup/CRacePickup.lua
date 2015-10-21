--
-- PewX (HorrorClown)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 13.10.2015 - Time: 22:16
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
local PickupModels = {
    ["nitro"] = 2221,
    ["repair"] = 2222,
    ["vehiclechange"] = 2223
}

CRacePickup = {}

function CRacePickup:constructor(str_Type, vehicleID, posX, posY, posZ, rotX, rotY, rotZ)
    self.Type = str_Type
    self.VehicleID = vehicleID
    self.ColShape = ColShape.Sphere(posX, posY, posZ, 3.5)

    self.Model = PickupModels[str_Type]
    self.Pickup = createPickup(posX, posY, posZ, 3, self.Model)
    self.Pickup:setDimension(localPlayer.dimension)

    Event:add(self, "onClientColShapeHit", self.ColShape, true)
end

function CRacePickup:destructor()
    --Event:remove(self, "onClientColShapeHit", self.ColShape)
    removeEventHandler("onClientColShapeHit", self.ColShape, self._onClientColShapeHit)

    self.ColShape:destroy()
    self.Pickup:destroy()

    for _, v in pairs(self) do
        v = nil
    end

    collectgarbage()
end

function CRacePickup:onClientColShapeHit(eHit, bMatchDimension)
    if bMatchDimension or eHit.type ~= "vehicle" then return false end
    playSoundFrontEnd(46)

    if self.Type == "nitro" then
        eHit:addUpgrade(1010)
        return
    end

    if self.Type == "repair" then
        eHit:fix()
        return
    end

    if self.Type == "vehiclechange" then
        local oldDis = eHit.distanceFromCentreOfMassToBaseOfModel
        eHit:setModel(self.VehicleID)
        local newDis =  eHit.distanceFromCentreOfMassToBaseOfModel

        if oldDis and oldDis < newDis then
            local posVector = eHit:getPosition()
            local z = posVector.z - oldDis + newDis
            eHit:setPosition(posVector.x, posVector.y, z + 1)
        end
        return
    end

    playSoundFrontEnd(46)
end