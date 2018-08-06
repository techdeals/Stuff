<?php
include("config.php"); //include our config file

$steamid = $_GET['steamidvar']; //get the users ip address
//die(print_r($ip,true));
$getip_banid = mysqli_query($connection,"SELECT * FROM `banned` WHERE `steamid` = '$steamid'"); #select the IP from the database
//$result = $getip_banid->fetch_assoc();
if(mysqli_num_rows($getip_banid) > 0)
{
http_response_code(403);
die();
} else {
http_response_code(200);
//allowed to continue not banned!
}

// $getip_whitelist = mysql_query("SELECT * FROM `whitelist` WHERE `ip` = '$ip'"); #select the IP from the database
// if(mysql_num_rows($getip_whitelist) > 0)
// {
// http_response_code(200);
// die();
// } else {
// $getip_whitelist_steamid = mysql_query("SELECT * FROM `whitelist` WHERE `steamid` = '$ip'"); #select the IP from the database
// if(mysql_num_rows($getip_whitelist_steamid) > 0)
// {
// http_response_code(200);
// die();
// } else {
// http_response_code(403);
// die();
// }
// //don't disqualify yet! could be listed as steamid!
// }
//if the user's ip address is in the database, then kill the script, and tell them that they are banned
?>