--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 10.01.2015 - Time: 15:59
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CDXImage = inherit(CDXManager)

function CDXImage:constructor(sPath, nDiffX, nDiffY, nWidth, nHeight, color, parent)
    self.path = sPath
    self.diffX = nDiffX
    self.diffY = nDiffY
    self.w = nWidth
    self.h = nHeight
    self.color = color
    self.parent = parent or false
    self.rot = 0
    self.alpha = 255
    self.clickExecute = {}

    self.onRenderFunc = bind(self.render, self)

    if self.parent then
        local pX, pY = self.parent:getPosition()
        self.x = pX + self.diffX
        self.y = pY + self.diffY
        table.insert(self.parent.subElements, self)
    else
        self.x = self.diffX
        self.y = self.diffY
    end
end

function CDXImage:destructor()

end

function CDXImage:render()
    if self.parent and self.parent.moving then
        local pX, pY = self.parent:getPosition()
        self.x = pX + self.diffX
        self.y = pY + self.diffY
    end

    --Todo: Add hover effekt if functions to click available
    --if utils.isHover(self.x, self.y, self.w, self.h) then self.drawColor = tocolor(220, 50, 0, 220) else self.drawColor = self.color end
    dxDrawImage(self.x, self.y, self.w, self.h, self.path, self.rot, 0, 0, tocolor(255, 255, 255, self.alpha))
end
