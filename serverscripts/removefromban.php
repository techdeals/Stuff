<?php
include("config.php"); //include our config file

$steamid = $_GET['steamid']; //get the users ip address
$steamidadmin = $_GET['callinguser'];
$getip_admin = mysqli_query($connection,"SELECT * FROM `admins` WHERE `steamid` = '$steamidadmin'"); #select the IP from the database
if(mysqli_num_rows($getip_admin) == 0)
{
$getip_steamidadmin = mysqli_query($connection,"SELECT * FROM `admins` WHERE `steamid` = '$steamidadmin'");
if(mysqli_num_rows($getip_steamidadmin == 0))
{
http_response_code(403);
die();	
} else {
//continue there a steamid admin
}
} else {
//continue there a admin
}
$getip_user = mysqli_query($connection,"DELETE FROM `banned` WHERE `steamid` = '$steamid'"); #remove the IP from the banned database
if($getip_user)
{
http_response_code(200);
die();
} else {
http_response_code(403);
die();
}
//if the user's ip address is in the database, then kill the script, and tell them that they are banned
?>