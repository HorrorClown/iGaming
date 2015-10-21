--
-- PewX (HorrorClown)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 13.10.2015 - Time: 22:16
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CRacePickup = {}

function CRacePickup:constructor(str_Type, vehicleID, posX, posY, posZ)
    self.Type = str_Type
    self.VehicleID = vehicleID
    self.ColShape = ColShape.Sphere(posX, posY, posZ, 3.5)

    Event:add(self, "onColShapeHit", self.ColShape, true)
end

function CRacePickup:destructor()
    removeEventHandler("onColShapeHit", self.ColShape, self._onClientColShapeHit)

    self.ColShape:destroy()

    for _, v in pairs(self) do
        v = nil
    end

    collectgarbage()
end

function CRacePickup:onColShapeHit(eHit, bMatchDimension)
    if bMatchDimension or eHit.type ~= "vehicle" then return false end

    if self.Type == "nitro" then
        eHit:addUpgrade(1010)
        return
    end

    if self.Type == "repair" then
        eHit:fix()
        return
    end

    if self.Type == "vehiclechange" then
        eHit:setModel(self.VehicleID)
        return
    end
end