--[[
#######################################
#######################################
###########Erstellt von Dawi###########
##########github.com/yourdawi##########
##############yourdawi.de##############
#######################################
#######################################
]]
--Interior means ID|X|Y|Z
if useHouseSystem == true then
------------------------------------------------------------
CHouseManager = {}

function CHouseManager:constructor()
	local qh = DB:query("Select * From house")
	for i,v in ipairs(qh) do
    if v["Owner"] == "#free" then
      local model = 1273
    else
      local model = 1272
    end
		local house = createPickup(v["X"], v["Y"], v["Z"],3,model,0)
		enew(house, CHouse, v["ID"], v["Owner"], v["X"], v["Y"], v["Z"],v["Interior"],v["Price"])
	end
	outputDebugString("Es wurden "..#Houses.." Häuser gefunden",3)
end

HouseManager = new(CHouseManager)
------------------------------------------------------------------------------
end
