RegisterServerEvent('playerConnecting')
AddEventHandler('playerConnecting', function(name, setCallback)
	local identifiers = GetPlayerIdentifiers(source)
	for i = 1, #identifiers do
		local steamid = string.sub(identifiers[i], 4)
		
local url = "http(s)://yoururl.com/blacklist.php?steamidvar="..steamid
local method = "get"
local data = ""
--print("About to do API Call!")
local result = exports.httpcallclient:statuscallreturn(url, method)
--print("Finished API Call Succesfully!")
print("Result:"..tostring(result))
		if tostring(result) == "403" then 
			print('Player that is banned tried to join'..ip)
			setCallback("You are Banned from Your Community")
			CancelEvent()
		end
end
end)