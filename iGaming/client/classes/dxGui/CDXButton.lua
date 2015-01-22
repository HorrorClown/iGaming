--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 19.12.2014 - Time: 22:57
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CDXButton = inherit(CDXManager)

--Todo: Parameter >color< zum table machen mit dem Aufbau {["normal"] = {r,g,b,a}, ["hover"] = {r,g,b,a}, ["disabled"] = {r,g,b,a}}
function CDXButton:constructor(sTitle, nDiffX, nDiffY, nWidth, nHeight, color, parent)
    self.title = sTitle
    self.diffX = nDiffX
    self.diffY = nDiffY
    self.w = nWidth
    self.h = nHeight
    self.color = color
    self.alpha = 255
    self.parent = parent
    self.clickExecute = {}

    if self.parent then
        local pX, pY = self.parent:getPosition()
        self.x = pX + self.diffX
        self.y = pY + self.diffY
        table.insert(self.parent.subElements, self)
    end
end

function CDXButton:destructor()

end

function CDXButton:render()
    if self.parent.moving then
        local pX, pY = self.parent:getPosition()
        self.x = pX + self.diffX
        self.y = pY + self.diffY
    end

    if utils.isHover(self.x, self.y, self.w, self.h) then self.drawColor = tocolor(220, 50, 0, 220) else self.drawColor = self.color end
    dxDrawRectangle(self.x, self.y, self.w, self.h, self.drawColor)
    dxDrawText(self.title, self.x, self.y, self.x + self.w, self.y + self.h, tocolor(255, 255, 255), 1, "arial", "center", "center")
end
