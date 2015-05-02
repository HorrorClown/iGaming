--
-- HorrorClown (PewX)
-- Using: IntelliJ IDEA 14 Ultimate
-- Date: 01.05.2015 - Time: 05:46
-- pewx.de // iGaming-mta.de // iRace-mta.de // iSurvival.de // mtasa.de
--
CLoginManager = {}

function CLoginManager:constructor()
    addEvent("client:onLogin", true)
    addEventHandler("client:onLogin", resourceRoot, bind(self.onLogin, self))
end

function CLoginManager:destructor()

end

function CLoginManager:onLogin(sUsername, sPW, bEMAIL)
    local userID = WBB:getUserID(sUsername, bEMAIL)
    if userID then
        debugOutput("User is available!")
        if WBB:comparePassword(userID, sPW) then
            if not WBB:isUserActivated(userID) then debugOutput("User is not activated yet") return false end
            client.userID = userID
            client.accountName = not bEMAIL and sUsername or WBB:getUserName(userID)
            client.email = bEMAIL and sUsername or WBB:getUserMail(userID)

            if not client:isRegistered() then
                if client:register() then
                    debugOutput("Client successfully registered!")
                end
            else
                debugOutput("Client is in main database available!")
            end

            client.loggedIn = true
            client:onLogin()
        else
            debugOutput("Invalid login datas!")
        end
    else
        debugOutput("Username or E-Mail not found!")
    end
end