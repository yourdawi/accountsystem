--[[
@Class Database
- Database management

---- Functions ------

CDatabase:excec(sQuery [, ...args])
	Excecutes a Query without any result or callback. Use for one-way Querys.

CDatabase:query(sQuery [, ...args])
	Excecutes a SQL-Query. You will get a Table as result.

]]
CDatabase = {}

function CDatabase:constructor(sType, sHost, sUser, sPass, sDBName, iPort)
	self.sType = sType
	self.sHost = sHost
	self.sUser = sUser
	self.sPass = sPass
	self.sDBName = sDBName
	self.iPort = iPort

	if (self.sType == "mysql") then
		self.hCon = dbConnect(self.sType, "dbname="..self.sDBName..";host="..self.sHost..";port="..iPort, self.sUser, self.sPass)
		if ((self.hCon ~= false) and (self.hCon)) then
			outputServerLog("Datenbankverbindung hergestellt!")
			self.tStundenTimer = bind(CDatabase.stundenTimer, self)
		else
			outputServerLog("Datenbankverbindung konnte nicht hergestellt werden!")
			stopResource(getThisResource())
		end
	else
		outputServerLog("Please add specific Database Connection!")
		stopResource(getThisResource())
	end
end

function CDatabase:destructor()
	self.sType = nil
	self.sHost = nil
	self.sUser = nil
	self.sPass = nil
	self.sDBName = nil
	self.iPort = nil
	destroyElement(self.hCon)
end

function CDatabase:query(sQuery, ...)
	local qHandler = dbQuery(self.hCon,sQuery, ...)
	local result, iRows, sError = dbPoll ( qHandler, 20)
	if (result == nil) then
		local result, iRows, sError = dbPoll ( qHandler, 60)
		if(result == nil) then
			dbFree(qHandler)
			return false
		end
	end

	if (result == false) then
		outputDebugString("Error Excecuting Query: "..sQuery.." ||"..iRows.."| "..sError)
		return false
	end
	return result, iRows
end

function CDatabase:exec(sQuery, ...)
	return dbExec(self.hCon, sQuery, ...)
end


function CDatabase:savePlayer(thePlayer)
	thePlayer:save()
end

function CDatabase:saveAllPlayers()
	local players = getElementsByType("player")
	if (#players > 0) then
		for i,thePlayer in ipairs(players) do
			if (thePlayer.LoggedIn == true) then
				thePlayer:save()
			end
		end
	end
end

function CDatabase:stundenTimer()
	saveAllPlayers()
end

DB = new(CDatabase,"mysql", "127.0.0.1", "root", "", "accountsystem", 3306)
