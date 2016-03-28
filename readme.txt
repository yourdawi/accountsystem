GERMAN

Dies ist ein Gamemode unabhängiges, selbstständiges Accountsystem.
Bitte importiere die sql in deine Datenbank und passe die cDatabase.lua unter server/classes an.

Ebenfall befindet sich in der cDatabase.lua das gibserverinfos Event, dort kannst du deine Forum bzw. Teamspeak Adresse definieren. Die angegebenen Daten in der register_login.lua unter client werden davon überschrieben.

Bei Fragen kontaktiere mich im mta-sa.org Forum (yourdawi.de)


Funktionen: (Serverseitig)

spielerElement:takeMoney(GELD)   	    -Geld wird abgezogen
spielerElement:giveMoney(Geld)   	    -Geld wird addiert
spielerElement:setMoney(Geld)     	    -Geld wird auf einen Wert gesetzt
spielerElement:getMoney()          	    -Geldwert erhalten

spielerElement:giveBankMoney(Geld) 	    -Bankgeld wird addiert
spielerElement:takeBankMoney(Geld)	    -Bankgeld wird abgezogen
spielerElement:setBankMoney(Geld) 	 	-Bankgeld wird auf einen Wert gesetzt
spielerElement:getBankMoney()     		-Bangeldwert erhalten

spielerElement:setSkin(ID)        	    -Skin setzen
spielerElement:getSkin()		  	    -Skin ID erhalten

spielerElement:ban(Admin,Zeit,Grund)    -Spieler bannen (Admin als Element, Zeit in Stunden, Grund)

spielerElement:getName()			    -Namen herausbekommen
spielerElement:getSerial()				-Serial herausbekommen

spielerElement:clipboard(text)			-Text in die Zwischenablage kopieren

spielerElement:save()					-Spieldaten speichern


Bitte Zeile 14 in server/classes/cPlayer.lua entfernen, wenn ihr nicht das dxScoreboard benutzt.
Ebenfalls kann nun alles von der Playtime ElementData gelöscht werden.


