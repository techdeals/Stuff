CurrentAOP = "San"
CurrentAOP2 = "Andreas"

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('aop:requestSync')
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DrawText2(0.780, 1.450, 1.0,1.0,0.45, "~w~" .. CurrentAOP .. " " .. CurrentAOP2, 255, 255, 255, 205)
	end
end)

RegisterNetEvent('aop:updateAOP')
AddEventHandler('aop:updateAOP', function(newCurrentAOP, newCurrentAOP2)
    CurrentAOP = newCurrentAOP
	CurrentAOP2 = newCurrentAOP2
end)

RegisterNetEvent('play911')
AddEventHandler('play911', function()
	TriggerServerEvent('InteractSound_SV:PlayOnSource', '911', 0.1)
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

local leoSkins = {
	"S_M_Y_COP_01",
	"S_F_Y_COP_01",
    "s_m_m_ciasec_01",
    "s_m_y_hwaycop_01",
    "s_m_y_hwaycop_01_p",
	"s_m_m_ciasec_01",
    "s_m_y_sheriff_01",
    "s_m_y_swat_01",
	"s_f_y_ranger_01",
	"s_m_y_ranger_01",
}

local fdSkins = {
    "s_m_y_fireman_01",
	"s_m_m_paramedic_01"
}

RegisterCommand("bk", function(source, args, raw)
local response = tonumber(args[1])
x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
local streethash = GetStreetNameAtCoord(x, y, z)
local name = GetPlayerName(PlayerId())
local street = GetStreetNameFromHashKey(streethash)

	if IsAllowedPed("leo") then

		if ( response == nil ) then 
			drawNotification("~r~Error: ~s~You did not input a response type!")
		 elseif ( response == 1 ) then 
			TriggerServerEvent("manlet:leobk1", name, street)
		 elseif ( response == 2 ) then 
			TriggerServerEvent("manlet:leobk2", name, street)
		 elseif ( response == 3 ) then 
			TriggerServerEvent("manlet:leobk3", name, street)
		 elseif ( response == 4 ) then 
			TriggerServerEvent("manlet:leobk4", name)
		 elseif ( response ~= 1 or 2 or 3) then
			drawNotification("~r~Error: ~s~"..response" is an invalid response type!")
		end
	
	 elseif IsAllowedPed("fd") then
		drawNotification("~r~Error: ~s~The Fire Deparment Command is comming soon!")
	 
	 else
	    drawNotification("~r~Error: ~s~You are not authorised to use this command!")
		
	end
end, false)


function IsAllowedPed(class)
	success = false
	if class == "leo" then
		for i=1,#leoSkins do
			if GetEntityModel(PlayerPedId()) == GetHashKey(leoSkins[i]) then
				success = true
			end
		end
	elseif class == "fd" then
		for i=1,#fdSkins do
			if GetEntityModel(PlayerPedId()) == GetHashKey(fdSkins[i]) then
				success = true
			end
		end
	end

	return success
end


function drawNotification(Notification)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(Notification)
	DrawNotification(false, false)
end

Citizen.CreateThread(function()
  	while true do
		Wait(1)
		local name = GetPlayerName(PlayerId())
			AddTextEntry('FE_THDR_GTAO', '~g~ Virginia State Roleplay ~w~- ~r~Name: ~w~'..name..'~r~ AOP: ~w~' .. CurrentAOP .. ' ' .. CurrentAOP2 )
	end
end)

-- Credits to @Havoc , @Flatracer , @Briglair , and @WolfKnight	on forum.fivem.net for helping me create this
-- Thanks to Ethan Rubinacci and Mark Curry
-- Lots of thanks to @Wolfknight for help with the admin feature
-- Special thanks to @Flatracer

-- Created by Murtaza. If you need help, msg me. The comments are there for people to learn.

-- CLIENTSIDED
-- Register a network event
RegisterNetEvent('ObjectDeleteGunOn') -- Registers the event on the net so that it can be called on a server_script
RegisterNetEvent('ObjectDeleteGunOff') -- Registers the event on the net so that it can be called on a server_script
RegisterNetEvent('noPermissions') -- Registers the event on the net so that it can be called on a server_script
local toggle = false

AddEventHandler('ObjectDeleteGunOn', function() -- adds an event handler so it can be registered
	if toggle == false then -- checks if toggle is false
		drawNotification("~g~Object Delete Gun Enabled!") -- activates function drawNotification() with message in parentheses
		toggle = true -- sets toggle to true
	else -- if not
		drawNotification('~y~Object Delete Gun is already enabled!') -- activates function drawNotification() with message in parentheses
	end
end)

AddEventHandler('ObjectDeleteGunOff', function() -- adds an event handler so it can be registered
	if toggle == true then -- checks if toggle is true
		drawNotification('~b~Object Delete Gun Disabled!') -- activates function drawNotification() with message in parentheses
		toggle = false -- sets toggle to false
	else -- if not
		drawNotification('~y~Object Delete Gun is already disabled!') -- activates function drawNotification() with message in parentheses
	end
end)

AddEventHandler('noPermissions', function() -- adds an event handler so it can be registered
	drawNotification("~r~You have insufficient permissions to activate the Object Delete Gun.") -- activates function drawNotification() with message in parentheses
end)

Citizen.CreateThread(function() -- Creates thread
	while true do -- infinite loop
		Citizen.Wait(0) -- wait so it doesnt crash
		if toggle then -- checks toggle if its true (infinitely
			if IsPlayerFreeAiming(PlayerId()) then -- checks if player is aiming around
				local entity = getEntity(PlayerId()) -- gets the entity
				if IsPedShooting(GetPlayerPed(-1)) then -- checks if ped is shooting
					SetEntityAsMissionEntity(entity, true, true) -- sets the entity as mission entity so it can be despawned
					DeleteEntity(entity) -- deletes the entity
				end
			end
		end
	end
end)

function getEntity(player) --Function To Get Entity Player Is Aiming At
	local result, entity = GetEntityPlayerIsFreeAimingAt(player)
	return entity
end

function drawNotification(text) --Just Don't Edit!
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

local currentlyTowedVehicle = nil

RegisterNetEvent('pv:tow')
AddEventHandler('pv:tow', function()
	
	local playerped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(playerped, true)
	
	local towmodel = GetHashKey('flatbed')
	local isVehicleTow = IsVehicleModel(vehicle, towmodel)
			
	if isVehicleTow then
	
		local coordA = GetEntityCoords(playerped, 1)
		local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
		local targetVehicle = getVehicleInDirection(coordA, coordB)
		
		if currentlyTowedVehicle == nil then
			if targetVehicle ~= 0 then
				if not IsPedInAnyVehicle(playerped, true) then
					if vehicle ~= targetVehicle then
						AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						currentlyTowedVehicle = targetVehicle
						TriggerEvent("chatMessage", "[TOW]", {255, 255, 0}, "Vehicle successfully attached to towtruck!")
					else
						TriggerEvent("chatMessage", "[TOW]", {255, 255, 0}, "Are you fucking retarded? You cant tow your own towtruck with your own towtruck?")
					end
				end
			else
				TriggerEvent("chatMessage", "[TOW]", {255, 255, 0}, "Theres no vehicle to tow?")
			end
		else
			AttachEntityToEntity(currentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
			DetachEntity(currentlyTowedVehicle, true, true)
			currentlyTowedVehicle = nil
			TriggerEvent("chatMessage", "[TOW]", {255, 255, 0}, "The vehicle has been successfully detached!")
		end
	end
end)

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

RegisterNetEvent("textsent")
AddEventHandler('textsent', function(tPID, names2)
	TriggerEvent('chatMessage', "", {205, 205, 0}, " Reply sent to:^0 " .. names2 .."  ".."^0  - " .. tPID)
end)

RegisterNetEvent("textmsg")
AddEventHandler('textmsg', function(source, textmsg, names2, names3 )
	TriggerEvent('chatMessage', "", {205, 205, 0}, "  ADMIN " .. names3 .."  ".."^0: " .. textmsg)
end)


RegisterNetEvent('sendReport')
AddEventHandler('sendReport', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "", {255, 0, 0}, "Report sent to the admins online!")
	TriggerServerEvent("checkadmin", name, message, id)
  elseif pid ~= myId then
    TriggerServerEvent("checkadmin", name, message, id)
  end
end)


RegisterNetEvent('sendReportToAllAdmins')
AddEventHandler('sendReportToAllAdmins', function(id, name, message, i)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " [REPORT] | [".. i .."]" .. name .."  "..":^0  " .. message)
  end
end)


local cooldown = 0
local ispriority = false
local ishold = false

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
			DrawText3("Priority Cooldown: ~b~Priorities Are On Hold")
		elseif ispriority == false then
			DrawText3("Priority Cooldown: ~r~".. cooldown .." ~w~Mins")
		elseif ispriority == true then
			DrawText3("Priority Cooldown: ~g~Priority In Progress")
		end
	end
end)

	function DrawText3(text)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextScale(0.0, 0.35)
        SetTextDropshadow(1, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(0.002, 0.001)
    end

RegisterCommand("911", function(source,args,rawCommand)
    x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    streethash = GetStreetNameAtCoord(x, y, z)
    street = GetStreetNameFromHashKey(streethash)
	if ( activeDispatch == false ) then
		print("call made")
		Citizen.Trace("dickcockwilly ".. street.. " ; ".. rawCommand)
		TriggerServerEvent("911", street, rawCommand)
	elseif ( activeDispatch == true ) then
		drawNotification("~r~There is currently Active Dispatch, therefore /911 has been disabled.")
		drawNotification("~o~Please go to the 'Need 911 S1/S2' to make a 911 call.")
	end
end, false)	
	
activeDispatch = false

AddEventHandler('playerSpawned', function()
    TriggerServerEvent('dispatch:requestSync')
end)	
	
RegisterNetEvent('dispatch:update')
AddEventHandler('dispatch:update', function(toggle)
    print(activeDispatch)
	activeDispatch = toggle
end)
	
RegisterNetEvent('dispatch:Notify')
AddEventHandler('dispatch:Notify', function(toggle)
	if ( toggle == true ) then
		drawNotification("You have toggled active dispatch ~g~on!")
	elseif ( toggle == false ) then
		drawNotification("You have toggled active dispatch ~r~off!")
	end
end)
--[[
local isAdmin = false
local keys = true

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		SetEntityVisible(PlayerPedId(), true)
		local health = GetPlayerInvincible(PlayerId())
		local veh = GetVehiclePedIsIn(PlayerPedId(), false)
		if ( health == 1 ) and ( isAdmin == false ) then	
			DrawText2(1, 0.7, 1.0,1.0,4.0, "GOD MODE DETECTED ~n~~o~ADMINS HAS BEEN ALERTED", 255, 0, 0,205, true)
			--RemoveAllPedWeapons(GetPlayerPed(-1), true)
			FreezeEntityPosition(GetPlayerPed(-1), true)
			SetWaypointOff()
			drawNotification("~r~You have been restricted from roleplay, an administrator will be with you shortly, please do not complain in chat (this will make things worse!!).")
			DeleteEntity(veh)
			TriggerServerEvent("sendDiscord")
			keys = false
		else
			FreezeEntityPosition(GetPlayerPed(-1), false)
			keys = true
		end
		
		if not IsEntityVisible(PlayerPedId()) then
			SetEntityHealth(PlayerPedId(), -100) -- if player is invisible kill him!
			drawNotification("~r~You are invisible, you may need to change youre ped.")
		end
	end
end)







Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if ( keys == false ) then	
			DisableControlAction(0,21,true) -- disable sprint
			DisableControlAction(0,24,true) -- disable attack
			DisableControlAction(0,25,true) -- disable aim
			DisableControlAction(0,47,true) -- disable weapon
			DisableControlAction(0,58,true) -- disable weapon
			DisableControlAction(0,263,true) -- disable melee
			DisableControlAction(0,264,true) -- disable melee
			DisableControlAction(0,257,true) -- disable melee
			DisableControlAction(0,140,true) -- disable melee
			DisableControlAction(0,141,true) -- disable melee
			DisableControlAction(0,142,true) -- disable melee
			DisableControlAction(0,143,true) -- disable melee
			DisableControlAction(0,75,true) -- disable exit vehicle
			DisableControlAction(27,75,true) -- disable exit vehicle
			DisableControlAction(0,289,true) -- disable exit vehicle
		else
		end
	end
end)]]--

function DrawText2(x,y ,width,height,scale, text, r, g, b, a, center)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(7, 1, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
	SetTextCentre(center)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end





local markerAlpha = 10
local markerRange = 0.6
local markerTable =
{
	-- X, Y, Z
	{1692.35, 3758.95, 34.7}, -- Sandy, BL
	{-331.47, 6082.45, 31.45}, -- Paleto, BL
	{-1118.96,2697.27,18.55},	-- Zancudo (US-68), BL
	{20.95,-1106.65,29.80},	-- Pillbox Hill/Mission Row, LS
	{252.76,-48.58,69.94},	-- Vinewood, LS
	{-3172.76,1086.11,20.84},	-- Chumash, LS
	{844.25,-1033.66,28.19},	-- La Mesa, LS
	{-664.12,-935.31,21.83},	-- Little Seoul, LS
	{-1305.30,-392.42,36.70},	-- Morningwood, LS
	{812.15,-21557.41,29.62},	-- Cypress Flats, LS
	{2569.77,294.39,108.73},	-- Tataviam Mountains, LS
}
Citizen.CreateThread(function()
	while(true)do;Citizen.Wait(0);local ped_l=GetPlayerPed(-1)
		if(DoesEntityExist(ped_l))and(not IsEntityDead(ped_l))then
			local ppos=GetEntityCoords(ped_l,true)
			for k=1,#markerTable,1 do
				if(GetDistanceBetweenCoords(markerTable[k][1],markerTable[k][2],markerTable[k][3],ppos) < 15)then
					DrawMarker(1, markerTable[k][1], markerTable[k][2], markerTable[k][3]-1.1, 0, 0, 0, 0.0, 0.0, 0, 0.801, 0.801, 0.6, 100, 15, 200, 200, false, true, true, true, 0, 0)
					DrawMarker(1, markerTable[k][1], markerTable[k][2], markerTable[k][3]-1.1, 0, 0, 0, 0.0, 0.0, 0, 0.8, 0.8, 1.0, 233, 233, 233, markerAlpha, false, true, true, true, 0, 0)
					if(ppos.x>=markerTable[k][1]-markerRange)and(ppos.x<=markerTable[k][1]+markerRange)and(ppos.y>=markerTable[k][2]-markerRange)and(ppos.y<=markerTable[k][2]+markerRange)then
						DisableControlAction(0,176,true)
						if(not displayHelpBox)then
							ShowHelpText("~p~Press ~INPUT_CELLPHONE_SELECT~ to buy weapons.",true,3000)
							displayHelpBox = true
						end
						if(IsDisabledControlJustPressed(0,176))then
							displayBox = true
							GiveWeaponToPed(ped_l,GetHashKey("WEAPON_MUSKET"),6,false,false)	-- TEMP --
						end
						if(displayBox)then
							DrawRect(0.5,0.60,0.31,0.22,0,0,0,210)	-- TEMP --
							drawText("~w~AMMU-~s~NATION!~n~~w~COMING ~s~SOON!",1920/2, 1080/2,1.3,true,0,210,5,5,200)	-- TEMP --
							drawText("~w~But here is a free gun, now go protect your streets.",1920/2, 725,0.4,true,0,210,5,5,200)	-- TEMP --
						end
					else
						displayHelpBox = false
						displayBox = false
					end
				end
			end
		end
	end
end)

function ShowHelpText(text,beep,delay)
	if(beep==nil)then;beep=false;end
	if(delay==nil)then;delay=2000;end
	showHelpTextActive = true
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentString("~r~Ammunation~s~~n~"..text)
	EndTextCommandDisplayHelp(0, true, beep, 0)
	Citizen.CreateThread(function()
		Citizen.Wait(delay)
		if(showHelpTextActive)then
			ClearAllHelpMessages()
			showHelpTextActive = false
		end
	end)
end

function float(num)
	num = num + 0.00001
	return num
end

function drawText(text, x, y, size, center, font, r, g, b, a)
	local resx, resy = GetScreenResolution()
	SetTextFont(font)
	SetTextScale(size, size)
	SetTextProportional(true)
	SetTextColour(r, g, b, a)
	SetTextCentre(center)
	SetTextDropshadow(0, 0, 0, 0, 0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText((float(x) / 1.5) / resx, ((float(y) - 6) / 1.5) / resy)
end

--[[
local isZoomed = false

RegisterCommand("togzoom", function(source, args, raw)
	if ( isZoomed == false ) then
		SetRadarZoom(0)
		isZoomed = true
	elseif ( isZoomed == true ) then
		SetRadarZoom(200)
		isZoomed = false
	end
end, false)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
		if isZoomed == false then
			SetRadarZoom(0)
		elseif izZoomed == true then
			SetRadarZoom(200)
		end
	end
end)]]--