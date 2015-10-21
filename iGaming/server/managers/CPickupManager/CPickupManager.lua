--
-- PewX (HorrorClown)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 17.10.2015 - Time: 20:45
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CPickupManager = {}

function CPickupManager:constructor()
    self.Pickups = {}
end

function CPickupManager:destructor()

end

function CPickupManager:loadPickups(Gamemode, Pickups)
    if self.Pickups[Gamemode] then self:unloadPickups() end
    self.Pickups[Gamemode] = {}

    for _, v in ipairs(Pickups) do
       table.insert(self.Pickups[Gamemode], new(CRacePickup, v[1], v[2], v[3], v[4], v[5]))
    end
end

function CPickupManager:unloadPickups(Gamemode)
    for _, v in ipairs(self.Pickups[Gamemode]) do
        delete(v)
    end
end