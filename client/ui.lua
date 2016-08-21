--[[
#######################################
#######################################
###########Erstellt von Dawi###########
##########github.com/yourdawi##########
##############yourdawi.de##############
#######################################
#######################################
]]
local sx,sy = guiGetScreenSize()
local sxx,syy = 1280,720
---TACHO

local Fontdigital = dxCreateFont("res/digital-7.ttf", 10)
---------------------------------
if UseVehicleSystem == true then
----------------------------------
addEventHandler("onClientVehicleEnter",getRootElement(),
function(player,seat)
  if player == localPlayer and seat == 0 then
    addEventHandler("onClientRender",root,renderTacho)
  end
end)

addEventHandler("onClientVehicleExit",getRootElement(),
function(player,seat)
  if player == localPlayer and seat == 0 then
    removeEventHandler("onClientRender",root,renderTacho)
  end
end)

    function renderTacho()
      local vehicleSpeed = getElementSpeed(getPedOccupiedVehicle(localPlayer),1)
    --  local handlingTable = getVehicleHandling ( getPedOccupiedVehicle(localPlayer) )
      local currentGear = getVehicleCurrentGear(getPedOccupiedVehicle(localPlayer))
        if currentGear == 0 then
          currentGear = "R"
        end
        dxDrawRectangle(1083/sxx*sx, 718/syy*sy, 54/sxx*sx, (-vehicleSpeed)/syy*sy, tocolor(78, 117, 176, 255), false) --Speed
        --dxDrawRectangle(1152, 718, 54, NULL, tocolor(253, 0, 0, 255), false)    --engineAcceleration
        dxDrawText(math.round(vehicleSpeed).."\nKM/H", 1084/sxx*sx, (718-vehicleSpeed)/syy*sy, 1137/sxx*sx, 15/syy*sy, tocolor(255, 255, 255, 255), 1.00/sxx*sx, Fontdigital, "center", "top", false, false, false, false, false)
        dxDrawText(currentGear, 1084/sxx*sx, ((718-vehicleSpeed)-3)/syy*sy, 1137/sxx*sx, 15/syy*sy, tocolor(255, 255, 255, 255), 1.00/sxx*sx, Fontdigital, "left", "top", false, false, false, false, false)
    end
------------------------------------
end
------------------------------------
