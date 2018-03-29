GERMAN

Bitte benutzt nur die veröffentlichten Versionen.
https://github.com/yourdawi/accountsystem/releases

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

Häuser: (v1.2|SOON)
hausElement:enter(player)          -Spieler in Haus einlassen.
hausElement:leave(player)					 -Spieler aus Haus herauslassen.
spielerElement:addPlayerHouse(x,y,z,interior,preis)			-Interior bedeutet ID|X|Y|Z

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

ENGLISH

Please use always the released version.
https://github.com/yourdawi/accountsystem/releases

This is a standalone Accountsystem, no specific Gamemode needed.
Please import the sql in your Database and edit the cDatabase.lua (server/classes).

FAQ:
Q: How can i change the Teamspeak/Forum/Servername?
A: Settings.lua (shared folder)

Q: I do not want to use the Vehiclesystem. How can i change it?
A: settings.lua (shared folder). Change UseVehicleSystem to false.

F: How can i change the spawn?
A: settings.lua (shared folder) (Interior|Dimension|X|Y|Z|Rotation Z).

Functions: (Serverside)
Money: (integer)
playerElement:takeMoney(GELD)   	    
playerElement:giveMoney(Geld)   	    
playerElement:setMoney(Geld)     	    
playerElement:getMoney()          	    

Bankmoney: (integer)
playerElement:giveBankMoney(Geld) 	    
playerElement:takeBankMoney(Geld)	    
playerElement:setBankMoney(Geld) 	 	
playerElement:getBankMoney()     		

Skin: (integer)
playerElement:setSkin(ID)        	    
playerElement:getSkin()		  	   

Ban: (Element,Integer,String)
playerElement:ban(Admin,Time,Reason)    

Player:
playerElement:getName()			    
playerElement:getSerial()				

Vehicle:
vehicleElement:changeEngineState()  
vehicleElement:lock(player)				 -Player is not needed
playerElement:addPlayerCar(model,x,y,z,rx,ry,rz,int,dim)   -Create a vehicle and add it to a player

House: (v1.2|SOON)
houseElement:enter(player)          
houseElement:leave(player)					 
playerElement:addPlayerHouse(x,y,z,interior,preis)			-Interior means ID|X|Y|Z

Extension: (String)
playerElement:clipboard(text)			-Text to clipboard

Save:
playerElement:save()				

Playtime:
playerElement:getPlaytime()             -Playtime in minutes

Example:
addCommandHandler("doanything",
function(player)
	player:giveBankMoney(141)
	player:ban(player,1,"Oh")
end)

Please remove row 14 in server/classes/cPlayer.lua, if you don´t use the default dxScoreboard.
You can also delete any playtime elementdata.

You must set oop to true in the meta.xml
