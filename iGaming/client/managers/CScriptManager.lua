-- 
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 09.01.2014 - Time: 11:11
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CScriptManager = {}

function CScriptManager:constructor()
    self.scriptEnv = {}
    self.scriptLoaded = false
    self.disabledFunctions = {"showCursor", "guiCreateWindow", "guiCreateLabel", "guiCreateTab", "guiCreateStaticImage", "guiCreateScrollPane", "guiCreateScrollBar", "guiCreateRadioButton", "guiCreateProgressBar", "guiCreateMemo", "guiCreateGridList", "guiCreateEdit", "guiCreateComboBox", "guiCreateButton", "outputChatBox", "outputConsole", "outputDebugString", "showChat"}
    self:resetScriptEnvironment()
end

function CScriptManager:destructor()
  
end

function CScriptManager:resetScriptEnvironment()
    if self.scriptLoaded then self:unloadScript() end
    self.scriptEnv = {}
    
    self.scriptEnv._G = _G
    self.scriptEnv.root = root
    self.scriptEnv.resourceRoot = resourceRoot
    self.scriptEnv.localPlayer = localPlayer
    self.scriptEnv.source = source
    
    self.scriptEnv.math = math
    self.scriptEnv.string = string
    self.scriptEnv.table = table
    
    --Disable Functions
    for _, sFunction in ipairs(self.disabledFunctions) do
        self.scriptEnv[sFunction] = function() return false end
    end
    
    --MTA Handles
    self.scriptEnv.models = {}
    self.scriptEnv.sounds = {}
    self.scriptEnv.timers = {}
    self.scriptEnv.XMLFiles = {}
    
    
    --Override functions
    --Mods/Engine
    
    --Kompakte Lösung finden, um problemlos die veränderten Objekte wieder zurück zu bekommen.
    --[[self.scriptEnv._engineSetModelLODDistance = engineSetModelLODDistance
    self.scriptEnv.engineSetModelLODDistance = 
        function(nObject, nDis)
            if _engineSetModelLODDistance(nObject, nDis) then
                table.insert(models, nObject)
            end
            return true
        end
        
    self.scriptEnv._engineLoadCOL = engineLoadCOL
    self.scriptEnv.engineLoadCOL = 
        function(dff)
            local dff = _engineLoadCOL(dff)
            if dff then
                table.insert(Textures, dff)
            end
            return dff
        end

    self.scriptEnv._engineReplaceCOL = engineReplaceCOL
    self.scriptEnv.engineReplaceCOL = 
        function(dff, model)
if _engineReplaceCOL(dff,model) then
Models[model] = true
end
return true
end



self.scriptEnv._engineReplaceModel = engineReplaceModel
self.scriptEnv.engineReplaceModel = function(dff,model)
if _engineReplaceModel(dff,model) then
Models[model] = true
end
return true
end
self.scriptEnv._engineLoadDFF = engineLoadDFF
self.scriptEnv.engineLoadDFF = function(dff,model)
local dff = _engineLoadDFF(dff,model)
if dff then
table.insert(Textures, dff)
end
return dff
end
self.scriptEnv._engineImportTXD = engineImportTXD
self.scriptEnv.engineImportTXD = function(txd,model)
if _engineImportTXD(txd,model) then
Models[model] = true
end
return true
end
self.scriptEnv._engineLoadTXD = engineLoadTXD
self.scriptEnv.engineLoadTXD = function(txd)
local txd = _engineLoadTXD(txd)
if txd then
table.insert(Textures, txd)
end
return txd or false
end]]
    
    --XMLFiles
    self.scriptEnv._xmlLoadFile = xmlLoadFile
    self.scriptEnv.xmlLoadFile =
        function(sPath)
            local xmlFile = _xmlLoadFile(sPath)
            if xmlFile then table.insert(XMLFiles, xmlFile) end
            return xmlFile
        end
        
        
end
