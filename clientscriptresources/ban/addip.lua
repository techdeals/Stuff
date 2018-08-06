--Coded by timnboys

AddEventHandler("chatMessage",function(source,Name,Msg)
	if Msg:sub(1,6) == "/addip" then
	for i = 1, #adminidentifiers do
		local ipadmin = string.sub(adminidentifiers[i], 4)
--function options steamid or ip depending on which one you are adding
local function12 = tostring(Msg:sub(5))
local ip = tostring(Msg:sub(5))
local url = "http(s)://yoururl.com/addtowhitelist.php?function="..function12.."&ip="..ip.."&callinguser="..ipadmin
local method = "get"
--print("About to do API Call!")
local result = exports.httpcallclient:statuscallreturn(url, method)
--print("Finished API Call Succesfully!")
print("Result:"..tostring(result))
		if tostring(result) == "403" then 
			print('Player Not Admin'..source)
			TriggerClientEvent('chatMessage', -1, 'Whitelist System', { 0, 0, 0 }, GetPlayerName(source) ..' Not Admin'..'Command will Not Run!')
		else
		print("Player Added to Whitelist"..ip.."by user:"..GetPlayerName(source))
		TriggerClientEvent('chatMessage', -1, 'Whitelist System', { 0, 0, 0 }, GetPlayerName(source) ..' Added IP to Whitelist'..ip)
		CancelEvent()
end
end
end
end)
print('AddIPToWhitelist Command by timnboys (LUA, FiveReborn). Type /addip ip in chat (T) to add a player with the IP to the whitelist (if IP is not entered, it will not work! IP argument is required!).')
function stringsplit(self, delimiter)
  local a = self:Split(delimiter)
  local t = {}

  for i = 0, #a - 1 do
     table.insert(t, a[i])
  end

  return t
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
