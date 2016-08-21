GERMAN

Dies ist ein Gamemode unabhängiges, selbstständiges Accountsystem.
Bitte importiere die sql in deine Datenbank und passe die cDatabase.lua unter server/classes an.

Bei Fragen kontaktiere mich im mta-sa.org Forum (yourdawi.de), aber lies zuerst die FAQ.

FAQ:
F: Wie ändere ich die Teamspeak/Forum/Servername Daten?
A: In der settings.lua im shared Ordner.

F: Ich möchte das Fahrzeugsystem nicht nutzen. Wie kann ich es deaktivieren?
A: In der settings.lua im shared Ordner. Ändere UseVehicleSystem auf false.

F: Wie ändere ich den Spawn?
A: In der settings.lua im shared Ordner. (Interior|Dimension|X|Y|Z|Rotation Z).

Funktionen: (Serverseitig)
Geld: (integer)
spielerElement:takeMoney(GELD)   	    -Geld wird abgezogen
spielerElement:giveMoney(Geld)   	    -Geld wird addiert
spielerElement:setMoney(Geld)     	    -Geld wird auf einen Wert gesetzt
spielerElement:getMoney()          	    -Geldwert erhalten

Bankgeld: (integer)
spielerElement:giveBankMoney(Geld) 	    -Bankgeld wird addiert
spielerElement:takeBankMoney(Geld)	    -Bankgeld wird abgezogen
spielerElement:setBankMoney(Geld) 	 	-Bankgeld wird auf einen Wert gesetzt
spielerElement:getBankMoney()     		-Bangeldwert erhalten

Skin: (integer)
spielerElement:setSkin(ID)        	    -Skin setzen
spielerElement:getSkin()		  	    -Skin ID erhalten

Ban: (Element,Integer,String)
spielerElement:ban(Admin,Zeit,Grund)    -Spieler bannen (Admin als Element, Zeit in Stunden, Grund)

Player:
spielerElement:getName()			    -Namen herausbekommen
spielerElement:getSerial()				-Serial herausbekommen

Fahrzeug:
fahrzeugElement:changeEngineState()  -Motor an/aus
fahrzeugElement:lock(player)				 -Fahrzeug auf zu. Player optional.
spielerElement:addPlayerCar(model,x,y,z,rx,ry,rz,int,dim)   -Fahrzeug einem Spieler geben (wird erstellt).

Zusatz: (String)
spielerElement:clipboard(text)			-Text in die Zwischenablage kopieren

Save:
spielerElement:save()					-Spieldaten speichern

Spielzeit:
spielerElement:getPlaytime()             -Spielzeit in Minuten

Beispiel:
addCommandHandler("machmalmist",
function(player)
	player:giveBankMoney(141)
	player:ban(player,1,"Mist")
end)

Bitte Zeile 14 in server/classes/cPlayer.lua entfernen, wenn ihr nicht das dxScoreboard benutzt.
Ebenfalls kann nun alles von der Playtime ElementData gel�scht werden.

OOP muss in der meta.xml auf true stehen.
