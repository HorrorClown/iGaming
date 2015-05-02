--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 23.01.2015 - Time: 23:42
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CDXList = inherit(CDXManager)

function CDXList:constructor(nDiffX, nDiffY, nWidth, nHeight, parent)
    self.diffX = nDiffX
    self.diffY = nDiffY
    self.w = nWidth
    self.h = nHeight
    self.parent = parent or false

    self.columns = {}
    self.rows = {}
    self.selectedRow = {}
    self.scrollDiff = {}

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

function CDXList:addColumn(sColumn)
    table.insert(self.columns, sColumn)
    local ci = #self.columns
    self.rows[ci] = {}
    return ci
end

function CDXList:addRow(nColumn, sData)
    table.insert(s)
end
