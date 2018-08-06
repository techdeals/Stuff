RegisterServerEvent('manlet:leobk1')
AddEventHandler('manlet:leobk1', function(name, street)
    TriggerClientEvent('chatMessage', -1, 'Police Radio', {28, 107, 255}, "^2Officer "..name.." ^7is requesting backup on ^2"..street..". ^7Available units are to respond ^1Code 1!")
end)

RegisterServerEvent('manlet:leobk2')
AddEventHandler('manlet:leobk2', function(name, street)
    TriggerClientEvent('chatMessage', -1, 'Police Radio', {28, 107, 255}, "^2Officer "..name.." ^7is requesting backup on ^2"..street..". ^7Available units are to respond ^1Code 2!")
end)

RegisterServerEvent('manlet:leobk3')
AddEventHandler('manlet:leobk3', function(name, street)
    TriggerClientEvent('chatMessage', -1, 'Police Radio', {28, 107, 255}, "^2Officer "..name.." ^7is requesting backup on ^2"..street..". ^7Available units are to respond ^1Code 3!")
end)

RegisterServerEvent('manlet:leobk4')
AddEventHandler('manlet:leobk4', function(name, street)
    TriggerClientEvent('chatMessage', -1, 'Police Radio', {28, 107, 255}, "^2Officer "..name.." ^7no longer requries backup!")
end)


AddEventHandler('chatMessage', function(source, name, msg)
	sm = stringsplit(msg, " ");
	if sm[1] == "/ooc" then
		CancelEvent()
		TriggerClientEvent('chatMessage', -1, "^6OOC | ^7" .. name, { 128, 128, 128 }, string.sub(msg,5))
	end

	if sm[1] == "/me" then
		CancelEvent()
		TriggerClientEvent('chatMessage', -1, "^3Me | ^7" .. name, { 128, 128, 128 }, string.sub(msg,5))
	end

	if sm[1] == "/do" then
		CancelEvent()
		TriggerClientEvent('chatMessage', -1, "^2Do | ^7" .. name, { 128, 128, 128 }, string.sub(msg,5))
	end

	if sm[1] == "/news" then
        CancelEvent()
        TriggerClientEvent("chatMessage", -1, "^3News", {255, 255, 255}, string.sub(msg,6))
    end

    if sm[1] == "/ad" then
        CancelEvent()
        TriggerClientEvent("chatMessage", -1, "^2AD | " .. name, {255, 255, 255}, string.sub(msg,5))
    end
	
	if sm[1] == "/twt" then
        CancelEvent()
        TriggerClientEvent("chatMessage", -1, "^5Twitter | " .. name, {255, 255, 255}, string.sub(msg,6))
    end
	
	if sm[1] == "/134567announce" then
        CancelEvent()
   	   TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n STAFF ANNOUNCEMENT \n "..string.sub(msg,16).." \n ——————————————————————", {239, 0, 0})     
    end
end)

CurrentAOP = "San"
CurrentAOP2 = "Andreas"

AddEventHandler('chatMessage', function(source, name, msg)
	local args = stringsplit(msg, " ")
	if args[1] == "/134567aop" then
	if tablelength(args) > 2 then
	CancelEvent()
	CurrentAOP = args[2]
	CurrentAOP2 = args[3]
	TriggerEvent('aop:requestSync')
	TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n RP AREA IS NOW : " .. CurrentAOP .. " " .. CurrentAOP2 .. "\n Please Finish Your Current RP and Move. \n ——————————————————————", {239, 0, 0})
	elseif tablelength(args) < 2 then
	CurrentAOP = "San"
	CurrentAOP2 = "Andreas"
    end
	end
end)


AddEventHandler('chatMessage', function(Source, Name, Msg)
    args = stringsplit(Msg, " ")
    CancelEvent()
    if string.find(args[1], "/") then
        local cmd = args[1]
        table.remove(args, 1)
	else
		TriggerClientEvent('chatMessage', -1, "^6OOC | ^7" ..Name.. " ", { 128, 128, 128 }, Msg)
	end
end)


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


-- Credits to @Havoc , @Flatracer , @Briglair , and @WolfKnight	on forum.fivem.net for helping me create this
-- Thanks to Ethan Rubinacci and Mark Curry
-- Lots of thanks to @Wolfknight for help with the admin feature
-- Special thanks to @Flatracer

-- Created by Murtaza. If you need help, msg me. The comments are there for people to learn.

-- SERVERSIDED

------ CONFIG ------

local everyoneAllowed = true -- If true, everyone is allowed and you do not need to add steam/ip identifiers. If false, you need to add steam/ip identifiers so they can use the command.

local allowed =  
{
	"steam:000000000000000", -- Enter your steam ids and ips as such. DO NOT forget the commas and do not add a comma at the end.
	"steam:000000000000001",
	"ip:192.168.1.1",
	"ip:192.168.1.2",
	"steam:000000000000003"
}	

------ Code. DO NOT TOUCH ------

AddEventHandler('chatMessage', function(source, n, msg) -- Checks messages
	local Message = string.lower(msg) -- Lowers entire msg to lower case (in case user has Caps Lock or something)
	if Message == "/delgun on" then -- Checks if the message says this
		CancelEvent() -- Stops message from going thru
		local identifier = GetPlayerIdentifiers(source)[1] -- Gets identifier (steam id or ip of player)
		if everyoneAllowed == true then -- Checks if the variable in the config is true
			TriggerClientEvent('ObjectDeleteGunOn', source) -- Triggers ObjectDeleteGunOn client event
		else -- if not
			if checkAllowed(identifier) then -- Refers to function checkAllowed() (look below) with the variable identifier
				TriggerClientEvent('ObjectDeleteGunOn', source) -- Triggers ObjectDeleteGunOn client event
			else -- if not
				TriggerClientEvent('noPermissions', source) -- Triggers noPermissions client event
			end
		end
	elseif Message == "/delgun off" then -- Checks if message says /delobjgun off
		CancelEvent()  -- Stops message from going thru
		TriggerClientEvent('ObjectDeleteGunOff', source) -- Triggers ObjectDeleteGunOff client event
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

AddEventHandler('chatMessage', function(source, n, message)
    command = stringsplit(message, " ")

    if(command[1] == "/tow") then
		CancelEvent()
		TriggerClientEvent("pv:tow", source)
	end
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


--- ADD STEAM ID OR LICENSE FROM YOUR ADMINS!
local admins = {
    'steam:110000131e96753', -- OfficerScentral
    'steam:1100001089b25be', -- Dust
    'steam:11000010e4562aa', -- Peter
    'steam:11000013201d431', -- Darkwing
    'steam:110000131f7eb1e', -- Tristan
	'steam:110000119b5832c', -- Stanley
	'steam:11000011716b5da', -- Tyrone
}

function isAdmin(player)
    local allowed = false
    for i,id in ipairs(admins) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end


AddEventHandler('chatMessage', function(source, color, msg)
	cm = stringsplit(msg, " ")
	if cm[1] == "/reply" or cm[1] == "/r" then
		CancelEvent()
		if tablelength(cm) > 1 then
			local tPID = tonumber(cm[2])
			local names2 = GetPlayerName(tPID)
			local names3 = GetPlayerName(source)
			local textmsg = ""
			for i=1, #cm do
				if i ~= 1 and i ~= 2 then
					textmsg = (textmsg .. " " .. tostring(cm[i]))
				end
			end
		    if isAdmin(source) then
			    TriggerClientEvent('textmsg', tPID, source, textmsg, names2, names3)
			    TriggerClientEvent('textsent', source, tPID, names2)
		    else
			    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insuficient Premissions!")
			end
		end
	end	
	
	if cm[1] == "/report" then
		CancelEvent()
		if tablelength(cm) > 1 then
			local names1 = GetPlayerName(source)
			local textmsg = ""
			for i=1, #cm do
				if i ~= 1 then
					textmsg = (textmsg .. " " .. tostring(cm[i]))
				end
			end
		    TriggerClientEvent("sendReport", -1, source, names1, textmsg)
		end
	end	
	
end)

RegisterServerEvent('checkadmin')
AddEventHandler('checkadmin', function(n1, tmsg, ii)
	local id = source
	if isAdmin(id) then
		TriggerClientEvent("sendReportToAllAdmins", -1, source, n1, tostring(tmsg), ii)
	else
	end
end)

RegisterServerEvent('checkadmin2')
AddEventHandler('checkadmin2', function(n1, tmsg, ii)
	local id = source
	if isAdmin(id) then
		TriggerEvent("cancelcooldown")
	else
	end
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


-- Config
timermax = 21 -- In minutes. Must be one bigger than the max timer you want (Eg if you want 20 it must be 21)

-- Do not touch
cooldown = 0
ispriority = false
ishold = false

RegisterCommand("priority", function(source, args, raw)
    if isAdmin(source) then
	TriggerEvent("cooldownt")
	end
end, false)


RegisterNetEvent('isPriority')
AddEventHandler('isPriority', function(source, args, raw)
	ispriority = true
	Citizen.Wait(1)
	TriggerClientEvent('UpdatePriority', -1, ispriority)
	TriggerClientEvent('chatMessage', -1, "WARNING", {255, 0, 0}, "^1A priority call is in progress. Please do not interfere, otherwise you will be ^1kicked. ^7All calls are on ^3hold ^7until this one concludes.")
end)

RegisterNetEvent('isOnHold')
AddEventHandler('isOnHold', function(source, args, raw)
	ishold = true
	Citizen.Wait(1)
	TriggerClientEvent('UpdateHold', -1, ishold)
end)

RegisterNetEvent("cooldownt")
AddEventHandler("cooldownt", function()
	if ispriority == true then
		ispriority = false
		TriggerClientEvent('UpdatePriority', -1, ispriority)
	end
	Citizen.Wait(1)
	if ishold == true then
		ishold = false
		TriggerClientEvent('UpdateHold', -1, ishold)
	end
	Citizen.Wait(1)
	if cooldown == 0 then
		cooldown = 0
		cooldown = cooldown + timermax
		TriggerClientEvent('chatMessage', -1, "WARNING", {255, 0, 0}, "^1A priority call was just conducted. ^3All civilians must wait 20 minutes before conducting another one. ^7Failure to abide by this rule will lead to you being ^1kicked.")
		while cooldown > 0 do
			cooldown = cooldown - 1
			TriggerClientEvent('UpdateCooldown', -1, cooldown)
			Citizen.Wait(60000)
		end
	elseif cooldown ~= 0 then
		CancelEvent()
	end
end)

RegisterNetEvent("cancelcooldown")
AddEventHandler("cancelcooldown", function()
	Citizen.Wait(1)
	while cooldown > 0 do
		cooldown = cooldown - 1
		TriggerClientEvent('UpdateCooldown', -1, cooldown)
		Citizen.Wait(100)
	end
	
end)

RegisterCommand("togdispatch", function(source,args,rawCommand)
	if ( activeDispatch == false ) then
		activeDispatch = true
		TriggerEvent('dispatch:requestSync')
		TriggerClientEvent('dispatch:Notify', source, activeDispatch)
		TriggerClientEvent('chatMessage', -1, "\n ^7--\n^1There is now an Active Dispatcher. The /911 command can now ^1no longer be used. ^7Please utilise the ^3Need 911 ^7channel in discord while dispatch is still active. \n^7-- \n", {239, 0, 0})
	elseif ( activeDispatch == true ) then
		activeDispatch = false
		TriggerEvent('dispatch:requestSync')
		TriggerClientEvent('dispatch:Notify', source, activeDispatch)
		TriggerClientEvent("chatMessage", -1, " \n ^7-- \n ^1There is no longer an Active Dispatcher. The /911 command can now ^1 be used again. \n ^7-- \n", {239, 0, 0})     

	end
end, false)	



activeDispatch = false

RegisterServerEvent('dipatch:requestSync')
AddEventHandler('dispatch:requestSync', function()
    TriggerClientEvent('dispatch:update', -1, activeDispatch)
end)


RegisterNetEvent("911")
AddEventHandler("911", function(street, msg)
    name = GetPlayerName(source)
    reason = string.gsub(msg, "911 ", "")
    TriggerClientEvent('chatMessage', -1, "^1911 - Caller ID | " .. name, { 218, 74, 76 }, "^7Location: ^3"..street.."^7 Incident: ^2"..reason)
    local embeds = {
        {
            ["color"] = "16734039",
            ["title"] = name.." called 911!",
            ["description"] = reason,
            ["footer"] = {
                ["text"] = "Location: "..street,
                ["timestamp"] = os.date()
            },
        }
    }

    PerformHttpRequest("https://discordapp.com/api/webhooks/467490836796407812/yg1_2DT5H5iYpWvT2bw4m3gicdZgLPQkeZ9tEcdAEBLl8O2UZJ5tY45qRSaraqLbGtfl", function(err, text, headers)
    end, 'POST', json.encode({embeds = embeds}), { ['Content-Type'] = 'application/json' })
end)