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
local result = DB:query("SELECT * FROM ban WHERE Name=? OR Serial = ?",name, serial)
if #result > 0 then
	result = result[1]
	if tonumber(result["Timestamp"]) > getTimestamp() then
		local restzeit = tonumber(result["Timestamp"]) - getTimestamp()
		local stunden = math.floor(restzeit/3600)
		local Aminuten = restzeit/60
		local minuten = math.floor(Aminuten - (60*stunden))
		cancelEvent(true,"Du bist noch "..stunden.." Stunden und "..minuten.." Minuten gebannt! ("..result["Grund"]..")")
	end
end
end)

addEvent("onPlayerReady",true)
addEventHandler("onPlayerReady",getRootElement(),
function()
if not client.LoggedIn then
local result = DB:query("SELECT * FROM players WHERE Name=?",getPlayerName(client))
fadeCamera(client,true)
if #result > 0 then
	result = result[1]
	if result["Autologin"] == getPlayerSerial(client) then
		loginPlayer(client)
	else
  triggerClientEvent(client,"showPlayerLogin",client)
	end
else
  triggerClientEvent(client,"showPlayerRegister",client)
end
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
local servernameI = servername
local teamspeakI = teamspeak
local forumI = forum
local playercount = getPlayerCount()
local maxplayers = getMaxPlayers()
triggerClientEvent(client,"hierserverinfos",client,servername,teamspeakI,forumI,playercount,maxplayers)
end)

-------------------------------------------------------------

addEvent("neuerAccountRegistriert",true)

addEventHandler("neuerAccountRegistriert",getRootElement(),
function(pw)
if not client.LoggedIn then
  local pname = getPlayerName(client)
   local result = DB:query("SELECT * FROM players WHERE Name=?",pname)
     if #result > 0 then
         outputChatBox("ERROR: ACCOUNT ALREADY CREATED",client,255,0,0)
     else
 	pw = hash("sha512",pw..""..tostring(#pw))
 DB:query("INSERT INTO `players`(`Name`, `Password`, `Serial`, `Geld`, `Level`, `Coins`, `Bankgeld`,`Adminlvl`,`VIP`,`Skin`,`playtime`,`position`,`Securetoken`,`Autologin`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)",getPlayerName(client),pw,getPlayerSerial(client),900,0,0,0,0,0,0,0,firstSpawn,"UEBERGANG","0")
 result = DB:query("SELECT * FROM players WHERE Name=?",pname)
 result = result[1]
   enew(client,CPlayer,result["ID"],pname,result["Password"],result["Serial"],result["Geld"],result["Level"],result["Coins"],result["Bankgeld"],result["Adminlvl"],result["VIP"],result["Skin"],result["playtime"],result["position"],result["Securetoken"],result["Autologin"])
	 client:spawning()
   triggerClientEvent(client,"closePlayerRegister",client)
   local token = client:generateToken()
   outputChatBox("Dein Sicherheitstoken lautet: "..token,client,0,255,0,true)
   outputChatBox("Bitte speicher ihn! Damit kannst du dein Passwort ändern und wichtige Einstellungen treffen!",client,0,255,0,true)
    DB:query("UPDATE players SET Securetoken=? WHERE Name=?", token, client:getName() )
    outputChatBox("Er wurde in deine Zwischenablage hinzugefügt! (STRG + V um ihn einzufügen)",client,0,255,0,true)
    triggerClientEvent(client,"saveToClipboard",client,token)
		client.Securetoken = token
   end
end
end)

-----------------------------------------------------------------

addEvent("checkLogin",true)

addEventHandler("checkLogin",getRootElement(),
function(pw)
  local pname = getPlayerName(client)
  local result = DB:query("SELECT * FROM players WHERE Name=?",pname)
  result = result[1]
  if result["Password"] == hash("sha512",pw..""..tostring(#pw)) then
  enew(client,CPlayer,result["ID"],pname,result["Password"],result["Serial"],result["Geld"],result["Level"],result["Coins"],result["Bankgeld"],result["Adminlvl"],result["VIP"],result["Skin"],result["playtime"],result["position"],result["Securetoken"],result["Autologin"])
    outputChatBox("Erfolgreich eingeloggt!",client,0,255,0)
    triggerClientEvent(client,"closePlayerLogin",client)
    client:spawning()
  else
    outputChatBox("Wrong password!",client,255,0,0)
  end
end)

function loginPlayer(player)
	  local pname = getPlayerName(player)
	  local result = DB:query("SELECT * FROM players WHERE Name=?",pname)
	  result = result[1]
	  enew(player,CPlayer,result["ID"],pname,result["Password"],result["Serial"],result["Geld"],result["Level"],result["Coins"],result["Bankgeld"],result["Adminlvl"],result["VIP"],result["Skin"],result["playtime"],result["position"],result["Securetoken"],result["Autologin"])
	    outputChatBox("Auto-Login aktiv!",client,0,255,0)
	    player:spawning()
			triggerClientEvent(player,"cancelSmoothCamera",player)
end
