local holdingsign = false
local signmodel = "prop_beggers_sign_01"
local sign_net = nil

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

RegisterCommand('beg', function(source, args)

	local ad1 = "amb@world_human_bum_freeway@male@base"
	local ad4 = "amb@world_human_drinking@beer@male@exit"
	local ad1base = "base"
	local player = GetPlayerPed( -1 )
	local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
    local signspawned = CreateObject(GetHashKey(signmodel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
	local netid = ObjToNet(signspawned)
	
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 											---------------------If playing then cancel
		loadAnimDict( "amb@world_human_bum_freeway@male@base" )
		loadAnimDict( "amb@world_human_bum_freeway@male@idle_a" )
		loadAnimDict( "amb@world_human_bum_freeway@male@idle_b" )
		RequestModel(GetHashKey(signmodel))
		    if ( IsEntityPlayingAnim( player, "amb@world_human_bum_freeway@male@base", "base", 3 ) ) then 
				TaskPlayAnim( player, ad4, "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
				Wait (100)
				ClearPedSecondaryTask(GetPlayerPed(-1))
				DetachEntity(NetToObj(sign_net), 1, 1)
				DeleteEntity(NetToObj(sign_net))
				sign_net = nil
				holdingsign = false
			else																				---------------------if not playing, then play
			SetNetworkIdExistsOnAllMachines(netid, true)
			NetworkSetNetworkIdDynamic(netid, true)
			SetNetworkIdCanMigrate(netid, false)																	--- | x,y,z, x rotation, y rotation, z rotation, no idea
			AttachEntityToEntity(signspawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), -0.005, 0.0, 0.0, 360.0, 360.0, 0.0, 1, 1, 0, 1, 0, 1)
			sign_net = netid
			holdingsign = true
			TaskPlayAnim( player, ad1, "base", 8.0, 1.0, -1, 49, 0, 0, 0, 0  )
			Wait (1000)
		end     
    end
end, false )

-- Citizen.CreateThread(function()															---------------disables movement
-- 	while true do
-- 		Citizen.Wait(0)
-- 		if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "amb@world_human_bum_freeway@male@base", "base", 3) then
-- 			DisableControlAction(1, 140, true)
-- 			DisableControlAction(1, 141, true)
-- 			DisableControlAction(1, 142, true)
-- 			DisableControlAction(0,21,true)
-- 		end
-- 	end
-- end)