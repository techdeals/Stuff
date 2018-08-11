AddEventHandler('chatMessage', function(source, name, message)
  if message == nil or message == '' or message:sub(1, 1) == '/' then return FALSE end
  PerformHttpRequest('https://discordapp.com/api/webhooks/477696126422745099/jpfHnnQip6Y11H96s3Mp429TrOElAoWDp2AA1Cqm6t2nbIyA8O1GbKoxgJWXONBMPhn3', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end)
function sendToDiscord(name, message)
  if message == nil or message == '' or message:sub(1, 1) == '/' then return FALSE end
  PerformHttpRequest('https://discordapp.com/api/webhooks/477696126422745099/jpfHnnQip6Y11H96s3Mp429TrOElAoWDp2AA1Cqm6t2nbIyA8O1GbKoxgJWXONBMPhn3', function(err, text, headers) end, 'POST', json.encode({username = name, content = message}), { ['Content-Type'] = 'application/json' })
end
AddEventHandler('playerConnecting', function()
  sendToDiscord('SYSTEM', GetPlayerName(source) .. 'Joined. ')
end)

AddEventHandler('playerDropped', function(reason)
  sendToDiscord('SYSTEM', GetPlayerName(source) .. ' Left. (' .. reason .. ')')
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

    PerformHttpRequest("https://discordapp.com/api/webhooks/477695583444926464/zceQgQjj_azKJJycyuMYSeqtfFmto5pudfJg2fSXI-Icg9KknYH8d3_3PngjMCXlXs00", function(err, text, headers)
    end, 'POST', json.encode({embeds = embeds}), { ['Content-Type'] = 'application/json' })
end)
