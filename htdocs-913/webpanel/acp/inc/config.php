<?php

$websiteTitle = "LossRP.com";
$securityKey = "studxp05STUDXP@#"; // basically prevents others from sending rcon commands by exploiting the site
$timeoutAfterSeconds = 3; // more seconds means a longer site load when a server is not reachable

$servers = array(
    array(
		"name"	=> "LossRP | Main",
        "ip"	=> "192.223.30.69",
		"port"	=> "30120",
		"rcon"	=> "studxp05STUDXP@#"
    )
	,
	array(
		"name"	=> "LossRP | Zombie Survival",
        "ip"	=> "209.141.48.30",
		"port"	=> "30110",
		"rcon"	=> "studxp05STUDXP@#"
    )
	,
	array(
		"name"	=> "LossRP | Minecraft",
        "ip"	=> "209.141.48.30",
		"port"	=> "25565",
		"rcon"	=> "studxp05STUDXP@#"
    )
);



// REAL STEAM IDS (64) -> http://steamid.io
// class names (colors) are from -> https://getbootstrap.com/docs/4.0/components/badge/#contextual-variations
// pasword hashes are generated from -> http://www.sha1-online.com/
// rights are : login, kick, ban, rcon - should be self explanatory

$groups = array( 
	array(
		"name"	=> "Admin",
		"class" => "badge badge-danger",
        "members"	=> array(
			array(
				"username"	=> "officerscentral@lossrp.com",
				"password" 	=> "daac23ee733bd51ecd70e67ec7830b8fcef9bb63",
				"steam"		=> "steam:76561198797645651",
			),
			array(
				"username"	=> "jordan@lossrp.com",
				"password" 	=> "ed0ac3f750959a77d759c21e4f7bbcf67db94ce0",
				"steam"		=> "steam:110000133566040",
			),
			array(
				"username"	=> "lucas@lossrp.com",
				"password" 	=> "42b8eccbb5b834aa8da3a263e702552a84d206b4",
				"steam"		=> "steam:11000010726bec",
			),
			array(
				"username"	=> "torchie@lossrp.com",
				"password" 	=> "d8423a141589ceef1472a6b9713dccbb5957f752",
				"steam"		=> "steam:1100001048b0d98",
			),
		),
		"rights"	=> ["login", "kick", "ban", "rcon"],
	),
	
	array(
		"name"	=> "Moderators",
		"class" => "badge badge-warning",
		"members"			=> array(
			array(
				"username"	=> "user3",
				"password" 	=> "HASH OF THE PASSWORD",
				"steam"		=> "steam:REAL STEAM IDS (64)",
			)
		),
		"rights"	=> ["login", "kick"],
	),
	
	array(
		"name"	=> "Donators",
		"class" => "badge badge-success",
		"members"			=> array(
			array(
				"username"	=> "user4",
				"password" 	=> "PASSWORD HASH",
				"steam"		=> "steam:REAL STEAM IDS (64)",
			)
		),
		"rights"	=> [],
	)
);
?>