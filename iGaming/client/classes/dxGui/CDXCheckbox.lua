--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 26.12.2014 - Time: 18:27
-- iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CDXCheckbox = inherit(CDXManager)

function CDXCheckbox:constructor(sText, nDiffX, nDiffY, nWidth, nHeight, bChecked, parent)
    self.title = sText
    self.diffX = nDiffX
    self.diffY = nDiffY
    self.w = nWidth
    self.h = nHeight
    self.checked = bChecked or false
    self.parent = parent or false
    self.alpha = 255

    local pX, pY = self.parent:getPosition()
    self.x = pX + self.diffX
    self.y = pY + self.diffY

    self.clickExecute = {}
    self:addClickFunction(function(self) self.checked = not self.checked end)
    table.insert(self.parent.subElements, self)
end

function CDXCheckbox:destructor()

end

function CDXCheckbox:render()
    if self.parent.moving then
        local pX, pY = self.parent:getPosition()
        self.x = pX + self.diffX
        self.y = pY + self.diffY
    end

    dxDrawRectangle(self.x, self.y, self.h, self.h, tocolor(255, 255, 255, self.alpha))
    if self.checked then
        dxDrawRectangle(self.x + 2, self.y + 2, self.h - 4, self.h - 4, tocolor(85, 85, 85, self.alpha))
    end
    dxDrawText(self.title, self.x + self.h + 2, self.y, self.x + self.w, self.y + self.h, tocolor(255, 255, 255, self.alpha), 1, "arial", "left", "center")
end