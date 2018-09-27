-- DO NOT CHANGE ANY OF THIS CODE! IF SOMETHING DOESNT WORK CONTACT @lukepollie ON THE FIVEM FORUMS!!!
-- DO NOT CHANGE ANY OF THIS CODE! IF SOMETHING DOESNT WORK CONTACT @lukepollie ON THE FIVEM FORUMS!!!
-- DO NOT CHANGE ANY OF THIS CODE! IF SOMETHING DOESNT WORK CONTACT @lukepollie ON THE FIVEM FORUMS!!!
-- DO NOT CHANGE ANY OF THIS CODE! IF SOMETHING DOESNT WORK CONTACT @lukepollie ON THE FIVEM FORUMS!!!


RegisterCommand("lsp", function(source, args, rawCommand)
    Stuff() 
end, false)


function Stuff()
    local model = GetHashKey("S_M_Y_HWAYCOP_01") -- Change model name here <--
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
    local ped = PlayerPedId()
    local name = GetPlayerName(_source)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_TEARGAS"), 1000, false) -- Change weapon hash here <--
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"), 1000, false) -- Change weapon hash here <--
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), 1000, false) -- Change weapon hash here <--
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), 1000, false) -- Change weapon hash here <--
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), 1000, false) -- Change weapon hash here <--
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_NIGHTSTICK"), 1000, false) -- Change weapon hash here <--
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_STUNGUN"), 1000, false) -- Change weapon hash here <--
    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_STUNGUN"), true)

    TriggerEvent('chatMessage', "^*LSP State Trooper", { 255, 26, 71 }, name .. " IS NOW ONDUTY!") -- Change chatmessage here <--
end

RegisterCommand("offduty", function(source, args, rawCommand)
    Other()
end, false)

function Other()
    local model = GetHashKey("a_m_m_business_01") -- Change model name here <--
    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
    local Ped = PlayerPedId()
    local name = GetPlayerName(_source)
    RemoveAllPedWeapons(GetPlayerPed(-1))
    TriggerEvent('chatMessage', "^*LSP State Trooper", { 255, 26, 71 }, name .. " IS NOW OFFDUTY!") -- Change chatmessage here <--
end



RegisterCommand('spawn', function(source, args, rawCommand)
    
    local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
    local hash = GetHashKey(args[1])  
    local ped = GetPlayerPed(-1)
        
    RequestModel(hash)
        
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Citizen.Wait(0)
    end

    local ve = CreateVehicle(hash,plyCoords, true, false)
    SetPedIntoVehicle(ped, ve, -1)

end) -- Credits to @woopi for fixing so you spawn in the vehicle