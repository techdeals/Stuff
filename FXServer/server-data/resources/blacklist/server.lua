blacklist = {
"steam:110000112b7292a",


}


AddEventHandler('playerConnecting', function(playerName, setKickReason)
local numIds = GetNumPlayerIdentifiers(source)
	for i,blacklisted in ipairs(blacklist) do
		for i = 0, numIds-1 do
			if blacklisted == GetPlayerIdentifier(source,i) then
				setKickReason('You Have Been Banned From LossRP Please Submit An Appeal At LossRP.com.')
				print("Connection Refused, Blacklisted!\n")
				CancelEvent()
			end
		end
	end
end)