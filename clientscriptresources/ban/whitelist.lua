RegisterServerEvent('playerConnecting')
AddEventHandler('playerConnecting', function(name, setCallback)
	local identifiers = GetPlayerIdentifiers(source)
	for i = 1, #identifiers do
		local steamid = string.sub(identifiers[i], 4)

local url = "http(s)://yoururl.com/whitelist.php?ipval="..steamid
local method = "get"
local result = exports.httpcallclient:statuscallreturn(url, method)
--print("Finished API Call Succesfully!")
print("Result:"..tostring(result))
		if result == 403 then 
			print('Player that is not whitelisted/banned tried to join'..steamid)
			setCallback("You are Not Whitelisted! You must be whitelisted to join! Text to show where to go to get whitelisted at")
			CancelEvent()
		else
		if result == 401 then 
			print('Player that is banned tried to join'..steamid)
			setCallback("You are Banned from Your Community")
			CancelEvent()
		end
end
end
end)