--Coded by timnboys
 
AddEventHandler("chatMessage",function(source,Name,Msg)
    cm = stringsplit(Msg, " ")
    if(cm[1] == "/kick") then
    CancelEvent()
            local adminidentifiers = GetPlayerIdentifiers(source)
    for i = 1, #adminidentifiers do
        local steamidadmin = string.sub(adminidentifiers[i], 4)
        local identifiers = GetPlayerIdentifiers(cm[2])
    for i = 1, #identifiers do
        local steamid = string.sub(identifiers[i], 4)
--local reflection = clr.System.Reflection
--print("Loaded Reflection Variable...Now Load DLL")
--local assembly = reflection.Assembly.LoadFrom('resources/ban/lib/FiveRebornHttp.dll')
--print("Loaded Reflection Assembly DLL!")
--local fiveRebornHttp = clr.FiveRebornHttp.HttpHandler
--print("FiveRebornHttp DLL Fully Loaded!")
-- Gets content of page from http://pastebin.com/raw/8SK5pT0e
 
local url = "http(s)://yoururl.com/checkadminstatus.php?steamid="..steamidadmin
local method = "get"
-- local data = ""
--local headers = { }
--local mediaType = ""
--print("About to do API Call!")
local result = exports.httpcallclient:statuscallreturn(url, method)
--print("Finished API Call Succesfully!")
print("Result:"..tostring(result))
        if tostring(result) == "403" then
            print('Player Not Admin'..GetPlayerName(source))
            TriggerClientEvent('chatMessage', -1, 'Kick System', { 0, 0, 0 }, GetPlayerName(source) ..' Not Admin'..'Command will Not Run!')
        else
        print("Player Kicked"..steamid.."by user:"..GetPlayerName(source))
		TriggerClientEvent('chatMessage', -1, 'Kick System', { 0, 0, 0 }, GetPlayerName(source) ..' Kicked IP'..steamid)
        DropPlayer(tonumber(cm[2]), "You got Kicked.")
end
end
end
end
end)
print('Kick Command by timnboys (LUA, FiveReborn). Type /kick ID in chat (T) to kickS a player with the ID (if ID is not entered, affects self).')
function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
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