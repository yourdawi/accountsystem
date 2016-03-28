--[[
#######################################
#######################################
###########Erstellt von Dawi###########
##########github.com/yourdawi##########
##############yourdawi.de##############
#######################################
#######################################
]]

local Servername = "MTA SERVER"
local Teamspeak = "Kein Teamspeak"
local Forum = "Kein Forum"
local Playercount = 0
local Maxplayers = 0

local sx,sy = guiGetScreenSize()
local sxx,syy = 1280,720

addEvent("hierserverinfos",true)

addEventHandler("hierserverinfos",getRootElement(),
function(servername,teamspeak,forum,playercount,maxplayers)
  Servername = servername
  Teamspeak = teamspeak
  Forum = forum
  Playercount = playercount
  Maxplayers = maxplayers
end)

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),
function()
triggerServerEvent("gibserverinfos",localPlayer)
triggerServerEvent("onPlayerReady",localPlayer)
smoothMoveCamera(1363.2806396484,-1040.5749511719,86.322746276855,1381.6203613281,-942.50311279297,79.572212219238,1398.0366210938,-865.80969238281,82.560356140137,1416.4176025391,-767.51751708984,83.447769165039,30000)
end)
-------------------------------------------------------------------------------------------------------
addEvent("showPlayerRegister",true)

addEvent("closePlayerRegister",true)
addEventHandler("closePlayerRegister",getRootElement(),
function()
  showCursor(false)
  destroyElement(register)
  destroyElement(password)
  destroyElement(password2)
  removeEventHandler("onClientRender",getRootElement(),renderRegister)
  destroySMCamera()
end)


function showRegister()
  showCursor(true)
  addEventHandler("onClientRender",getRootElement(),renderRegister)
  register = guiCreateButton(418/sxx*sx, 420/syy*sy, 157/sxx*sx, 45/syy*sy, "Registrieren", false)


  password = guiCreateEdit(410/sxx*sx, 263/syy*sy, 209/sxx*sx, 30/syy*sy, "password", false)
  guiEditSetMasked(password, true)


  password2 = guiCreateEdit(410/sxx*sx, 349/syy*sy, 209/sxx*sx, 30/syy*sy, "aasdwsrt", false)
  guiEditSetMasked(password2, true)

  addEventHandler ( "onClientGUIClick", register,
  function()
    if guiGetText(password) == guiGetText(password2) and guiGetText(password) ~= "" then
      triggerServerEvent("neuerAccountRegistriert",localPlayer,guiGetText(password))
    else
      outputChatBox("Passwörter stimmen nicht überein oder keines angegeben!",255,0,0)
    end
  end, false )
end
addEventHandler("showPlayerRegister",getRootElement(),showRegister)
function renderRegister()
dxDrawImage(354/sxx*sx, 45/syy*sy, 500/sxx*sx, 600/syy*sy, "res/register.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
dxDrawText("Willkommen auf " ..Servername..", " ..getPlayerName(localPlayer).."!\nBitte registriere dich um auf diesem Server spielen zu können.\nSolltest du Probleme haben, bitte wende dich an einen Administrator.\nDeine Daten werden bei uns gespeichert, allerdings verschlüsselt!\nNach der Registrierung erhälst du einen Token, bitte speicher ihn!", 432/sxx*sx, 79/syy*sy, 824/sxx*sx, 180/syy*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
dxDrawText("Passwort", 410/sxx*sx, 226/syy*sy, 508/sxx*sx, 253/syy*sy, tocolor(255, 255, 255, 255), 1.50, "default-bold", "left", "top", false, false, false, false, false)
dxDrawText("Passwort wiederholen", 410/sxx*sx, 310/syy*sy, 629/sxx*sx, 339/syy*sy, tocolor(255, 255, 255, 255), 1.50, "default-bold", "left", "top", false, false, false, false, false)
dxDrawText(Teamspeak..";"..Forum..";"..Playercount.."/"..Maxplayers.." online", 401/sxx*sx, 589/syy*sy, 811/sxx*sx, 614/syy*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
end

-----------------------------------------------------------------------------------------------------------------
addEvent("showPlayerLogin",true)

addEvent("closePlayerLogin",true)
addEventHandler("closePlayerLogin",getRootElement(),
function()
  showCursor(false)
  destroySMCamera()
destroyElement(login)
destroyElement(passwordLogin)
removeEventHandler("onClientRender",getRootElement(),renderLogin)
end)

function showLogin()
  showCursor(true)
login = guiCreateButton(550/sxx*sx, 410/syy*sy, 117/sxx*sx, 38/syy*sy, "Login", false)
passwordLogin = guiCreateEdit(503/sxx*sx, 361/syy*sy, 149/sxx*sx, 28/syy*sy, "", false)
guiEditSetMasked(passwordLogin, true)
addEventHandler("onClientRender",getRootElement(),renderLogin)
  addEventHandler("onClientGUIClick", login,
    function()
      triggerServerEvent("checkLogin",localPlayer,guiGetText(passwordLogin))
    end,false)
end
addEventHandler("showPlayerLogin",getRootElement(),showLogin)
function renderLogin()
dxDrawImage(438/sxx*sx, 190/syy*sy, 350/sxx*sx, 350/syy*sy, "res/login.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
dxDrawText("Willkommen "..getPlayerName(localPlayer)..",\ndieser Name ist bereits registriert!\nBitte logge dich ein oder ändere den Namen!\n", 503/sxx*sx, 225/syy*sy, 755/sxx*sx, 284/syy*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
dxDrawText("Passwort", 503/sxx*sx, 322/syy*sy, 641/sxx*sx, 351/syy*sy, tocolor(255, 255, 255, 255), 1.50, "default-bold", "left", "top", false, false, false, false, false)
dxDrawText(Teamspeak..";"..Forum..";"..Playercount.."/"..Maxplayers.." online", 474/sxx*sx, 486/syy*sy, 747/sxx*sx, 509/syy*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
end
