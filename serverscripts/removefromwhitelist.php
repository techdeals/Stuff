<?php
include("config.php"); //include our config file

//$ip = $_GET['ip']; //get the users ip address
$ipadmin = $_GET['callinguser'];
$nameofuser = $_GET['nameofuser'];
$getip_admin = mysqli_query($connection,"SELECT * FROM `admins` WHERE `ip` = '$ipadmin'"); #select the IP from the database
if(mysqli_num_rows($getip_admin) == 0)
{
$getip_steamidadmin = mysqli_query($connection,"SELECT * FROM `admins` WHERE `steamid` = '$ipadmin'");
if(mysqli_num_rows($getip_steamidadmin) == 0)
{
http_response_code(403);
die();	
} else {
//continue there a steamid admin
}
} else {
//continue there a admin
}
//die($nameofuser);
$getip_user = mysqli_query($connection,"DELETE FROM whitelist WHERE usernamebelongsto = '$nameofuser';"); #add the IP into the database
if($getip_user)
{
http_response_code(200);
die();
} else {
http_response_code(400);
die();
}
//if the user's ip address is in the database, then kill the script, and tell them that they are banned
?>