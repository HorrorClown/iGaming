--
-- PewX (HorrorClown)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 18.10.2015 - Time: 06:16
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CModManager = {}

function CModManager:constructor()
    Core:getManager("CDownloadManager"):requireFiles(
        {
            "res/mods/nitro.dff",
            "res/mods/nitro.txd",

            "res/mods/repair.dff",
            "res/mods/repair.txd",

            "res/mods/vehiclechange.dff",
            "res/mods/vehiclechange.txd"
        }
    )

    self.NosDFF = engineLoadDFF("res/mods/nitro.dff", 0)
    self.NosTXD = engineLoadTXD("res/mods/nitro.txd")

    self.RepairDFF = engineLoadDFF("res/mods/repair.dff", 0)
    self.RepairTXD = engineLoadTXD("res/mods/repair.txd")

    self.VehiclechangeDFF = engineLoadDFF("res/mods/vehiclechange.dff", 0)
    self.VehiclechangeTXD = engineLoadTXD("res/mods/vehiclechange.txd")

    engineImportTXD(self.NosTXD, 2221)
    engineReplaceModel(self.NosDFF, 2221)

    engineImportTXD(self.RepairTXD, 2222)
    engineReplaceModel(self.RepairDFF, 2222)

    engineImportTXD(self.VehiclechangeTXD, 2223)
    engineReplaceModel(self.VehiclechangeDFF, 2223)
end

function CModManager:destructor()

end