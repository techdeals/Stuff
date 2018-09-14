--[[
    Object Spawner by DementedDude aka Trap 
    Ped restriction method by Xander1992
]] --

pedsList = {
	--"s_m_y_cop_01",
	--"s_f_y_cop_01",
	"s_m_y_hwaycop_01",
	"s_m_y_sheriff_01",
	"s_f_y_sheriff_01",
	--"s_m_y_ranger_01",
	--"s_f_y_ranger_01"
	 "s_m_y_swat_01",
	"gangcop",
	"mp_m_freemode_01",
	"csb_mweather",
	"s_m_y_fireman_01",
	"s_m_m_paramedic_01"
	
	
	
}

function SpawnObject(objectname)
    local Player = GetPlayerPed(-1)
    local x, y, z = table.unpack(GetEntityCoords(Player, true))
    local heading = GetEntityHeading(Player)
   
    RequestModel(objectname)

    while not HasModelLoaded(objectname) do
	    Citizen.Wait(1)
    end

    if CheckPedRestriction(GetLocalPed(), pedsList) then
        local obj = CreateObject(GetHashKey(objectname), x, y, z-1.90, true, true, true)
	    PlaceObjectOnGroundProperly(obj)
        SetEntityHeading(obj, heading)
        FreezeEntityPosition(obj, true)
        TriggerEvent("chatMessage", "", {255,255,255}, "^2Object Spawned.")
    else
       TriggerEvent("chatMessage", "", {255,255,255}, "^1You are not allowed to use this command.")
    end

end

RegisterCommand('barrier2', function(source, args)
    --[ Spawns Police Barrier ]
    SpawnObject('prop_barrier_work05')
end, false)

RegisterCommand('barrier', function(source, args)
    --[ Spawns Work Barrier ]
    SpawnObject('prop_mp_barrier_02b')
end, false)

RegisterCommand('cone', function(source, args)
    --[ Spawn Traffic Cone ]
    SpawnObject('prop_mp_cone_01')
end, false)

RegisterCommand('ro', function(source, args)
    --[ Removes Objects (Standing Close) ]
    if CheckPedRestriction(GetLocalPed(), pedsList) then
        DeleteOBJ('prop_barrier_work05')
        DeleteOBJ('prop_mp_barrier_02b')
        DeleteOBJ('prop_mp_cone_01')
        TriggerEvent("chatMessage", "", {255,255,255}, "^3Objects(s) deleted.")
    else
        TriggerEvent("chatMessage", "", {255,255,255}, "^1You are not allowed to use this command.")
    end

end, false)

function DeleteOBJ(theobject)
    --[ Deletes The Object ]
    local object = GetHashKey(theobject)
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    if DoesObjectOfTypeExistAtCoords(x, y, z, 0.9, object, true) then
        local obj = GetClosestObjectOfType(x, y, z, 0.9, object, false, false, false)
        DeleteObject(obj)
    end
end

function CheckPedRestriction(ped, PedList)
    --[ Checks Player Ped Skin ]
	for i = 1, #PedList do
		if GetHashKey(PedList[i]) == GetEntityModel(ped) then
			return true
		end
	end
    return false
end

function GetLocalPed()
    --[ Grabs The Player Ped (ID) ]
    return GetPlayerPed(PlayerId())
end
