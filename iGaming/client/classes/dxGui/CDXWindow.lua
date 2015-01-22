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
    self.alpha = 255

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

    dxDrawRectangle(self.x-10, self.y-10, self.w+20, self.h+20, tocolor(0, 0, 0, self.alpha/255*50))
    dxDrawRectangle(self.x, self.y, self.w, self.h, tocolor(50, 50, 50, self.alpha/255*200))
    dxDrawRectangle(self.x, self.y, self.w, 22, tocolor(255, 80, 0, self.alpha/255*200))
    dxDrawLine(self.x, self.y+22, self.x+self.w, self.y+22, tocolor(60, 60, 60, self.alpha), 1)
    dxDrawLine(self.x, self.y+23, self.x+self.w, self.y+23, tocolor(120, 120, 120, self.alpha), 1)
    dxDrawText(self.title, self.x, self.y, self.x + self.w, self.y + 22, tocolor(255, 255, 255, self.alpha), 1, "arial", "center", "center")
    if self.closable then
        --Todo: Use an image as close button not a text that contains 'X' o.O!
        if utils.isHover(self.x + self.w - 22, self.y, 22, 22) then self.hover = true else self.hover = false end
        dxDrawText("X", self.x + self.w - 22, self.y, self.x + self.w, self.y + 22, tocolor(self.hover and 255 or 0, 0, 0), 1, "arial", "center", "center")
    end

    for _, subElement in ipairs(self.subElements) do
        if subElement.alpha then subElement.alpha = self.alpha end
        subElement:render()
    end
end

function CDXWindow:onCloseButtonClick(btn, st)
    if btn == "left" and st == "down" then
        if self.closable and utils.isHover(self.x + self.w - 22, self.y, 22, 22) then
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
--[[addCommandHandler("i",
    function()
        local image = new(CDXImage, "res/images/iGaming.png", x/2, y/2, 256, 256, tocolor(255, 255, 255))
        image:addAnimation("rotate")
        image:starAnimation()
        addEventHandler("onClientRender", root,
            function()
                image:render()
            end
        )
    end
)

addCommandHandler("w",
    function(_, title)
        fadeCamera(true)
        local window = new(CDXWindow, title or "iGaming ", 500, 500, 300, 200, true, true)

        local edit = new(CDXEdit, "Username", 20, 20, 200, 21, false, false, window)
        local edit2 = new(CDXEdit, "Password", 20, 50, 200, 21, false, true, window)
        local cb = new(CDXCheckbox, "Enable auto-login", 20, 90, 200, 14, false, window)
        local btn = new(CDXButton, "Login", 190, 150, 100, 20, tocolor(120, 0, 255), window)
        btn:addClickFunction(onLelButtonClick)

        window:show()
        showCursor(true, true)
    end
)]]
