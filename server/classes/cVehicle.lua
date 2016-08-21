--[[
#######################################
#######################################
###########Erstellt von Dawi###########
##########github.com/yourdawi##########
##############yourdawi.de##############
#######################################
#######################################
]]

CVehicle = {}
Vehicles = {}

----EVENTS-----



--Funktionen--

function CVehicle:constructor(id,model,owner,koords,numberplate)
  self.ID = id
  self.Model = model
  self.Owner = owner
  self.Koords = koords
  self.Numberplate = numberplate
  self.Lock = true

  self.eOnClick = bind(CVehicle.click,self)
  addEventHandler("onElementClicked",self,self.eOnClick)
end

function CVehicle:destructor()

end

function CVehicle:click(button,state,player)
  if state == "down" and button == "left" then
  self:lock(player)
end
end

function CVehicle:lock(player)
if player then
  if getPlayerName(player) == self.Owner then
    setVehicleLocked(self,not self.Lock)
    self.Lock = not self.Lock
  else
    outputChatBox("Dies ist nicht dein Fahrzeug!",player,255,0,0)
  end
else
  setVehicleLocked(self,not self.Lock)
  self.Lock = not self.Lock
end
end

function CVehicle:changeEngineState()
  self:setEngineState(not self:getEngineState())
end

function CVehicle:getOwner()
  return self.Owner
end
