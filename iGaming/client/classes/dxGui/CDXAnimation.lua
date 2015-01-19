--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 18.01.2015 - Time: 12:59
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CDXAnimation = {}

function CDXAnimation:constructor()

end

function CDXAnimation:destructor()

end

function CDXAnimation:addAnimation(sAnim, ) end

function CDXAnimation:addAnimation(sAnim, nDuration)
    self.startTick = getTickCount()
    self.animType = sAnim
    self.animDuration = nDuration
    self.animRenderFunc = bind(self.renderAnimation, self)
end

function CDXAnimation:starAnimation()
    addEventHandler("onClientRender", root, self.animRenderFunc)
end

function CDXAnimation:stopAnimation()

end

function CDXAnimation:renderAnimation()
    if self.animType == "rotate" then
        local rot = math.fmod((getTickCount()-self.startTick)*360/2000, 360)
        self.rot = rot
    end
end