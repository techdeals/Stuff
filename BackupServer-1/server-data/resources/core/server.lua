---------------------------------------
-- Fax Core Whitelist, Made by FAXES --
---------------------------------------

SetGameType("Server Restriction : Guest")
--print('Fax-Core Whitelist Has Loaded!')

-- If you want to change this so only certain ranks can join when the server starts simply change it to one of the following
-- owner, snradmin, admin, mem3, mem2, mem1, guest
-- Also dont forget to change line 7
FCWhiteLvl = "guest"

authLvlRank = 
{
	["Guest"] = 0,
	["M1"] = 1,
	["Pilot's License"] = 2,
	["M3"] = 3,
	["Admin"] = 4,
	["Staff Manager"] = 5,
	["Founder"] = 6,
}

AddEventHandler("playerConnecting", function(source)
    
end)

-------------------------------------------------------------

-- Register Command
RegisterCommand("whitelist", function(source, args, rawCommand)
    local FCWArg = args[1]
    if curAuthLvlRank == authLvlRank["Owner"] or authLvlRank["Sadmin"] or authLvlRank["Admin"]then
        if FCWArg == "owner" then
            SetGameType("Server Restriction : Owner")
            FCWhiteLvl = "owner"
            TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n Server Access Authorization \n Has Been Set to: Owner \n ——————————————————————", {239, 0, 0})
        elseif FCWArg == "snradmin" then
            FCWhiteLvl = "snradmin"
                TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n Server Access Authorization \n Has Been Set to: Senior Admin \n ——————————————————————", {239, 0, 0})
                SetGameType("Server Restriction : Senior Admin")
        elseif FCWArg == "admin" then
            FCWhiteLvl = "admin"
                TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n Server Access Authorization \n Has Been Set to: Admin \n ——————————————————————", {239, 0, 0})
                SetGameType("Server Restriction : Admin")
        elseif FCWArg == "m3" then
            FCWhiteLvl = "mem3"
                TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n Server Access Authorization \n Has Been Set to: Member 3 \n ——————————————————————", {239, 0, 0})
                SetGameType("Server Restriction : Member 3")
        elseif FCWArg == "m2" then
                FCWhiteLvl = "mem2"
                TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n Server Access Authorization \n Has Been Set to: Member 2 \n ——————————————————————", {239, 0, 0})
                SetGameType("Server Restriction : Member 2")
        elseif FCWArg == "m1" then
                FCWhiteLvl = "mem1"
                TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n Server Access Authorization \n Has Been Set to: Member 1 \n ——————————————————————", {239, 0, 0})
                SetGameType("Server Restriction : Member 1")
        elseif FCWArg == "guest" then
                TriggerClientEvent("chatMessage", -1, " \n —————————————————————— \n Server Access Authorization \n Has Been Set to: Guest (No Restriction) \n ——————————————————————", {239, 0, 0})
                SetGameType("Server Restriction : Guest")
                FCWhiteLvl = "guest"
        else
            TriggerClientEvent("chatMessage", source, "Possible Arguments: \n owner - Sets auth to owner \n snradmin - Sets auth to senior admin \n admin - Sets auth to admin \n m3 - Sets auth to member 3 \n m2 - Sets auth to member 2 \n m1 - Sets auth to member 1 \n guest - Sets auth to member guest (none)", {239, 0, 0})
        end
    else
        TriggerClientEvent('Fax-Core:NoPerms', source)
    end
end)
--------------------------------------------------------------

AddEventHandler("playerConnecting", function(name, setCallback, deferrals)
    local s = source

    if IsPlayerAceAllowed(s, "owner") then
        curAuthLvlRank = authLvlRank["Owner"]

    elseif IsPlayerAceAllowed(s, "snradmin") then
        curAuthLvlRank = authLvlRank["Sadmin"]

    elseif IsPlayerAceAllowed(s, "fadmin") then
        curAuthLvlRank = authLvlRank["Admin"]

    elseif IsPlayerAceAllowed(s, "member3") then
        curAuthLvlRank = authLvlRank["M3"]

    elseif IsPlayerAceAllowed(s, "member2") then
        curAuthLvlRank = authLvlRank["M2"]

    elseif IsPlayerAceAllowed(s, "member1") then
        curAuthLvlRank = authLvlRank["M1"]

    else
        curAuthLvlRank = authLvlRank["Guest"]
    end


    deferrals.defer()
    deferrals.update("Checking Permissions")
    Wait(1000)
    local allowed = false
        if FCWhiteLvl == "owner" then
            if curAuthLvlRank == authLvlRank["Owner"] then
                deferrals.done()
            else
                deferrals.done("Server restriction is set to Owner and above.")
            end
        elseif FCWhiteLvl == "snradmin" then
            if curAuthLvlRank == authLvlRank["Owner"] or authLvlRank["Sadmin"] then
                deferrals.done()
            else
                deferrals.done("Server restriction is set to Senior Admin and above.")
            end
        elseif FCWhiteLvl == "admin" then
            if curAuthLvlRank == authLvlRank["Owner"] or authLvlRank["Sadmin"] or authLvlRank["Admin"]then
                deferrals.done()
            else
                deferrals.done("Server restriction is set to Admin and above.")
            end
        elseif FCWhiteLvl == "mem3" then
            if curAuthLvlRank == authLvlRank["Owner"] or authLvlRank["Sadmin"] or authLvlRank["Admin"] or authLvlRank["M3"] then
                deferrals.done()
            else
                deferrals.done("Server restriction is set to Member 3 and above.")
            end
        elseif FCWhiteLvl == "mem2" then
            if curAuthLvlRank == authLvlRank["Owner"] or authLvlRank["Sadmin"] or authLvlRank["Admin"] or authLvlRank["M3"] or authLvlRank["M2"] then
                deferrals.done()
            else
                deferrals.done("Server restriction is set to Member 2 and above.")
            end
        elseif FCWhiteLvl == "mem1" then
            if curAuthLvlRank == authLvlRank["Owner"] or authLvlRank["Sadmin"] or authLvlRank["Admin"] or authLvlRank["M3"] or authLvlRank["M2"] or authLvlRank["M1"] then
                deferrals.done()
            else
                deferrals.done("Server restriction is set to Member 1 and above.")
            end
        elseif FCWhiteLvl == "guest" then
                deferrals.done()
        else
            deferrals.done("Server restriction is set on the server")
        end
end)

Citizen.CreateThread(function ()
    check = (GetConvar("Fax-Core", "false") == "true")
        if not check then
            Wait(140)
            print("\n")
            print("--------------------- Fax-Core WL ----------------------")
            print("-------- ALERT: Fax-Core has not been detected ---------")
            print("----------- Please check your Fax Core setup -----------")
            print("------- http://faxes.zone/scripts/fax-core.html --------")
            print("--------------------------------------------------------")
            print("\n")
        end
    end)