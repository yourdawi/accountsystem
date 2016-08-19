CVehicleManager = {}

function CVehicleManager:constructor()
	local qh = DB:query("Select * From vehicles")
	for i,v in ipairs(qh) do
    local int,dim,x,y,z,rx,ry,rz = gettok(v["Koords"],1,"|"),gettok(v["Koords"],2,"|"),gettok(v["Koords"],3,"|"),gettok(v["Koords"],4,"|"),gettok(v["Koords"],5,"|"),gettok(v["Koords"],6,"|"),gettok(v["Koords"],7,"|"),gettok(v["Koords"],8,"|")
		local vehicle = createVehicle(v["Model"], x,y,z,rx,ry,rz,v["Numberplate"])
		setVehicleLocked(vehicle,true)
    vehicle:setDimension(dim)
    vehicle:setInterior(int)
		enew(vehicle, CVehicle, v["ID"], v["Model"], v["Owner"], v["Koords"], v["Numberplate"])
	end
	outputDebugString("Es wurden "..#Vehicles.." Vehicles gefunden",3)
end

VehicleManager = new(CVehicleManager)
