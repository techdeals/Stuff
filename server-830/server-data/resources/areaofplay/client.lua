

--CurrentAOP = "Vinewood"
--CurrentAOP2 = "Hills"

CurrentAOP = "Sandy"
CurrentAOP2 = "Shores"

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('aop:requestSync')
end)

RegisterNetEvent('aop:updateAOP')
AddEventHandler('aop:updateAOP', function(newCurrentAOP, newCurrentAOP2)
    CurrentAOP = newCurrentAOP
	CurrentAOP2 = newCurrentAOP2
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DrawText2(0.674, 1.370, 1.0,1.0,0.70, "AOP: ", 255, 50, 50, 150)
		DrawText3(0.703, 1.370, 1.0,1.0,0.70, CurrentAOP .. " " .. CurrentAOP2, 255, 255, 255, 150)
	end
end)

function DrawText2(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function DrawText3(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end