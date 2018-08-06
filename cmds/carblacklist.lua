-- CONFIG --

-- Blacklisted vehicle models
carblacklist = {
		"AMBULANCE",		
		"FBI",		
		"FBI2",				
		"FIRETRUK",				
		"POLICE",			
		"POLICE2",		
		"POLICE3",		
		"POLICE4",		
		"POLICEOLD1",		
		"POLICEOLD2",		
		"POLICET",	
		"PRANGER",		
		"RIOT",		
		"SHERIFF",		
		"SHERIFF2",		
		"APC",				
		"BLIMP",				
		"RHINO",
        "BLIMP",
        "BLIMP2",
        "BUZZARD",
        "BUZZARD2",
        "CABLECAR",
        "CARGOBOB",
        "CARGOBOB2",
        "CARGOBOB3",
        "CARGOBOB4",
        "CARGOPLANE",
        "FROGGER",
        "FROGGER2",
        "HYDRA",
        "LAZER",
        "BALLER5",
        "BALLER6",
        "XLS2",
        "TECHNICAL",	
        "TECHNICAL2",
        "TECHNICAL3",
        "DUNE2",
        "DUNE3",
        "DUNE4",
        "DUNE5",
        "MONSTER",
        "NIGHTSHARK",
        "INSURGENT",
        "INSURGENT2",
        "TAMPA3",
        "DUKES2",
        "SHOTARO",
        "OPRESSOR",
        "APC",
        "BARRACKS",
        "BARRACKS2",
        "BARRACKS3",
        "CRUSADER",
        "HALFTRACK",
        "TRAILERSMALL2",
        "CUTTER",
        "DUMP",
        "HANDLER",
        "ANNIHILATOR",
        "PHANTOM2",
        "SUBMERSIBLE",
        "SUBMERSIBLE2",
        "TUG",
        "COG552",
        "COGNOSCENTI2",
        "LIMO2",
        "RALLYTRUCK",
        "ARDENT",
        "PROPTRAILER",
        "FREIGHT",
        "FREIGHTCAR",
        "FREIGHTCONT1",
        "FREIGHTCONT2",
        "FRIEGHTGRAIN",
        "FREIGHTTRAILER",
        "TANKERCAR",
        "TRAILERLARGE",
        "TRAILERS4",
        "SCHAFTER5",
        "SCHAFTER6",
        "CUBAN800",
        "DODO",
        "DUSTER",		
        "JET",		
        "LUXOR",		
        "LUXOR2",
        "MAMMATUS",
        "MILJET",
        "NIMBUS",
        "SHAML",
        "STUNT",
        "TITAN",
        "VELUM",
        "VELUM2",
        "VESTRA",
        "STARLING",		
        "TULA",		
        "AKULA",
        "ALPHAZ1",
        "MAVERICK",		
        "SAVAGE",
        "SKYLIFT",
        "SUPERVOLITO",
        "SUPERVOLITO2",
		"SWIFT",
		"SWIFT2",
		"VALKYRIE",
		"VALKYRIE2",
		"VOLATUS",
		"BULLDOZER",
		"CUTTER",
		"DUMP",
		"HANDLER",
}


-- CODE --
whitelisted = nil
AddEventHandler('playerSpawned', function(spawn)
    TriggerServerEvent('white')
end)
RegisterNetEvent('checkwhitelist')
AddEventHandler('checkwhitelist', function(whitelist) 

print(whitelisted)
whitelisted = whitelist
print('checked')



	end)

Citizen.CreateThread(function()
	while true do
		Wait(1)
		if IsPedInAnyVehicle(GetPlayerPed(-1)) then
		v = GetVehiclePedIsIn(playerPed, false)
		end
		playerPed = GetPlayerPed(-1)
		if whitelisted == nil and playerPed and v then
		if GetPedInVehicleSeat(v, -1) == playerPed then
			checkCar(GetVehiclePedIsIn(playerPed, false))

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