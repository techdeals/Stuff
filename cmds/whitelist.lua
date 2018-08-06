whitelist = {
	"steam:1100001107f2876",
	"steam:1100001089b25be",
	"steam:110000131e96753",
}
RegisterServerEvent('white')
AddEventHandler('white', function()
	local numIds = GetPlayerIdentifiers(source)
	for i,admin in ipairs(whitelist) do
		for i,theId in ipairs(numIds) do
			if admin == theId then -- is the player an admin?
				TriggerClientEvent("checkwhitelist", source, "gg")
				print('An admin joined')
			end
		end
	end
end)