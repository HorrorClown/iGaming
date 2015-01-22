--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 17.01.2015 - Time: 19:15
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CLogin = {}

function CLogin:constructor()
  setTime(12, 0)
  setMinuteDuration(0)
  setPlayerHudComponentVisible("all", false)
  fadeCamera(true)
  setCloudsEnabled(false)

  self:showLogo()
  --self:createLoginWindow()
end

function CLogin:destructor()
  
end

function CLogin:showLogo()
   self.logo = new(CDXImage, "res/images/iGaming.png", 0, 0, 0, 0, tocolor(255, 255, 255))
  self.logo:show()
  self.anim_logo = new(CDXAnimation, self.logo, "wipe", 3000, "InOutQuad", 1000)
   self.anim_pos = new(CDXAnimation, self.logo, "changePos", 5000, "InOutQuad", x/2-128, y/2-128)
   self.anim_res = new(CDXAnimation, self.logo, "changeSize", 5000, "InOutQuad", 256, 256)
   self.anim_pos:startAnimation()
  self.anim_logo:startAnimation()
  self.anim_res:startAnimation()
end

function CLogin:createLoginWindow()
  self.loginWindow = new(CDXWindow, "iGaming - Login", x/2-220/2, y/2-180/2, 220, 180, false, false)
  self.username = new(CDXEdit, "Username", 20, 20, 155, 21, false, false, self.loginWindow)
  self.password = new(CDXEdit, "Password", 20, 50, 155, 21, false, true, self.loginWindow)
  self.autoLogin = new(CDXCheckbox, "Enable auto-login", 20, 90, 200, 14, false, self.loginWindow)
  self.btn_login = new(CDXButton, "Login", 20, 120, 100, 20, tocolor(120, 0, 255), self.loginWindow)
  self.btn_login:addClickFunction(bind(self.onClientLogin, self))

  self.loginWindow:show()
  showCursor(true)
end

function CLogin:onClientLogin()
  outputChatBox("Client login!")
end

--------------------------
---------------------------
----------------------
local angle, duration = 0, 0
addCommandHandler("setAngle", function(_, a)
  angle = tonumber(a)
  showCursor(true)
end)

addCommandHandler("setDuration", function(_, d)
  duration = tonumber(d)
  showCursor(true)
end)

addEventHandler("onClientClick", root,
  function(btn, st, ax, ay)
    if btn == "left" and st == "down" then
      local p,k = ax, ay
      image = new(CDXImage, "res/images/iGaming.png", p-128, k-128, 256, 256, tocolor(255, 255, 255))
      image:show()
      image.animation = new(CDXAnimation, image, "wipe", duration, "InOutQuad", angle)
      image.animation:startAnimation()
      setTimer(function(image)
        delete(image.animation)
        delete(image)
      end, 20000, 1, image)
    end
  end)