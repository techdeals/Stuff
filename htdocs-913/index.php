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

    require_once(__DIR__ . "/oc-config.php");

    $testing = false; //If set to true, will default some data for you



    session_start();
    $registerError = "";
    $registerSuccess = "";
    $loginMessage = "";

    if ( (isset($_SESSION['logged_in'])) == "YES" )
    {
      header ('Location: ./dashboard.php');
;      //echo $_SESSION['name']." is logged in!";
    }
    if (isset($_GET['loggedOut']))
    {
        $loginMessage = '<div class="alert alert-success" style="text-align: center; font-weight:normal;" ><span>You\'ve successfully been logged out</span></div>';
    }
    if(isset($_SESSION['register_error']))
    {
        $registerError = '<div class="alert alert-danger" style="text-align: center; font-weight:normal;"><span>'.$_SESSION['register_error'].'</span></div>';
        unset($_SESSION['register_error']);
    }
    if(isset($_SESSION['register_success']))
    {
        $registerError = '<div class="alert alert-success" style="text-align: center; font-weight:normal;"><span>'.$_SESSION['register_success'].'</span></div>';
        unset($_SESSION['register_success']);
    }
    if(isset($_SESSION['loginMessageDanger']))
    {
        $loginMessage = '<div class="alert alert-danger" style="text-align: center; font-weight:normal;"><span>'.$_SESSION['loginMessageDanger'].'</span></div>';
        unset($_SESSION['loginMessageDanger']);
    }


?>

<!DOCTYPE html>
<html lang="en">
   <?php include "./oc-includes/header.inc.php"; ?>
   <body class="login">
      <div>
         <a class="hiddenanchor" id="signup"></a>
         <a class="hiddenanchor" id="signin"></a>
		 <a class="hiddenanchor" id="civreg"></a>
         <div class="login_wrapper">
            <div class="animate form login_form civ_login">
               <?php echo $loginMessage;?>
               <section class="login_content">
                  <form role="form" action="<?php echo BASE_URL; ?>/actions/login.php" method="post">
                     <h1>Login Form</h1>
                     <div>
                        <input class="form-control" placeholder="Email" name="email" type="text" value="<?php if($testing){echo "test@test.test";}?>" required>
                     </div>
                     <div>
                        <input class="form-control" placeholder="Password" name="password" type="password" value="<?php if($testing){echo "password";}?>" required >
                     </div>
                     <div>
                        <input name="login_btn" type="submit" class="btn btn-default submit" value="Login" />
                        <a class="reset_pass" href="#" onclick="alert('Request an administrator reset your password through your community.');" >Lost your password?</a>
                     </div>
					 <?php if (CIV_REG === true) { ?>
             <div class="clearfix"></div>
             <div class="separator">
                <p class="change_link">New?
                   <a href="#signup" class="to_register"> Request Access </a>
                </p>
                <p class="change_link">Civilian Only?
                   <a href="#civreg" class="to_register"> Request Access as a LossRP | Civilian </a>
				   <p class="change_link"><small>(No Approval Needed)</small>
                </p>
                <div class="clearfix"></div>
                <br />
                <div>
                   <h1><i class="fa fa-tachometer"></i> <?php echo COMMUNITY_NAME?><a href="http://lossrp.com" target="_blank"><big><strong>LossRP.com</strong></big></a></h1>
				   
				   
                  
				   
                </div>
             </div>
					 <?php } else { ?>
                     <div class="clearfix"></div>
                     <div class="separator">
                        <p class="change_link">New?
                           <a href="#signup" class="to_register"> Request Access </a>
                        </p>
                        <p class="change_link">Civilian Only? Not Enabled
                        </p>
                        <div class="clearfix"></div>
                        <br />
                        <div>
                           <h1><i class="fa fa-tachometer"></i> <?php echo COMMUNITY_NAME?> CAD System</h1>
                        </div>
                     </div>
					 <?php } ?>
                  </form>
               </section>
            </div>
            <div id="register" class="animate form registration_form">
               <section class="login_content">
                  <?php echo $registerError, $registerSuccess;?>
                  <form action="<?php echo BASE_URL; ?>/actions/register.php" method="post">
                     <h1>Request Access</h1>
                     <div>
                        <input class="form-control" placeholder="Name" name="uname" type="text" value="<?php if($testing){echo "Test";}?>" required>
                     </div>
                     <div>
                        <input class="form-control" placeholder="Email" name="email" type="email" value="<?php if($testing){echo "test@test.test";}?>" required>
                     </div>
                     <div>
                        <input class="form-control" placeholder="Identifier (Code Number, Unit ID)" name="identifier" type="text" value="<?php if($testing){echo "1A-1";}?>" required>
                     </div>
                     <div class="form-group">
                        <label>Division (Can choose more than one via Ctrl + Click)</label>
                        <select class="form-control" id="division" name="division[]" multiple="multiple" size="6" required>
                           <option value="civilian">LossRP | Civilian</option>
                           <option value="communications">NOPD Communications (Dispatch)</option>
                           <option value="ems">New Orleans EMS</option>
                           <option value="fire">New Orleans Fire</option>
                           <option value="highway" <?php if($testing){echo "selected=\"selected\"";}?>>Louisiana State Police</option>
                           <option value="police">New Orleans Police Dept.</option>
                           <option value="sheriff">LossRP | Community Police</option>
                        </select>
                     </div>
                     <div class="form-group">
                        <input class="form-control" placeholder="Password" name="password" type="password" value="<?php if($testing){echo "password";}?>" required>
                     </div>
                     <!-- ./ form-group -->
                     <div class="form-group">
                        <input class="form-control" placeholder="Confirm Password" name="password1" type="password" value="<?php if($testing){echo "password";}?>" required>
                     </div>
                     <!-- ./ form-group -->
                     <div class="clearfix"></div>
                     <div>
                        <input name="register" type="submit" class="btn btn-default btn-sm pull-right" value="Request Access" />
                     </div>
                     <div class="clearfix"></div>
                     <div class="separator">
                        <p class="change_link">Already a member?
                           <a href="#signin" class="to_register"> Log in </a>
                        </p>
                        <div class="clearfix"></div>
                        <br />
                        <div>
                           <h1><i class="fa fa-tachometer"></i> <?php echo COMMUNITY_NAME ?> CAD System</h1>
                        </div>
                     </div>
                  </form>
               </section>
            </div>
             <?php if (CIV_REG === true) { ?>
            <div id="civ" class="animate form civilian_form">
               <section class="login_content">
                  <?php echo $registerError, $registerSuccess;?>
                  <form action="<?php echo BASE_URL; ?>/actions/register.php" method="post">
                     <h1>Civilian Registration</h1>
                     <div>
                        <input class="form-control" placeholder="Name" name="uname" type="text" value="<?php if($testing){echo "Test";}?>" required>
                     </div>
                     <div>
                        <input class="form-control" placeholder="Email" name="email" type="email" value="<?php if($testing){echo "test@test.test";}?>" required>
                     </div>
                     <div>
                        <input class="form-control" placeholder="Identifier (Code Number, Unit ID)" name="identifier" type="text" value="<?php if($testing){echo "1A-1";}?>" required>
                     </div>
                     <div class="form-group">
                        <input class="form-control" placeholder="Password" name="password" type="password" value="<?php if($testing){echo "password";}?>" required>
                     </div>
                     <!-- ./ form-group -->
                     <div class="form-group">
                        <input class="form-control" placeholder="Confirm Password" name="password1" type="password" value="<?php if($testing){echo "password";}?>" required>
                     </div>
                     <!-- ./ form-group -->
                     <div class="clearfix"></div>
                     <div>
                        <input name="civreg" type="submit" class="btn btn-default btn-sm pull-right" value="Register" />
                     </div>
                     <div class="clearfix"></div>
                     <div class="separator">
                        <p class="change_link">Already a member?
                           <a href="#signin" class="to_register"> Log in </a>
                        </p>
                        <div class="clearfix"></div>
                        <br />
                        <div>
                           <h1><i class="fa fa-tachometer"></i> <?php echo COMMUNITY_NAME ?> CAD System</h1>
                        </div>
                     </div>
                  </form>
               </section>
            </div>
            <?php } else { ?>
              <div id="civ" class="animate form civilian_form">
                    <?php echo $registerError, $registerSuccess;?>
                       <p>Stop trying to backdoor into OpenCAD
                          This has been logged. </p>
                       <div class="clearfix"></div>
                       <div class="separator">
                          <p class="change_link">Already a member?
                             <a href="#signin" class="to_register"> Log in </a>
                          </p>
                          <div class="clearfix"></div>
                          <div>
                             <h1><i class="fa fa-tachometer"></i> <?php echo COMMUNITY_NAME ?> CAD System</h1>
                          </div>
                       </div>
              </div>
               <?php } ?>
         </div>
      </div>
      <?php include "./oc-includes/jquery-colsolidated.inc.php"; ?>
      <script type="text/javascript">
         $(document).ready(function() {
            // $('#division').multiselect();
         });
      </script>
   </body>
</html>
<script language="JavaScript">
      //////////F12 disable code////////////////////////
          document.onkeypress = function (event) {
              event = (event || window.event);
              if (event.keyCode == 123) {
                 //alert('No F-12');
                  return false;
              }
          }
          document.onmousedown = function (event) {
              event = (event || window.event);
              if (event.keyCode == 123) {
                  //alert('No F-keys');
                  return false;
              }
          }
      document.onkeydown = function (event) {
              event = (event || window.event);
              if (event.keyCode == 123) {
                  //alert('No F-keys');
                  return false;
              }
          }
      var message=":o";      
      function clickIE() {if (document.all) {(message);return false;}}
      function clickNS(e) {if
      (document.layers||(document.getElementById&&!document.all)) {
      if (e.which==2||e.which==3) {(message);return false;}}}
      if (document.layers)
      {document.captureEvents(Event.MOUSEDOWN);document.onmousedown=clickNS;}
      else{document.onmouseup=clickNS;document.oncontextmenu=clickIE;}
      document.oncontextmenu=new Function("return false")
      function disableCtrlKeyCombination(e)
      {
      var forbiddenKeys = new Array('a', 'n', 'c', 'x', 'v', 'j' , 'w');
      var key;
      var isCtrl;
      if(window.event)
      {
      key = window.event.keyCode;
      if(window.event.ctrlKey)
      isCtrl = true;
      else
      isCtrl = false;
      }
      else
      {
      key = e.which;
      if(e.ctrlKey)
      isCtrl = true;
      else
      isCtrl = false;
      }
      if(isCtrl)
      {
      for(i=0; i<forbiddenKeys.length; i++)
      {
      if(forbiddenKeys[i].toLowerCase() == String.fromCharCode(key).toLowerCase())
      {
      alert('Key combination CTRL + '+String.fromCharCode(key) +' has been disabled.');
      return false;
      }
      }
      }
      return true;
      }
   </script>
</head>
</html>