<?php
include("config.php"); //include our config file

$steamid = $_GET['steamid']; //get the users ip address

$getip = mysqli_query($connection,"SELECT * FROM `admins` WHERE `ip` = '$steamid'"); #select the IP from the database
if(mysqli_num_rows($getip) == 0)
{
//don't disqualify yet! could be listed as steamid!
$getip_whitelist_steamid = mysqli_query($connection,"SELECT * FROM `admins` WHERE `steamid` = '$steamid'"); #select the IP from the database
if(mysqli_num_rows($getip_whitelist_steamid) > 0)
{
http_response_code(200);
die();
} else {
http_response_code(403);
die();
}	
} else {
http_response_code(200);
die();
}
//if the user's ip address is in the database, then kill the script, and tell them that they are banned
?>