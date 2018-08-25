------- CHANGE THESE SETTINGS TO FIT YOUR NEEDS -------

-- Recommended total number of lines is ~13
local helpMessage = {
    '----------------',
	'----------------',
	'-Commands List-',
    'Server Rules?: /rules',
    '-------------Roleplay CMDS:/911,/ooc,/me,/do,/tweet,/ad,/news,/tow (automated)',
	'------------------------------Animations: EMOTES PRESS (HOME KEY)',
	'Vehicle CMDS: /dv,/engine,/fix',
	'-------------------------------NEED TO REPORT A PLAYER? do /report [PlayerName] [Reason]',
	'---Contact Us---',
	'-----------------Website: FloridaStateRP.com',
	'DISCORD: (USE LINK AT BOTTOM OF SCREEN)',
	'-----------------MENUS: F1=Lambda Menu Home=RPTOOLBOX Delete= ALPR RADAR',
}
-- Recommended total number of lines is ~13
local rulesMessage = {
    'NO VDM,RDM,FailRP ANYTIME.',
    'NO SPEED OR TORQUE BOOSTS',
    'HAVE FUN',
}

-- Prefixes will be displayed before each line,
local helpPrefix = '^3'
local helpSuffix = '^3.'
local rulesPrefix = '^1'
local rulesSuffix = '^1.'

-- Customize your /help and /rules command, if you wish.
local helpCommand = 'help' -- don't add a "/" here!
local rulesCommand = 'rules' -- don't add a "/" here!
-------------------------------------------------------


















------- CODE, DON'T TOUCH THIS!!! -------
RegisterCommand(helpCommand, function()
    for i in pairs(helpMessage) do
        TriggerEvent('chatMessage', '', {255, 255, 255}, helpPrefix .. helpMessage[i] .. helpSuffix)
    end
end, false)

RegisterCommand(rulesCommand, function()
    for i in pairs(rulesMessage) do
        TriggerEvent('chatMessage', '', {255, 255, 255}, rulesPrefix .. rulesMessage[i] .. rulesSuffix)
    end
end, false)
TriggerEvent('chat:addSuggestion', '/' .. helpCommand, 'Displays a help message.')
TriggerEvent('chat:addSuggestion', '/' .. rulesCommand, 'Displays the server rules.')