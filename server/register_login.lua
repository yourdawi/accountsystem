--[[
#######################################
#######################################
###########Erstellt von Dawi###########
##########github.com/yourdawi##########
##############yourdawi.de##############
#######################################
#######################################
]]
addEventHandler("onPlayerChangeNick",getRootElement(),
function()
cancelEvent()
end)

invalidChars = {}
for i = 33, 39 do
invalidChars[i] = true
end
for i = 40, 43 do
invalidChars[i] = true
end
invalidChars[47] = true
for i = 58, 64 do
invalidChars[i] = true
end
invalidChars[92] = true
invalidChars[94] = true
invalidChars[96] = true
for i = 123, 126 do
invalidChars[i] = true
end

function hasInvalidChar ( player )

	name = getPlayerName ( player )
	for i, index in pairs ( invalidChars ) do
		if not gettok ( name, 1, i ) or gettok ( name, 1, i ) ~= name then
			return true
		end
	end
	return false
end

addEventHandler("onPlayerConnect",getRootElement(),
function(pName,pIP,pUSername,pSerial)
for i,v in ipairs(getElementsByType("player")) do
	if getPlayerSerial(v) == pSerial then
		cancelEvent(true,"Serial in use")
	end
end
end)

--BANCHECK
addEventHandler("onPlayerConnect",getRootElement(),
function(name,_,_,serial)
local result = DB:query("SELECT * FROM ban WHERE Name=?",name)
local resultt = DB:query("SELECT * FROM ban WHERE Serial=?",serial)
if #result > 0 then
	result = result[1]
	if tonumber(result["Timestamp"]) > getTimestamp() then
		local restzeit = tonumber(result["Timestamp"]) - getTimestamp()
		local stunden = math.floor(restzeit/3600)
		local Aminuten = restzeit/60
		local minuten = math.floor(Aminuten - (60*stunden))
		cancelEvent(true,"Du bist noch "..stunden.." Stunden und "..minuten.." Minuten gebannt! ("..result["Grund"]..")")
	end
else
	if #resultt > 0 then
		resultt = resultt[1]
		if tonumber(resultt["Timestamp"]) > getTimestamp() then
			local restzeit = tonumber(resultt["Timestamp"]) - getTimestamp()
			local stunden = math.floor(restzeit/3600)
			local Aminuten = restzeit/60
			local minuten = math.floor(Aminuten - (60*stunden))
			cancelEvent(true,"Du bist noch "..stunden.." Stunden und "..minuten.." Minuten gebannt! ("..resultt["Grund"]..")")
		end
	end
end
end)

addEvent("onPlayerReady",true)
addEventHandler("onPlayerReady",getRootElement(),
function()
local result = DB:query("SELECT * FROM players WHERE Name=?",getPlayerName(source))
fadeCamera(source,true)
if #result > 0 then
	result = result[1]
	if result["Autologin"] == getPlayerSerial(source) then
		loginPlayer(source)
	else
  triggerClientEvent(source,"showPlayerLogin",source)
	end
else
  triggerClientEvent(source,"showPlayerRegister",source)
end
end)

--------------------------------------------------------------------------------------
addEventHandler("onPlayerJoin",getRootElement(),
function()
if hasInvalidChar(source) then
kickPlayer ( source, "Your name contains invalid characters!" )
end
end)


addEvent("gibserverinfos",true)

addEventHandler("gibserverinfos",getRootElement(),
function()
local servername = getServerName()
local teamspeak = "KEIN TEAMSPEAK"
local forum = "KEIN FORUM"
local playercount = getPlayerCount()
local maxplayers = getMaxPlayers()
triggerClientEvent(source,"hierserverinfos",source,servername,teamspeak,forum,playercount,maxplayers)
end)

-------------------------------------------------------------

addEvent("neuerAccountRegistriert",true)

addEventHandler("neuerAccountRegistriert",getRootElement(),
function(pw)
  local pname = getPlayerName(source)
   local result = DB:query("SELECT * FROM players WHERE Name=?",pname)
     if #result > 0 then
         outputChatBox("ERROR: ACCOUNT ALREADY CREATED",source,255,0,0)
     else
 	pw = md5(pw)
 DB:query("INSERT INTO `players`(`Name`, `Password`, `Serial`, `Geld`, `Level`, `Coins`, `Bankgeld`,`Adminlvl`,`VIP`,`Skin`,`playtime`,`position`,`Securetoken`,`Autologin`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)",getPlayerName(source),pw,getPlayerSerial(source),900,0,0,0,0,0,0,0,"0|0|0|0|4|0","UEBERGANG","0")
 result = DB:query("SELECT * FROM players WHERE Name=?",pname)
 result = result[1]
   enew(source,CPlayer,result["ID"],pname,result["Password"],result["Serial"],result["Geld"],result["Level"],result["Coins"],result["Bankgeld"],result["Adminlvl"],result["VIP"],result["Skin"],result["playtime"],result["position"],result["Securetoken"],result["Autologin"])
	 source:spawning()
   triggerClientEvent(source,"closePlayerRegister",source)
   local token = source:generateToken()
   outputChatBox("Dein Sicherheitstoken lautet: "..token,source,0,255,0,true)
   outputChatBox("Bitte speicher ihn! Damit kannst du dein Passwort ändern und wichtige Einstellungen treffen!",source,0,255,0,true)
    DB:query("UPDATE players SET Securetoken=? WHERE Name=?", token, source:getName() )
    outputChatBox("Er wurde in deine Zwischenablage hinzugefügt! (STRG + V um ihn einzufügen)",source,0,255,0,true)
    triggerClientEvent(source,"saveToClipboard",source,token)
		source.Securetoken = token
   end
end)

-----------------------------------------------------------------

addEvent("checkLogin",true)

addEventHandler("checkLogin",getRootElement(),
function(pw)
  local pname = getPlayerName(source)
  local result = DB:query("SELECT * FROM players WHERE Name=?",pname)
  result = result[1]
  if result["Password"] == md5(pw) then
  enew(source,CPlayer,result["ID"],pname,result["Password"],result["Serial"],result["Geld"],result["Level"],result["Coins"],result["Bankgeld"],result["Adminlvl"],result["VIP"],result["Skin"],result["playtime"],result["position"],result["Securetoken"],result["Autologin"])
    outputChatBox("Erfolgreich eingeloggt!",source,0,255,0)
    triggerClientEvent(source,"closePlayerLogin",source)
    source:spawning()
  else
    outputChatBox("Wrong password!",source,255,0,0)
  end
end)

function loginPlayer(player)
	  local pname = getPlayerName(player)
	  local result = DB:query("SELECT * FROM players WHERE Name=?",pname)
	  result = result[1]
	  enew(player,CPlayer,result["ID"],pname,result["Password"],result["Serial"],result["Geld"],result["Level"],result["Coins"],result["Bankgeld"],result["Adminlvl"],result["VIP"],result["Skin"],result["playtime"],result["position"],result["Securetoken"],result["Autologin"])
	    outputChatBox("Auto-Login aktiv!",source,0,255,0)
	    player:spawning()
end
