--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 18.01.2015 - Time: 12:59
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CDXAnimation = {}

function CDXAnimation:constructor(element, sAnim, nDuration, sEasingType, arg1, arg2)
    self.element = element
    self.animType = sAnim
    self.duration = nDuration
    self.easing = sEasingType
    self.arg1 = arg1
    self.arg2 = arg2
    self.animRenderFunc = bind(self[sAnim], self)
end

function CDXAnimation:destructor()

end

function CDXAnimation:startAnimation()
    self.startTick = getTickCount()
    self.endTick = self.startTick + self.duration
    self.startRot = self.element.rot
    self.startX = self.element.x
    self.startY = self.element.y
    self.startW = self.element.w
    self.startH = self.element.h
    self.startA = self.element.alpha
    addEventHandler("onClientRender", root, self.animRenderFunc)
end

function CDXAnimation:stopAnimation()
    removeEventHandler("onClientRender", root, self.animRenderFunc)
end

function CDXAnimation:rotate()
    local rot = math.fmod((getTickCount()-self.startTick)*360/self.duration, 360)
    if rot then self.element.rot = rot end
end

function CDXAnimation:wipe()
    local p = (getTickCount()-self.startTick)/(self.endTick-self.startTick)
    local rot = interpolateBetween(self.startRot, 0, 0, self.arg1, 0, 0, p, self.easing)
    if rot then self.element.rot = rot end
    if p >= 1 then
        self.startRot = self.arg1 
        self.arg1 = self.arg1*-1
        self.startTick = getTickCount()
        self.endTick = self.startTick + self.duration
    end
end

function CDXAnimation:changePos()
    local p = (getTickCount()-self.startTick)/(self.endTick-self.startTick)
    local nx, ny = interpolateBetween(self.startX, self.startY, 0, self.arg1, self.arg2, 0, p, self.easing)
    self.element.x = nx
    self.element.y = ny
    if p >= 1 then
        removeEventHandler("onClientRender", root, self.animRenderFunc)
    end
end

function CDXAnimation:changeSize()
    local p = (getTickCount()-self.startTick)/(self.endTick-self.startTick)
    local nw, nh = interpolateBetween(self.startW, self.startH, 0, self.arg1, self.arg2, 0, p, self.easing)
    self.element.w = nw
    self.element.h = nh
    if p >= 1 then
        removeEventHandler("onClientRender", root, self.animRenderFunc)
    end
end

function CDXAnimation:changeAlpha()
    local p = (getTickCount()-self.startTick)/(self.endTick-self.startTick)
    local na = interpolateBetween(self.startA, 0, 0, self.arg1, 0, 0, p, self.easing)
    self.element.alpha = na
    if p >= 1 then
        removeEventHandler("onClientRender", root, self.animRenderFunc)
    end
end
