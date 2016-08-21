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
-------------------------------------
CHouse = {}
Houses = {}

function CHouse:constructor(id,owner,x,y,z,interior,price)
  self.ID = id
  self.Owner = owner
  self.X = x
  self.Y = y
  self.Z = z
  self.Interior = interior
  self.Price = price
end

function CHouse:enter(player)
local id,x,y,z = gettok(self.Interior,1,"|"),gettok(self.Interior,2,"|"),gettok(self.Interior,3,"|"),gettok(self.Interior,4,"|"),gettok(self.Interior,5,"|")
  if player:getInterior() == id then
    player:setPosition(x,y,z)
    player:setDimension(self.ID)
  else
    player:setInterior(id,x,y,z)
    player:setDimension(self.ID)
  end
end

function CHouse:leave(player)
player:setInterior(0,self.X,self.Y,self.Z)
player:setDimension(0)
end

------------------------------------------------------
end
-----------------------------------------------------
