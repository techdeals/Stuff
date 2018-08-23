DiscordWebhookSystemInfos = 'https://discordapp.com/api/webhooks/477696126422745099/jpfHnnQip6Y11H96s3Mp429TrOElAoWDp2AA1Cqm6t2nbIyA8O1GbKoxgJWXONBMPhn3'
DiscordWebhookKillinglogs = 'https://discordapp.com/api/webhooks/477757745081090048/ZAv67iNwsb6vvJlZPocFIb1fOcEWGWILS7efQ1ci59AqOAvmi_qNTKMegc_Ys6EsfsG6'
DiscordWebhookChat = 'https://discordapp.com/api/webhooks/477757898144088064/QkPd3tzB_KU-y9EQoMna-E8AJq39xqEJtK3XED_Slylc96WnQl42uGN4wBEIc6zUFLMS'

SystemAvatar = 'https://wiki.fivem.net/w/images/d/db/FiveM-Wiki.png'

UserAvatar = 'https://i.imgur.com/KIcqSYs.png'

SystemName = 'SYSTEM'


--[[ Special Commands formatting
		 *YOUR_TEXT*			--> Make Text Italics in Discord
		**YOUR_TEXT**			--> Make Text Bold in Discord
	   ***YOUR_TEXT***			--> Make Text Italics & Bold in Discord
		__YOUR_TEXT__			--> Underline Text in Discord
	   __*YOUR_TEXT*__			--> Underline Text and make it Italics in Discord
	  __**YOUR_TEXT**__			--> Underline Text and make it Bold in Discord
	 __***YOUR_TEXT***__		--> Underline Text and make it Italics & Bold in Discord
		~~YOUR_TEXT~~			--> Strikethrough Text in Discord
]]
-- Use 'USERNAME_NEEDED_HERE' without the quotes if you need a Users Name in a special command
-- Use 'USERID_NEEDED_HERE' without the quotes if you need a Users ID in a special command


-- These special commands will be printed differently in discord, depending on what you set it to
SpecialCommands = {
				   {'/ooc', '**[OOC]:**'},
				   {'/911', '**[911]: (CALLER ID: [ USERNAME_NEEDED_HERE | USERID_NEEDED_HERE ])**'},
				   {'/report', '---------------------------__***[Player-Report]***__--------------------------- **Victim:**  *USERNAME_NEEDED_HERE* (ID): USERID_NEEDED_HERE  --------------------------- **Antagonist:**'},
				  }

						
-- These blacklisted commands will not be printed in discord
BlacklistedCommands = {
					   '/AnyCommand',
					   '/AnyCommand2',
					  }

-- These Commands will use their own webhook
OwnWebhookCommands = {
					  {'/911', 'https://discordapp.com/api/webhooks/477758311161135137/h6wdgwDnv8rc1BfApseJnJE0qJXj17CbE2N9oQ1U6dFt_usCaSV9UsJ-FRH33_5B2-lP'},
					  {'/report', 'https://discordapp.com/api/webhooks/477758510743027712/WKtO5DBWZ8bNskmZqFC_B0L_GkPSMIFuYmhBmBvGkEgyfUlLj_oZOnLEoE5iZ9zGQ2WP'},
					 }

-- These Commands will be sent as TTS messages
TTSCommands = {
			   '/Whatever',
			   '/Whatever2',
			  }

