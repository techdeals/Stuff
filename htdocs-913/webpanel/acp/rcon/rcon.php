<?php 
include("../inc/config.php");
if(!isset($_GET['securitykey'])) {
header( "refresh:0;url=login.php" );
die();
}
if($_GET['securitykey'] != $securityKey) {
header( "refresh:0;url=login.php" );
die();
}
if(!isset($_GET['server'])) {
header( "refresh:0;url=login.php" );
die();
}
if($_GET['server'] == "") {
header( "refresh:0;url=login.php" );
die();
}
$r_server = $_GET['server'];
if(!isset($_GET['command'])) {
header( "refresh:0;url=login.php" );
die();
} else {
	$command = $_GET['command'];

	$command = str_replace(",", " ", "$command");
}


require("q3query.class.php");

foreach ($servers as &$server) {
		if($server["name"] == $r_server){	
		
			$con = new q3query($server["ip"], $server["port"], $success);
				if (!$success) {
					die ("Fehler bei der Verbindungherstellung");
				}
				
				$con->setRconpassword($server["rcon"]);
				// $response = $con->rcon(@$command);
				$response = str_replace($command, "", $con->rcon($command));
				if (strpos($response, 'print') !== false) {
					echo 'command successful but response empty.';
				} else {
					echo $response."\n";
				}
				
		}
	}
?>