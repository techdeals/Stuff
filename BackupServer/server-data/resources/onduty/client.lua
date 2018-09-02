local policeloadout = {
	{["i"] = 1, ["weapon"] = "WEAPON_COMBATPISTOL"},
	{["i"] = 2, ["weapon"] = "WEAPON_STUNGUN"},
	{["i"] = 3, ["weapon"] = "WEAPON_NIGHTSTICK"},
	{["i"] = 4, ["weapon"] = "WEAPON_FLASHLIGHT"}
}

RegisterNetEvent("FSRP:OnDuty")
AddEventHandler(
	"FSRP:OnDuty",
	function()
		RemoveAllPedWeapons(GetPlayerPed(-1))
		local model = GetHashKey("csb_mweather")
		RequestModel(model)
		while not HasModelLoaded(model) do
			RequestModel(model)
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
		SetModelAsNoLongerNeeded(model)
		chatPrint("You are now On Duty, Join Discord Police Comms Voice Channel or you will be kicked.\nVehicle Spawn Code: CP1")

		local playerPed = GetPlayerPed(-1)
		for k, v in ipairs(policeloadout) do
			Citizen.Trace("Weapon: " .. v.i .. " " .. v.weapon .. " Given to " .. playerPed)
			GiveWeaponToPed(playerPed, GetHashKey(v.weapon), 9999, true, true)
		end
	end
)

RegisterNetEvent("FSRP:OffDuty")
AddEventHandler(
	"FSRP:OffDuty",
	function()
		RemoveAllPedWeapons(GetPlayerPed(-1))
		local model = GetHashKey("u_m_m_doa_01")
		RequestModel(model)
		while not HasModelLoaded(model) do
			RequestModel(model)
			Citizen.Wait(0)
		end
		SetPlayerModel(PlayerId(), model)
		SetModelAsNoLongerNeeded(model)
		chatPrint("You are now Off Duty")
	end
)

function chatPrint(msg)
	TriggerEvent("chatMessage", "SYSTEM", {0, 0, 0}, msg)
end
