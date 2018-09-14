<?php

/**
Open source CAD system for RolePlaying Communities.
Copyright (C) 2017 Shane Gill

This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

This program comes with ABSOLUTELY NO WARRANTY; Use at your own risk.
**/

include("./oc-config.php");
require("./actions/api.php");
session_start();

if (empty($_SESSION['logged_in']))
{
	header('Location: ./index.php');
    die("Not logged in");
}
    setDispatcher("1");

/*
    The purpose of this page is to simply determine if the user has multiple roles.
    If they do, provide them the option to go where they want to go.
    Else, redirect to the only place they can go.
*/

ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

$link = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);

if (!$link) {
    die('Could not connect: ' .mysql_error());
}

$id = $_SESSION['id'];
$sql = "SELECT * from user_departments WHERE user_id = \"$id\"";
$getAdminPriv = "SELECT `admin_privilege` from users WHERE id = \"$id\"";

$result=mysqli_query($link, $sql);
$adminPriv=mysqli_query($link, $getAdminPriv);


$adminButton = "";
$dispatchButton = "";
$highwayButton = "";
$stateButton = "";
$fireButton = "";
$emsButton = "";
$sheriffButton = "";
$policeButton = "";
$civilianButton = "";

$num_rows = $result->num_rows;
if($num_rows < 2)
{
    while($row = mysqli_fetch_array($result, MYSQLI_BOTH))
    {
			if ($row[1] == "1")
        {
            $_SESSION['dispatch'] = 'YES';
            header("Location:".BASE_URL."/cad.php");

        }
				else if ($row[1] == "2")
				{
						$_SESSION['state'] = 'YES';
						header("Location:".BASE_URL."/mdt.php?dep=state");
				}
				else if ($row[1] == "3")
				{
						$_SESSION['highway'] = 'YES';
						header("Location:".BASE_URL."/mdt.php?dep=highway");
				}
				else if ($row[1] == "4")
				{
						$_SESSION['sheriff'] = 'YES';
						header("Location:".BASE_URL."/mdt.php?dep=sheriff");
				}
				else if ($row[1] == "5")
        {
            $_SESSION['police'] = 'YES';
            header("Location:".BASE_URL."/mdt.php?dep=police");
        }
				else if ($row[1] == "6")
				{
				$_SESSION['fire'] = 'YES';
				header("Location:".BASE_URL."/mdt.php?dep=fire");
				}
        else if ($row[1] == "7")
        {
            $_SESSION['ems'] = 'YES';
            header("Location:".BASE_URL."/mdt.php?dep=ems");
        }
        else if ($row[1] == "8")
        {
            $_SESSION['civilian'] = 'YES';
            header("Location:".BASE_URL."/civilian.php");
        }
    }
}
else
{

    while($row = mysqli_fetch_array($result, MYSQLI_BOTH))
    {
        if ($row[1] == "1")
        {
            $_SESSION['dispatch'] = 'YES';
            $dispatchButton = "<a href=\"".BASE_URL."/cad.php\" class=\"btn btn-lg cusbtn animate fadeInLeft delay1\"><strong>Dispatch   \xF0\x9F\x94\x8A  </a>";
        }
        if ($row[1] == "7")
        {
            $_SESSION['ems'] = 'YES';
						$emsButton = "<a href=\"".BASE_URL."/mdt.php?dep=ems\" class=\"btn btn-lg cusbtn animate fadeInLeft delay1\"><strong>New Orleans | EMS     \xF0\x9F\x9A\x91</a>";
        }
        if ($row[1] == "6")
        {
            $_SESSION['fire'] = 'YES';
						$fireButton = "<a href=\"".BASE_URL."/mdt.php?dep=fire\" class=\"btn btn-lg cusbtn animate fadeInLeft delay1\"><strong>New Orleans | Fire   \xF0\x9F\x9A\x92</a>";
        }
			/*if ($row[1] == "3")
			{
				$_SESSION['highway'] = 'YES';
				$highwayButton = "<a href=\"".BASE_URL."/mdt.php?dep=highway\" class=\"btn btn-lg cusbtn animate fadeInLeft delay1\">Highway Patrol</a>";
			}*/
        if ($row[1] == "5")
        {
            $_SESSION['police'] = 'YES';
            $policeButton = "<a href=\"".BASE_URL."/mdt.php?dep=police\" class=\"btn btn-lg cusbtn animate fadeInLeft delay1\"><strong>New Orleans Police Dept.   \xF0\x9F\x9A\x94     </a>";        }
			
			
			if ($row[1] == "4")
			{
				$_SESSION['sheriff'] = 'YES';
				$sheriffButton = "<a href=\"".BASE_URL."/mdt.php?dep=sheriff\" class=\"btn btn-lg cusbtn animate fadeInLeft delay1\"><strong>Community Police\xF0\x9F\x91\x93</a>";
			}
			
			
			
        if ($row[1] == "2")
        {
            $_SESSION['state'] = 'YES';
            $stateButton = "<a href=\"".BASE_URL."/mdt.php?dep=state\" class=\"btn btn-lg cusbtn animate fadeInLeft delay1\"><strong>Louisiana State Police   \xF0\x9F\x9B\x82    </a>";
        }
        if ($row[1] == "8")
        {
            $_SESSION['civillian'] = 'YES';
            $civilianButton = "<a href=\"".BASE_URL."/civilian.php\" class=\"btn btn-lg cusbtn animate fadeInLeft delay1\"><strong>Civilian  \xF0\x9F\x91\xAC  </a>";
        }
    }
}
$adminRows = $adminPriv->num_rows;
if($adminRows < 2)
{
	while($adminRow = mysqli_fetch_array($adminPriv, MYSQLI_BOTH))
	{
		if ($adminRow[0] == "2")
		{
			$adminButton = "<a href=\"".BASE_URL."/oc-admin/admin.php\" class=\"btn btn-lg cusbtn animate fadeInLeft delay1\"><strong>Admin  \xF0\x9F\x93\x9B        </a>";
		}
		if ($adminRow[0] == "1")
		{
			$adminButton = "<a href=\"".BASE_URL."/oc-admin/moderator.php\" class=\"btn btn-lg cusbtn animate fadeInLeft delay1\">Moderator</a>";
		}
	}
}

mysqli_close($link);


?>

<html lang="en">
   <!DOCTYPE html>
   <?php include "./oc-includes/header.inc.php"; ?>
   <body id="body">
      <div id="page-wrapper">
         <div class="container-fluid">
            <div class="row">
               <div class="col-lg-12">
                  <h1 class="page-header animate fadeInLeft delay2" style="text-align:center;"><strong><i><small>Welcome to the</i></small> LossRP <small>CAD/MDT System</h1>
               </div>
               <!-- ./ col-lg-12 -->
            </div>
            <!-- ./ row -->
            </div class="row">
            <div class="col-lg-12">
                <div id="buttongroup">
                &nbsp;
               <?php echo $adminButton;?>
               </div>
               &nbsp;
							 <div id="buttongroup">
							 <?php echo $sheriffButton;?>
							 <?php echo $highwayButton;?>
							 <?php echo $stateButton;?>
							 <?php echo $policeButton;?>
							 </div>
							 &nbsp;
               <div id="buttongroup">
               <?php echo $dispatchButton;?>
               </div>
               &nbsp;
               <div id="buttongroup">
               <?php echo $fireButton;?>
			   	 			<?php echo $emsButton;?>
               </div>
               &nbsp;
							 <div id="buttongroup">
							 <?php echo $civilianButton;?>
							 </div>
							 &nbsp;
             </div>
            <!-- ./ col-lg-12 -->
         </div>
         <!-- ./ row -->
      </div>
      <!-- ./ container-fluid -->
      </div>
      <!-- ./ page-wrapper -->
   </body>
</html>

