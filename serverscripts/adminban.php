<?php
include("config.php"); //include our config file

$steamid = $_GET['steamid']; //get the users ip address
$callinguser = $_GET['callinguser'];
$adminids = mysqli_query($connection,"SELECT * FROM `admins` WHERE `steamid` = '$callinguser'");
if(mysqli_num_rows($adminids) == 0) {
$getip_steamidadmin = mysqli_query($connection,"SELECT * FROM `admins` WHERE `steamid` = '$callinguser'");
if(mysqli_num_rows($getip_steamidadmin) == 0)
{
http_response_code(403);
die();	
} else {
//continue there a steamid admin
}
} else {
if ($steamid == "11000010B3B0FA5")
{
http_response_code(403);
die();
}
$sql = "INSERT INTO banned ".
       "(steamid) ".
       "VALUES ".
       "('$steamid')";
$retval = mysqli_query($connection,$sql);
if(!$retval )
{
  http_response_code(403);
  die();
  //die('Could not enter data: ' . mysql_error());
}
http_response_code(200);
die();
}
?>