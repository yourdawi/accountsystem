addCommandHandler("createdevcar",
function(player,cmd,model)
  if model then
local x,y,z = getElementPosition(player)
local rx,ry,rz = getElementRotation(player)
local int = player:getInterior()
local dim = player:getDimension()
local vehicle = player:addPlayerCar(model,x,y,z,rx,ry,rz,int,dim,player:getName())
warpPedIntoVehicle(player,vehicle)
  else
      outputChatBox("Kein Model angegeben!",player,255,0,0)
  end
end)
