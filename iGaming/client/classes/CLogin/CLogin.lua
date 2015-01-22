--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 17.01.2015 - Time: 19:15
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CLogin = {}

function CLogin:constructor()
  self:createLoginWindow()
end

function CLogin:destructor()
  
end

function CLogin:createLoginWindow()
  self.loginWindow = new(CDXWindow, "iGaming - Login", x/2, y/2, 640, 300, false, false)
  self.username = new(CDXEdit, "Username", 20, 20, 200, 21, false, false, window)
  self.password = new(CDXEdit, "Password", 20, 50, 200, 21, false, true, window)
  self.autoLogin = new(CDXCheckbox, "Enable auto-login", 20, 90, 200, 14, false, window)
  self.btn_login = new(CDXButton, "Login", 190, 150, 100, 20, tocolor(120, 0, 255), window)
  self.btn_login:addClickFunction(bind(self.onClientLogin, self))
end

function CLogin:onClientLogin()
  outputChatBox("Client login!")
end
