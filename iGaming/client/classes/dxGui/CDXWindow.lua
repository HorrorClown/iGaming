--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 19.12.2014 - Time: 18:07
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CDXWindow = inherit(CDXManager)

function CDXWindow:constructor(sTitle, nPosX, nPosY, nWidth, nHeight, bClosable, bMovable)
    self.title = sTitle
    self.x = nPosX
    self.y = nPosY
    self.w = nWidth
    self.h = nHeight
    self.closable = bClosable
    self.movable = bMovable

    self.subElements = {}
    self.isVisible = false

    self.onRenderFunc = bind(self.onRender, self)
    self.onCloseButtonClickFunc = bind(self.onCloseButtonClick, self)
end

function CDXWindow:destructor()
    for _, subElement in pairs(self.subElements) do
        delete(subElement)
    end
end

function CDXWindow:onRender()
    if self.moving then
        local cX, cY = getCursorPosition()
        self.x, self.y = cX*x-self.diff[1], cY*y-self.diff[2]
    end

    --dxDrawRectangle(self.x, self.y, self.w, self.h, tocolor(150, 150, 150, 200))
    --dxDrawRectangle(self.x, self.y, self.w, 22, tocolor(255, 80, 0, 200))
    --dxDrawText(self.title, self.x, self.y, self.x + self.w, self.y + 22, tocolor(255, 255, 255), 1, "arial", "center", "center")

    dxDrawRectangle(self.x-10, self.y-10, self.w+20, self.h+20, tocolor(0, 0, 0, 150))
    dxDrawRectangle(self.x, self.y, self.w, self.h, tocolor(150, 150, 150, 200))
    dxDrawRectangle(self.x, self.y, self.w, 22, tocolor(255, 80, 0, 200))
    dxDrawLine(self.x, self.y, self.x+self.w, self.y, tocolor(50, 50, 50), 1)
    dxDrawLine(self.x, self.y+20, self.x+self.w, self.y+20, tocolor(50, 50, 50), 1)
    dxDrawText(self.title, self.x, self.y, self.x + self.w, self.y + 22, tocolor(255, 255, 255), 1, "arial", "center", "center")
    if self.closable then
        --Todo: Use an image as close button not a text that contains 'X' o.O!
        if utils.isHover(self.x + self.w - 22, self.y, 22, 22) then self.hover = true else self.hover = false end
        dxDrawText("X", self.x + self.w - 22, self.y, self.x + self.w, self.y + 22, tocolor(self.hover and 255 or 0, 0, 0), 1, "arial", "center", "center")
    end

    for _, subElement in ipairs(self.subElements) do
        subElement:render()
    end
end

function CDXWindow:onCloseButtonClick(btn, st)
    if btn == "left" and st == "down" then
        if utils.isHover(self.x + self.w - 22, self.y, 22, 22) then
            self:hide()
            return
        end
        if self.movable and not self.moving and utils.isHover(self.x, self.y, self.w, 22) then
            local cX, cY = getCursorPosition()
            self.diff = {cX*x-self.x, cY*y-self.y}
            self.moving = true
        end
    else
        self.moving = false
    end
end

function CDXWindow:getPosition()
    return self.x, self.y + 22      --22 = Header height
end

function CDXWindow:addSubElement(eSubElement)
    table.insert(self.subElements, eSubElement)
end
--Dev
function onLelButtonClick()
    outputChatBox("LOOOOL")
end

addCommandHandler("w",
    function(_, title)
        fadeCamera(true)
        local window = new(CDXWindow, title or "Default", 500, 500, 300, 200, true, true)
        local btn = new(CDXButton, "lel button", 20, 20, 100, 21, tocolor(120, 0, 255), window)
        local cb = new(CDXCheckbox, "First checkbox looool", 20, 45, 200, 14, false, window)
        btn:addClickFunction(onLelButtonClick)

        window:show()
        showCursor(true, true)
    end
)