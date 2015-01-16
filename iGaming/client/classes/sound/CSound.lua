--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 15.01.2015 - Time: 14:32
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CSound = {}

function CSound:constructor(sPath, bRepeat, nVolume, nX, nY, nZ)
    self.path = sPath
    self.bRepeat = bRepeat or false
    self.volume = nVolume
    self.x = nX or false
    self.y = nY or false
    self.z = nZ or false
end

function CSound:destructor()
    self.sound:destroy()
end

function CSound:play()
    self.sound = Sound.create(self.path, self.bRepeat)
    self.sound:setVolume(self.volume)
end

function CSound:play3D()
    self.sound = Sound3D.create(self.path, self.x, self.y, self.z, self.bRepeat)
    self.sound:setVolume(self.volume)
end

function CSound:stop()
    self.sound:stop()
end

function CSound:setPaused()
    self.sound:setPaused()
end

function CSound:fadeIn(nLength, sEasing)
    self.easingFunction = sEasing
    self.sT = getTickCount()
    self.eT = self.sT + nLength
    self.sV = 0
    self.eV = 1
    self.doFadingFunc = bind(self.doFading, self)
    addEventHandler("onClientRender", root, self.doFadingFunc)
end

function CSound:fadeOut()
    self.easingFunction = sEasing
    self.sT = getTickCount()
    self.eT = self.sT + nLength
    self.sV = 1
    self.eV = 0
    self.doFadingFunc = bind(self.doFading, self)
    addEventHandler("onClientRender", root, self.doFadingFunc)
end

function CSound:doFading()
    self.p = (getTickCount()-self.sT)/(self.eT-self.sT)
    self.volume = interpolateBetween(self.sV, 0, 0, self.eV, 0, 0, self.p, self.easingFunction)
    self.sound:setVolume(self.volume)
    if self.p >= 1 then removeEventHandler("onClientRender", root, self.doFadingFunc) end
end