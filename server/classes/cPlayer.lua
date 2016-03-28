--[[
#######################################
#######################################
###########Erstellt von Dawi###########
##########github.com/yourdawi##########
##############yourdawi.de##############
#######################################
#######################################
]]

CPlayer = {}
Players = {}

exports.scoreboard:scoreboardAddColumn( "Playtime" )
----EVENTS-----
addEvent("checkSecureCode",true)
addEventHandler("checkSecureCode",getRootElement(),
function(code)
if source:getToken() == code then
  triggerClientEvent(source,"codeCheckErgebnis",source,true)
else
  outputChatBox("Dein Sicherheitscode stimmt nicht überrein!",source,255,0,0,true)
end
end)

addEvent("AutoLoginChange",true)

function CPlayer:constructor(id,name,password,serial,geld,level,coins,bankgeld,adminlvl,vip,skin,playtime,position,securetoken,autologin)
  self.ID = id
  self.Name = name
  self.Password = password
  self.Serial = serial
  self.Geld = geld
  setPlayerMoney(self,self.Geld)
  self.Level = level
  self.Coins = coins
  self.Bankgeld = bankgeld
  self.Adminlvl = adminlvl
    setElementData(self,"Adminlvl",self.Adminlvl)
  self.VIP = vip
    setElementData(self,"VIP",self.VIP)
  self.Skin = skin
  self.PlayTime = playtime
  local stunden = math.floor(self.PlayTime/60)
  local minuten = math.floor(self.PlayTime - (60*stunden))
  setElementData(self,"Playtime",stunden..":"..minuten)
  self.Koords = position
  self.Securetoken = securetoken
  self.AutoLogin = autologin
  setElementData(self,"AutoLogin",self.AutoLogin)
  self.LoggedIn = true
  setCameraTarget(self,self)
  Players[self.ID] = self

self.eOnQuit = bind(CPlayer.quit,self)
addEventHandler("onPlayerQuit",self,self.eOnQuit)

self.tMinuteTimer = bind(CPlayer.minuteTimer, self)

if (isTimer(self.mTimer)) then
			else
				self.mTimer = setTimer(self.tMinuteTimer, 60000, 0)
			end
end

function CPlayer:addPlaytime()
  self.PlayTime = self.PlayTime + 1
  local stunden = math.floor(self.PlayTime/60)
  local minuten = math.floor(self.PlayTime - (60*stunden))
  setElementData(self,"Playtime",stunden..":"..minuten)
end
--GELD
function CPlayer:takeMoney(money)
  if self.Geld >= money then
  self.Geld = self.Geld - money
  takePlayerMoney(self,money)
else
  return false
end
end

function CPlayer:giveMoney(money)
  self.Geld = self.Geld + money
  givePlayerMoney(self,money)
end

function CPlayer:setMoney(money)
  self.Geld = money
  setPlayerMoney(self.Geld)
end

function CPlayer:getMoney()
  return self.Geld
end

function CPlayer:giveBankMoney(money)
  self.Bankgeld = self.Bankgeld + money
end

function CPlayer:takeBankMoney(money)
  if self.Bankgeld >= money then
    self.Bankgeld = self.Bankgeld - money
  else
    return false
  end
end

function CPlayer:getBankMoney()
  return self.Bankgeld
end

function CPlayer:setBankMoney(money)
  self.Bankgeld = money
end

--Skin
function CPlayer:setSkin(id)
  if setElementModel(self,id) then
  self.Skin = id
else
  return false
end
end

function CPlayer:getSkin()
  return self.Skin
end

--BANSYSTEM

function CPlayer:ban(admin,time,areason)
local timestamp = getTimestamp() + (time*3600)
local reason = admin:getName()..": "..areason
  DB:query("INSERT INTO `ban`(`Name`, `Serial`, `Timestamp`, `Grund`) VALUES (?,?,?,?)",self:getName(),self:getSerial(),timestamp,reason)
end

function CPlayer:getName()
  return self.Name
end

function CPlayer:getSerial()
  return self.Serial
end

function CPlayer:generateToken()
  local token = tostring(math.random(500,9999))..""..self.ID..""..self.Serial..""..self.Name..""..tostring(math.random(500,9999))
  local securetoken = sha256(token)
  return securetoken
end

function CPlayer:getToken()
  return self.Securetoken
end

function CPlayer:spawning()
local int,dim,x,y,z,rz = gettok(self.Koords,1,"|"),gettok(self.Koords,2,"|"),gettok(self.Koords,3,"|"),gettok(self.Koords,4,"|"),gettok(self.Koords,5,"|"),gettok(self.Koords,6,"|")
spawnPlayer(self,x,y,z,rz,self.Skin,int,dim)
end

function CPlayer:clipboard(text)
  triggerClientEvent(self,"saveToClipboard",self)
end

----SAVE SYSTEM-----

function CPlayer:save()
local x,y,z = getElementPosition(self)
local rx,ry,rz = getElementRotation(self)
local int = getElementInterior(self)
local dim = getElementDimension(self)
self.Koords = tostring(int).."|"..tostring(dim).."|"..tostring(x).."|"..tostring(y).."|"..tostring(z).."|"..tostring(rz)
DB:query("UPDATE players SET Geld=?,Level=?,Coins=?,Bankgeld=?,Adminlvl=?,VIP=?,Skin=?,playtime=?,position=? WHERE Name=?", self.Geld, self.Level, self.Coins, self.Bankgeld, self.Adminlvl, self.VIP, self.Skin, self.PlayTime, self.Koords, self:getName() )
end

function CPlayer:minuteTimer()
  self:addPlaytime()
if (self.Played_Time%60 == 0) then
  outputChatBox("++++STUNDENBONUS++++",self,0,255,0)
  local paydaywin = self.Bankgeld/100*3
  outputChatBox("BANK: Du hast "..paydaywin.."$ Zinsen erhalten!",self,0,255,0)
  self.Bankgeld = self.Bankgeld + paydaywin
  outputChatBox("COINS: Du hast 1 Coin erhalten.",self,0,255,0)
  self.Coins = self.Coins + 1
end
end

function CPlayer:quit()
  self:save()
end

addEvent("UserChangePassword",true)
addEventHandler("UserChangePassword",getRootElement(),
function(pw,token)
  if token == source:getToken() then
    pw = md5(pw)
    DB:query("UPDATE players SET Password=? WHERE Name=?", pw, source:getName() )
    outputChatBox("Passwort geändert!",source,255,255,255,true)
  end
end)

addEventHandler("AutoLoginChange",getRootElement(),
function(state)
  if state == true then
    DB:query("UPDATE players SET Autologin=? WHERE Name=?", getPlayerSerial(source), source:getName() )
    source.AutoLogin = getPlayerSerial(source)
    outputChatBox("Autologin aktiviert!",source,255,255,255,true)
  else
    DB:query("UPDATE players SET AutoLogin=? WHERE Name=?", "0", source:getName() )
    source.AutoLogin = "0"
    outputChatBox("Autologin deaktiviert!",source,255,255,255,true)
  end
end)
