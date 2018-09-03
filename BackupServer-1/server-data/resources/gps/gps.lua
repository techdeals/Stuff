blipActive = false
controlActive = true
gpsdirections = {"arrived / unknown","Turn Around if possible","Follow Route","In %s meters Turn Left","In %s meters Turn Right","In %s meters Go Straight","In %s meters Keep Left","In %s meters Keep Right","In %s meters Join Freeway","In %s meters Exit Freeway"}
dir = 0
ldir = 0
lastdist = 0
lastMessage = "na"
currentVoice = "voice"
gpsvoices = {
	arrived = "Arrive.ogg",
	turnAround = "",
	twohundred = "200meters.ogg",
	fourhundred = "400meters.ogg",
	eighthundred = "800meters.ogg",
	onethousand = "1000meters.ogg",
	onethousand500 = "1500meters.ogg",
	ExitLeft = "ExitLeft.ogg",
	ExitRight = "ExitRight.ogg",
	KeepLeft = "KeepLeft.ogg",
	KeepRight = "KeepRight.ogg",
	Straight = "Straight.ogg",
	TurnLeft = "TurnLeft.ogg",
	TurnRight = "TurnRight.ogg",
}
soundVolume = 0.5
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if IsWaypointActive() then
			local px,py,pz = table.unpack(GetEntityCoords(PlayerPedId()))
			local wp = GetFirstBlipInfoId(8)
			local bx,by,bz = table.unpack(GetBlipInfoIdCoord(wp))

			dir,p5,dist = Citizen.InvokeNative(0xF90125F1F79ECDF8,bx,by,bz,1, Citizen.PointerValueInt(), Citizen.PointerValueFloat(), Citizen.PointerValueFloat() ) -- GenerateDirectionsToCoord(bx,by,bz,1)

			if IsControlJustPressed(0,79) and controlActive then -- C
				controlActive = false
				-- Give the player a wander driving task.
				TaskVehicleDriveToCoordLongrange(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), bx,by,bz,20.0,447, 5.0)

				-- Manually set/override the driving style (after giving the ped a driving task).
				SetDriveTaskDrivingStyle(PlayerPedId(), 447)
			elseif IsControlJustPressed(0,79) and not controlActive then
				veh = GetVehiclePedIsIn(PlayerPedId(),false)
				ClearPedTasks(PlayerPedId())
				ClearPedTasksImmediately(PlayerPedId())
				controlActive = true
				SetPedIntoVehicle(PlayerPedId(),veh,-1)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(1)
		--Citizen.Trace(gpsdirections[dir+1])
		if dir and dist and IsWaypointActive() then
			DrawText2( string.format(gpsdirections[dir+1], round(dist) ) )
			DrawText3( lastMessage )
			if not controlActive then
				DrawText4("Autopilot: yep")
			else
				DrawText4("Autopilot: noup")
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(500)
		--Citizen.Trace(gpsdirections[dir+1])
		if dir and dist and IsWaypointActive() then
			local ldir = dir+1
			lastdist = dist
			local ldist = round(dist)
			if ldir == 1 then
				SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.arrived,transactionVolume = soundVolume})
				lastMessage = "go"
			elseif ldir == 3 then
				--SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.Straight,transactionVolume = soundVolume})
				lastMessage = "straight"
			elseif ldir == 4 then
				if ldist < 480 and ldist > 280 and (lastMessage ~= "distfar" or lastdir ~= dir) then
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.fourhundred,transactionVolume = soundVolume})
					Wait(2000)
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.TurnLeft,transactionVolume = soundVolume})
					lastMessage = "distfar"
				elseif ldist < 40.0 and (lastMessage ~= "now" or lastdir ~= dir) then
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.TurnLeft,transactionVolume = soundVolume})
					lastMessage = "now"
					Wait(1600)
				elseif ldist < 180 and ldist > 80 and (lastMessage ~= "distclose" or lastdir ~= dir) then
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.twohundred,transactionVolume = soundVolume})
					Wait(1800)
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.TurnLeft,transactionVolume = soundVolume})
					lastMessage = "distclose"
					Wait(1600)
				end
			elseif ldir == 5 then
				if ldist < 480 and ldist > 280 and (lastMessage ~= "distfar" or lastdir ~= dir) then
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.fourhundred,transactionVolume = soundVolume})
					Wait(2000)
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.TurnRight,transactionVolume = soundVolume})
					lastMessage = "distfar"
					Wait(1600)
				elseif ldist < 40.0 and (lastMessage ~= "now" or lastdir ~= dir) then
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.TurnRight,transactionVolume = soundVolume})
					lastMessage = "now"
					Wait(1400)
				elseif ldist < 180 and ldist > 80 and (lastMessage ~= "distclose" or lastdir ~= dir) then
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.twohundred,transactionVolume = soundVolume})
					Wait(1800)
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.TurnRight,transactionVolume = soundVolume})
					lastMessage = "distclose"
					Wait(1600)
				end
			elseif ldir == 7 then
				if ldist < 480 and ldist > 280 and (lastMessage ~= "distfar" or lastdir ~= dir) then
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.fourhundred,transactionVolume = soundVolume})
					Wait(2000)
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.KeepLeft,transactionVolume = soundVolume})
					lastMessage = "distfar"
					Wait(1600)
				elseif ldist < 40.0 and (lastMessage ~= "now" or lastdir ~= dir) then
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.KeepLeft,transactionVolume = soundVolume})
					lastMessage = "distnow"
					Wait(1600)
				elseif ldist < 180 and ldist > 80 and (lastMessage ~= "distclose" or lastdir ~= dir) then
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.twohundred,transactionVolume = soundVolume})
					Wait(1800)
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.KeepLeft,transactionVolume = soundVolume})
					lastMessage = "distclose"
					Wait(1600)
				end
			elseif ldir == 8 then
				if ldist < 480 and ldist > 280 and (lastMessage ~= "distfar" or lastdir ~= dir) then
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.fourhundred,transactionVolume = soundVolume})
					Wait(2000)
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.KeepRight,transactionVolume = soundVolume})
					lastMessage = "distfar"
					Wait(1600)
				elseif ldist < 40.0 and (lastMessage ~= "now" or lastdir ~= dir) then
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.KeepRight,transactionVolume = soundVolume})
					lastMessage = "distnow"
					Wait(1600)
				elseif ldist < 180 and ldist > 80 and (lastMessage ~= "distclose" or lastdir ~= dir) then
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.twohundred,transactionVolume = soundVolume})
					Wait(1800)
					SendNUIMessage({transactionType = 'playSound',transactionFolder = currentVoice,transactionFile = gpsvoices.KeepRight,transactionVolume = soundVolume})
					lastMessage = "distclose"
					Wait(1600)
				end
			end
			lastdir = dir
		end
	end
end)


function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function DrawText2(text)
			SetTextFont(0)
			SetTextProportional(1)
			SetTextScale(0.0, 0.50)
			SetTextDropshadow(1, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.40, 0.10)
	end
	function DrawText3(text)
				SetTextFont(0)
				SetTextProportional(1)
				SetTextScale(0.0, 0.50)
				SetTextDropshadow(1, 0, 0, 0, 255)
				SetTextEdge(1, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				SetTextEntry("STRING")
				AddTextComponentString(text)
				DrawText(0.40, 0.15)
		end
		function DrawText4(text)
					SetTextFont(0)
					SetTextProportional(1)
					SetTextScale(0.0, 0.50)
					SetTextDropshadow(1, 0, 0, 0, 255)
					SetTextEdge(1, 0, 0, 0, 255)
					SetTextDropShadow()
					SetTextOutline()
					SetTextEntry("STRING")
					AddTextComponentString(text)
					DrawText(0.40, 0.20)
			end