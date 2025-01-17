
local rank = 0

local Founder = {"steam:110000131e96753", "ip:127.0.0.1",
                 "steam:"
                                        }
local ChiefAdmin = {"steam:", "ip:"}
local Admin = {"steam:11000011babb636","steam:1100001048b0d98","steam:11000013289785c","steam:11000013356604","steam:11000010bc64f78","steam:110000133566040","steam:", "ip:"}             
local Fire = {"steam:", "ip:"}
local EMT = {"steam:", "ip:"}
local Sheriff = {"steam:11000011b250e4f", "ip:"}
local Moderator = {"steam:","steam:11000010ff7c5f8","steam:110000109902fac","steam:11000011530fdae","steam:110000112589c54","steam:110000135419f17", "ip:"}
local HP = {"steam:110000114112052","steam:11000011530fdae", "ip:"}
local PD = {"steam:", "ip:"}      
local Test = {"steam:", "ip:"}
local ScriptCreator = {"steam:110000135779709", "ip:"}

AddEventHandler(
    "chatMessage",
    function(source, name, message)
        local player = GetPlayerIdentifiers(source)[1]
        local args = stringsplit(message, " ")
        CancelEvent()
        if string.find(args[1], "/") then
            local cmd = args[1]
            if has_value(Founder, player) then
                rank = 4
            elseif has_value(Admin, player) then
                rank = 4
            elseif has_value(ChiefAdmin, player) then
                rank = 4
            elseif has_value(Moderator, player) then
                rank = 3
            elseif has_value(Sheriff, player) then
                rank = 2
            elseif has_value(HP, player) then
                rank = 2
            elseif has_value(PD, player) then
                rank = 2
            elseif has_value(Fire, player) then
                rank = 1
            elseif has_value(EMT, player) then
                rank = 1
            elseif has_value(Test, player) then
            elseif has_value(ScriptCreator, player) then
            else
            end

            if cmd == "/cuff" and rank > 1 then
                if tablelength(args) > 1 then
                    local tPID = tonumber(args[2])
                    TriggerClientEvent("Handcuff", tPID)
                end
            end
        
            if cmd == "/hu" then
                TriggerClientEvent("Handsup", source)
            end

            if cmd == "/aop" and rank > 2 then
                if tablelength(args) > 2 then
                CurrentAOP = args[2]
                CurrentAOP2 = args[3]
                TriggerEvent('aop:requestSync')
                TriggerClientEvent('chatMessage', -1, '^1[!]', {255, 255, 255}, " ^7AOP has been changed to ^1" .. CurrentAOP .. " " .. CurrentAOP2 .. '^7.\n Please finish your current RP and move.')
                else
                TriggerClientEvent('chatMessage', -1, '', {255, 255, 255}, '^7Incorrect syntax.')
                end
                end
        else
            if has_value(Founder, player) then
                TriggerClientEvent("chatMessage", -1, "Founder | " .. name, {255, 0, 0}, message)
            elseif has_value(Admin, player) then
                TriggerClientEvent("chatMessage", -1, "Admin | " .. name, {255, 0, 0}, message)
            elseif has_value(ChiefAdmin, player) then
                TriggerClientEvent("chatMessage", -1, "Chief Admin | " .. name, {36, 127, 50}, message)
            elseif has_value(Fire, player) then
                TriggerClientEvent("chatMessage", -1, "Fire | " .. name, {0, 0, 255}, message)
            elseif has_value(EMT, player) then
                TriggerClientEvent("chatMessage", -1, "EMT | " .. name, {0, 0, 255}, message)
            elseif has_value(Sheriff, player) then
                TriggerClientEvent("chatMessage", -1, "New Orleans PD | " .. name, {0, 0, 255}, message)
            elseif has_value(Moderator, player) then
                TriggerClientEvent("chatMessage", -1, "Moderator | " .. name, {0, 255, 247}, message)
            elseif has_value(HP, player) then
                TriggerClientEvent("chatMessage", -1, "State Trooper | " .. name, {222, 0, 255}, message)
            elseif has_value(Test, player) then
                TriggerClientEvent("chatMessage", -1, "LossRP Support Team |  " .. name, {222, 0, 255}, message)
            elseif has_value(ScriptCreator, player) then
                TriggerClientEvent("chatMessage", -1, "LossRP Developer |  " .. name, {66, 92, 163}, message)
            else
                TriggerClientEvent("chatMessage", -1, "Player | " .. name, {235, 214, 51}, message)
            end
        end
    end
)

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

function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end