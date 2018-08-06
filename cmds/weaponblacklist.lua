-- CONFIG --

-- Blacklisted weapons
weaponblacklist = {
	"WEAPON_MINIGUN",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_SMG",
	"WEAPON_ASSAULTSMG",
	"WEAPON_COMBATPDW",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_GRENDADELAUNCHER",
	"WEAPON_RPG",
	"WEAPON_RAILGUN",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_STICKYBOMB",
	"WEAPON_PIPEBOMB",
	"WEAPON_PROXMINE",
	"WEAPON_SNOWBALL",
	"WEAPON_POOLCUE",
	"WEAPON_PISTON_MK2",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_FIREWORK",
	"WEAPON_GRENADE",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_REVOLVER_MK2",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_STINGER",
}
-- Don't allow any weapons at all (overrides the blacklist)
disableallweapons = false

-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(1)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			nothing, weapon = GetCurrentPedWeapon(playerPed, true)

			if disableallweapons then
				RemoveAllPedWeapons(playerPed, true)
			else
				if isWeaponBlacklisted(weapon) then
					RemoveWeaponFromPed(playerPed, weapon)
				end
			end
		end
	end
end)

function isWeaponBlacklisted(model)
	for _, blacklistedWeapon in pairs(weaponblacklist) do
		if model == GetHashKey(blacklistedWeapon) then
			return true
		end
	end

	return false
end