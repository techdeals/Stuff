--Coded by timnboys

AddEventHandler("chatMessage",function(Source,Name,Msg)
	cm = stringsplit(Msg, " ")
	if(cm[1] == "/removeban") then
	CancelEvent()
		local adminidentifiers = GetPlayerIdentifiers(source)
	for i = 1, #adminidentifiers do
		local steamidadmin = string.sub(adminidentifiers[i], 4)
		local identifiers = tonumber(Msg:sub(5))
		local steamid = identifiers

local url = "http(s)://yoururl.com/removefromban.php?steamid="..steamid.."&callinguser="..steamidadmin
local method = "get"
--print("About to do API Call!")
local result = exports.httpcallclient:statuscallreturn(url, method)
--print("Finished API Call Succesfully!")
print("Result:"..tostring(result))
CancelEvent()
		if tostring(result) == "403" then
			print('Player Not Admin'..source)
			TriggerClientEvent('chatMessage', -1, 'Ban System', { 0, 0, 0 }, GetPlayerName(source) ..' Not Admin'..'Command will Not Run!')
		else
		print("Player Removed From Ban List"..steamid.."by user:"..GetPlayerName(source))
		TriggerClientEvent('chatMessage', -1, 'Ban System', { 0, 0, 0 }, GetPlayerName(source) ..' Removed SteamID from Ban DB'..steamid)
	end
end
end
end)
print('RemoveIPFromBan Command by timnboys (LUA, FiveReborn). Type /removeban ip in chat (T) to remove a player with the IP from the ban list (if IP is not entered, it will not work! IP argument is required!).')
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

function makeArgs(cmd)
    args = {}
    for i = 2, #cmd, 1 do
        table.insert(args, cmd[i])
    end
    return args
end