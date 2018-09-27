AddEventHandler("playerSpawned", function(spawn)
    Citizen.Wait(5000)
    TriggerEvent("chatMessage", "", { 49, 196, 157 }, "Welcome to LossRP.\nJoin our discord at ^1discord.gg/9VzpVtd")
end)
