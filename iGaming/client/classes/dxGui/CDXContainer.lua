--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 27.12.2014 - Time: 06:04
-- iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CDXContainer = {}

function CDXContainer:constructor(nDiffX, nDiffY, nWidth, nHeight, parent)
    self.diffX = nDiffX
    self.diffY = nDiffY
    self.w = nWidth
    self.h = nHeight
    self.parent = parent or false
    self.subElements = {}

    local pX, pY = self.parent:getPosition()
    self.x = pX + self.diffX
    self.y = pY + self.diffY

    table.insert(self.parent.subElements, self)
end

function CDXContainer:destructor()
    for _, subElement in pairs(self.subElements) do
        delete(subElement)
    end
end

function CDXContainer:getPosition()
    return self.x, self.y
end

function CDXContainer:render()
    for _, subElement in ipairs(self.subElements) do
        subElement:render()
    end
end