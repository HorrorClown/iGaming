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
    self.disabledFunctions = {"showCursor", "guiCreateWindow", "guiCreateLabel", "guiCreateTab", "guiCreateStaticImage", "guiCreateScrollPane", "guiCreateScrollBar", "guiCreateRadioButton", "guiCreateProgressBar", "guiCreateMemo", "guiCreateGridList", "guiCreateEdit", "guiCreateComboBox", "guiCreateButton", "outputChatBox", "outputConsole", "outputDebugString", "showChat", "fileOpen"}
    self:resetScriptEnvironment()
end

function CScriptManager:destructor()
  
end

function CScriptManager:resetScriptEnvironment()
    if self.scriptLoaded then self:unloadScript() end
    self.scriptEnv = {}

    for k, v in pairs(_G) do
        if (type(v) == "function") then
            self.scriptEnv[k] = v
        end
    end

    self.scriptEnv.math = math
    self.scriptEnv.string = string
    self.scriptEnv.table = table

    self.scriptEnv.Functions = {}
    self.scriptEnv.Sounds = {}
    self.scriptEnv.Commands = {}

    --Sounds
    --self.scriptEnv._playSound = playSound
    self.scriptEnv.playSound =
    function(sound,loop)
        local sound = playSound(sound,loop)
        if sound then
            debugOutput"Insert"
            table.insert(self.scriptEnv.Sounds, sound)
        end
        return sound
    end

    --Command Handlers
    --self.scriptEnv._addCommandHandler = addCommandHandler
    self.scriptEnv.addCommandHandler =
    function (cmd, theFunc)
        if addCommandHandler(cmd, theFunc) then
            table.insert(self.scriptEnv.Commands, {cmd, theFunc})
            if not self.scriptEnv.Functions[theFunc] then
                self.scriptEnv.Functions[theFunc] = true
            end
        end
    end

    self.scriptEnv.unloadScript = function()
        for _, v in ipairs(self.scriptEnv.Commands) do
           removeCommandHandler(v[1], v[2])
        end


        for _, v in ipairs(self.scriptEnv.Sounds) do
            stopSound(v)
        end

        for func in pairs(self.scriptEnv.Functions) do
            func = nil
        end

        self.scriptEnv.Functions = {}
        self.scriptEnv.Sounds = {}
        self.scriptEnv.Commands = {}

    end
    --[[
    self.scriptEnv._G = {}
    self.scriptEnv.root = root
    self.scriptEnv.resourceRoot = resourceRoot
    self.scriptEnv.localPlayer = localPlayer
    self.scriptEnv.source = source
    self.scriptEnv.this = this

    self.scriptEnv.math = math
    self.scriptEnv.string = string
    self.scriptEnv.table = table

    --Disable Functions
    for _, sFunction in ipairs(self.disabledFunctions) do
        self.scriptEnv[sFunction] =
            function()
                debugOutput(("[ScriptManager] Warning: Disabled function '%s' called"):format(sFunction))
                return false
            end
    end
    
    --MTA Handles
    self.scriptEnv.Functions = {}
    self.scriptEnv.Elements = {}
    self.scriptEnv.Models = {}
    self.scriptEnv.Textures = {}
    self.scriptEnv.XMLFiles = {}
    self.scriptEnv.ElementDatas = {}
    self.scriptEnv.Sounds = {}
    self.scriptEnv.EventHandler = {}
    self.scriptEnv.Commands = {}
    self.scriptEnv.Timers = {}
    self.scriptEnv.Keybinds = {}

    --Override functions

    --Mods/Engine
    self.scriptEnv._engineSetModelLODDistance = engineSetModelLODDistance
    self.scriptEnv.engineSetModelLODDistance = function(model,dis)
        if _engineSetModelLODDistance(model,dis) then
            Models[model] = true
        end
        return true
    end

    self.scriptEnv._engineReplaceCOL = engineReplaceCOL
    self.scriptEnv.engineReplaceCOL = function(dff,model)
        if _engineReplaceCOL(dff,model) then
            Models[model] = true
        end
        return true
    end

    self.scriptEnv._engineLoadCOL = engineLoadCOL
    self.scriptEnv.engineLoadCOL = function(dff)
        local dff = _engineLoadCOL(dff)
        if dff then
            table.insert(Textures, dff)
        end
        return dff
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
    end

    --XMLFiles
    self.scriptEnv._xmlLoadFile = xmlLoadFile
    self.scriptEnv.xmlLoadFile =
        function(sPath)
            local xmlFile = _xmlLoadFile(sPath)
            if xmlFile then table.insert(XMLFiles, xmlFile) end
            return xmlFile
        end

    --Sounds
    self.scriptEnv._playSound = playSound
    self.scriptEnv.playSound =
        function(sound,loop)
            local sound = _playSound(sound,loop)
            if sound then
                debugOutput"Insert"
                table.insert(Sounds, sound)
            end
            return sound
        end

    --Timers
    self.scriptEnv._setTimer = setTimer
    self.scriptEnv.setTimer =
        function (theFunc, ...)
            local timer = _setTimer(theFunc, ...)
            if timer then
                table.insert(Timers, timer)
                if not Functions[theFunc] then
                    Functions[theFunc] = true
                end
                return timer
            end
        end

    --Command Handlers
    self.scriptEnv._addCommandHandler = addCommandHandler
    self.scriptEnv.addCommandHandler =
        function (cmd, theFunc)
            if _addCommandHandler(cmd, theFunc) then
                table.insert(Commands, {cmd, theFunc})
                if not Functions[theFunc] then
                    Functions[theFunc] = true
                end
            end
        end

    --Keybinds
    self.scriptEnv._bindKey = bindKey
    self.scriptEnv.bindKey =
        function (key,state,theFunc)
            if not Functions[theFunc] then
                Functions[theFunc] = true
            end

            if (key == "m") then
                return
            end

            if _bindKey(key,state,theFunc) then
                table.insert(Keybinds, {key,state,func})
            end
        end

    --ELEMETS

    --Markers
    self.scriptEnv._createMarker = createMarker
    self.scriptEnv.createMarker =
        function (x, y, z, type, size, r, g, b ,a)
            local marker = _createMarker(x or 0, y or 0, z or 0, type or "corona", size or 4, r or 255, g or 255, b or 255 ,a or 255)
            table.insert(Elements, marker)
            setElementDimension(marker, localPlayer.dimension)
            return marker
        end

    --Objects
    self.scriptEnv._createObject = createObject
    self.scriptEnv.createObject =
        function (model, x, y, z, rx,ry,rz)
            local object = _createObject(model, x, y, z, rx or 0,ry or 0,rz or 0)
            if object then
                table.insert(Elements, object)
                setElementDimension(object ,localPlayer.dimension)
                return object
            end
        end

    --Peds
    self.scriptEnv._createPed = createPed
    self.scriptEnv.createPed =
        function (skin, x, y, z, rot)
            local ped = _createPed(skin,x,y,z,rot or 0)
            table.insert(Elements, ped)
            setElementDimension(ped, localPlayer.dimension)
            return ped
        end

    --Vehicles
    self.scriptEnv._createVehicle = createVehicle
    self.scriptEnv.createVehicle =
    function (model, x, y, z, rx, ry, rz)
        local veh = _createVehicle(model,x,y,z,rx or 0, ry or 0, rz or 0)
        table.insert(Elements, veh)
        setElementDimension(veh, localPlayer.dimension)
        return veh
    end

    for k, v in pairs(self.scriptEnv) do
        if (type(v) == "function") and not(string.find(k,"_",1,true)) then
            setfenv(v, self.scriptEnv)
        end
    end

    --Fill normal functions
    for k, v in pairs(_G) do
        if (type(v) == "function") then
            if (not self.scriptEnv[k]) then
                self.scriptEnv[k] = v
            end
        end
    end

    ]]
end

function CScriptManager:loadScript(str_Script)
    outputConsole("Script: " .. tostring(str_Script))

    local exec = loadstring(str_Script)
    setfenv(exec, self.scriptEnv)
    local bool, error = pcall(exec)

    outputChatBox(("Client: Load map script '%s' | Error: '%s'"):format(tostring(bool), tostring(error)))
end