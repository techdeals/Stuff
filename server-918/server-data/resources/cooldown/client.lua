local cooldown = 0
local ispriority = false
local ishold = false

RegisterCommand("+resetpcd", function()
    TriggerServerEvent("cancelcooldown")
end, false)

RegisterNetEvent('UpdateCooldown')
AddEventHandler('UpdateCooldown', function(newCooldown)
    cooldown = newCooldown
end)

RegisterNetEvent('UpdatePriority')
AddEventHandler('UpdatePriority', function(newispriority)
    ispriority = newispriority
end)

RegisterNetEvent('UpdateHold')
AddEventHandler('UpdateHold', function(newishold)
    ishold = newishold
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if ishold == true then
			DrawText2("Peacetime Cooldown: ~b~Priorities Are On Hold")
		elseif ispriority == false then
			DrawText2("~o~Peacetime Cooldown: ~r~".. cooldown .." ~w~Mins")
		elseif ispriority == true then
			DrawText2("Peacetime Cooldown: ~g~Priority In Progress")
		end
	end
end)

	function DrawText2(text)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.0, 0.40)
        SetTextDropshadow(1, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(text)
        --DrawText(0.200, 0.0002)
		DrawText(0.174, 0.889)
    end