--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 19.12.2014 - Time: 18:19
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CDXManager = inherit()

function CDXManager:constructor()

end

function CDXManager:destructor()

end

function CDXManager:show()
    addEventHandler("onClientRender", root, self.onRenderFunc)
    addEventHandler("onClientClick", root, self.onCloseButtonClickFunc)
    for _, subElement in ipairs(self.subElements) do
        subElement:addClickHandler()
    end
    self.isVisible = true
end

function CDXManager:hide()
    removeEventHandler("onClientRender", root, self.onRenderFunc)
    removeEventHandler("onClientClick", root, self.onCloseButtonClickFunc)
    for _, subElement in ipairs(self.subElements) do
        subElement:removeClickHandler()
    end
    self.isVisible = false
end

function CDXManager:onClick(btn, st)
    if btn == "left" and st == "down" then
        if utils.isHover(self.x, self.y, self.w, self.h) then
            for _, aFunc in ipairs(self.clickExecute) do
                aFunc(self)
            end
        end
    end
end

function CDXManager:addClickFunction(fCallFunc)
    table.insert(self.clickExecute, bind(fCallFunc, self))
    if not self.onClickFunc then self.onClickFunc = bind(self.onClick, self) end
end

function CDXManager:addClickHandler()
    addEventHandler("onClientClick", root, self.onClickFunc)
end

function CDXManager:removeClickHandler()
    removeEventHandler("onClientClick", root, self.onClickFunc)
end
