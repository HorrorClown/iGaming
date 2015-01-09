--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 13 Ultimate
-- Date: 27.12.2014 - Time: 06:37
-- iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CDXProgressbar = {}

function CDXProgressbar:constructor(nDiffX, nDiffY, nWidth, nHeight, nProgress, parent)
    self.diffX = nDiffX
    self.diffY = nDiffY
    self.w = nWidth
    self.h = nHeight
    self.parent = parent or false

    local pX, pY = self.parent:getPosition()
    self.x = pX + self.diffX
    self.y = pY + self.diffY
end

function CDXProgressbar:destructor()

end

function CDXProgressbar:setProgress(nProgress)
    self.progress = nProgress
end

function CDXProgressbar:render()
    --Todo: Render progressbar
end