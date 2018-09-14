<?php

session_start();
if(!isset($_SESSION['username'])) {
header( "refresh:0;url=login.php" );
die();
}

include("inc/config.php");


require("./rcon/q3query.class.php");
if (isset($_GET['action'])) {
    $action = $_GET['action'];
} else {
	echo "No action specified";
	die();
}
if (isset($_GET['steam'])) {
	$user_steam = $_GET['steam'];
} else {
	echo "No user specified";
	die();
}

if (isset($_GET['message'])) {
	$action_message = $_GET['message'];
} else {
	$action_message = "";
}


	// push players from json file into the array
	ini_set('default_socket_timeout', $timeoutAfterSeconds);
	foreach ($servers as &$server) {
		//echo $server;
		$url = "http://".$server["ip"].":".$server["port"]."/players.json";
		$json = @file_get_contents($url); // this WILL do an http request for you
		$data = json_decode($json);
		if($json === FALSE ){ $data = array(); }
		$server["players"] = $data;
	}
	
	
	// check if the user exists on one of the servers
	foreach ($servers as &$server) {
		foreach ($server["players"] as &$player) {
			
			if ($player->identifiers[0] == "steam:".$user_steam OR $player->identifiers[0] == "license:".$user_steam) {
							
				$con = new q3query($server["ip"], $server["port"], $success);
				if (!$success) {
					die ("Fehler bei der Verbindungherstellung");
				}
				$con->setRconpassword($server["rcon"]);
				$con->rcon("$action ".$player->id." $action_message");
				echo "You successfully should have kicked ".$player->name.". Redirect after 3 seconds.";
				header( "refresh:3;url=players.php" );
				
				die();
			}
		}
	}
	echo "player not found. already left?";
	header( "refresh:3;url=players.php" );
	die();
?>
