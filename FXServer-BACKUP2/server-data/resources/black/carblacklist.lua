-- CONFIG --

-- Blacklisted vehicle models
carblacklist = {
	"RHINO",
	"BUZZARD2",
     "SAVAGE",
	 "VALKYRIE",
	 "AKULA",
	 "INSURGENT",	 
	 "TECHNICAL",
	 "BLIMP",
	 "BLIMP2",
	 "HYDRA",
	 "LAZER",
	 "KURUMA2",
	 "CABLECAR",
	 "FREIGHT",
	 "FREIGHTCAR",
	 "FREIGHTCONT1",
	 "FREIGHTCONT2",
	 "FREIGHTGRAIN",
	 "METROTRAIN",
	 "TANKERCAR",
	 "VALKYRIE2",
	 "VERLIERER2",
	 "PENETRATOR",
	 "PHANTOM2",
	 "RUINER2",
	 "RUINER3",
	 "TECHNICAL2",
	 "INSURGENT3",
	 "NIGHTSHARK",
	 "OPPRESSOR",
	 "PHANTOM3",
	 "TAMPA3",
 	 "TECHNICAL3",
	 "BOMBUSHKA",
	 "MOLOTOK",
	 "NOKOTA",
	 "PYRO",
	 "ROGUE",
	 "VIGILANTE",
	 "AKULA",
	 "CHERNOBOG",
	 "DELUXO",
	 "KHANJALI",
	 "STROMBERG",
	 "THRUSTER",
	 "VOLATOL",
	 "CARACURA",
	 "STRIKEFORCE",
	 "BLIMP3",
	 "SCRAMJET",
	 "OPPRESSOR2",
	 "HUNTER"
	 
	 
}

-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(1)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			checkCar(GetVehiclePedIsIn(playerPed, false))

			x, y, z = table.unpack(GetEntityCoords(playerPed, true))
			for _, blacklistedCar in pairs(carblacklist) do
				checkCar(GetClosestVehicle(x, y, z, 100.0, GetHashKey(blacklistedCar), 70))
			end
		end
	end
end)

function checkCar(car)
	if car then
		carModel = GetEntityModel(car)
		carName = GetDisplayNameFromVehicleModel(carModel)

		if isCarBlacklisted(carModel) then
			_DeleteEntity(car)
			sendForbiddenMessage("")
		end
	end
end

function isCarBlacklisted(model)
	for _, blacklistedCar in pairs(carblacklist) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end

	return false
end