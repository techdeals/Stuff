CurrentAOP = "San"
CurrentAOP2 = "Andreas"

local allowed =  
{
	"steam:110000131e96753",

}		

AddEventHandler('chatMessage', function(source, name, msg)
    local identifier = GetPlayerIdentifiers(source)[1]
    local args = stringsplit(msg, " ")
    if args[1] == "/aop" then

    if tablelength(args) > 2 then
    CancelEvent()
    if checkAllowed(identifier) then
    CurrentAOP = args[2]
    CurrentAOP2 = args[3]
    TriggerEvent('aop:requestSync')
    TriggerClientEvent('chatMessage', -1, '^1[LossRP]', {255, 255, 255}, " ^7AOP has been changed to ^1" .. CurrentAOP .. " " .. CurrentAOP2 .. '^7.\n Please finish your current RP and move.')
    else
    TriggerClientEvent('chatMessage', -1, '', {255, 255, 255}, '^7Incorrect syntax.')
    end
    end
    end
end)

function checkAllowed(id) -- function checkAllowed(). id is just a returned value (forgot what the actual word is xD)
	for k, v in pairs(allowed) do -- for repeat to go thru the allowed table. k = key and v = value
		if id == v then -- checks if id is equal to v
			print('Returns true')
			return true -- returns true if id is equal to v
		end
	end
	
	return false -- in case nothing is in the array, just a fail safe so it returns false basically
end

RegisterServerEvent('aop:requestSync')
AddEventHandler('aop:requestSync', function()

    TriggerClientEvent('aop:updateAOP', -1, CurrentAOP, CurrentAOP2)
end)

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