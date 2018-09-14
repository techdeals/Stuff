<?php 
session_start();
?>


<!DOCTYPE html>
<html>


<?php
if (isset($_GET["logout"])){
	// Löschen aller Session-Variablen.
	$_SESSION = array();

	// Falls die Session gelöscht werden soll, löschen Sie auch das
	// Session-Cookie.
	// Achtung: Damit wird die Session gelöscht, nicht nur die Session-Daten!
	if (ini_get("session.use_cookies")) {
		$params = session_get_cookie_params();
		setcookie(session_name(), '', time() - 42000, $params["path"],
			$params["domain"], $params["secure"], $params["httponly"]
		);
	}

	// Zum Schluß, löschen der Session.
	session_destroy();
	header( "refresh:0;url=login.php" );
	die();
}



include("inc/config.php"); 
	 // include("inc/head.php");
	 
	$login = 0;
	if (isset($_POST["username"])){
		$login_user = $_POST["username"];
		$login++;
	}
	if (isset($_POST["password"])){
		if ($_POST["password"] == "" or $_POST["password"] == " "){
				header( "refresh:0;url=login.php?failedlogin=true" );
			die();
		}
		$login_pass = $_POST["password"];
		$login++;
	}
	
	if ($login == 2) {
		
	foreach ($groups as &$group) {
		foreach ($group["members"] as &$member) {
			if($member["username"] == $login_user && $member["password"] == sha1($login_pass)){
				foreach ($group["rights"] as &$right) {
					if ($right == "login") {
						$_SESSION['username'] = $member["username"];
						header( "refresh:0;url=index.php" );
						die();
					}
				}
				header( "refresh:0;url=login.php?norights=true");
				die();
			}
		}
	}
	
		
		header( "refresh:0;url=login.php?failedlogin=true");
	}
?>


<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" type="image/png" sizes="16x16" href="assets/images/favicon.png">
    <title><?php echo $websiteTitle; ?></title>
    <!-- Bootstrap Core CSS -->
    <link href="assets/bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
      <div class="container">
	  	  <div class="row">
		<div class="col-lg-4"></div>
		  <div class="col-lg-4">  
			</br><h1 class="text-center"><?php echo $websiteTitle; ?></h1>
		  </div>
		<div class="col-lg-4"></div>
	  </div>
	  
	  <div class="row">
	  <div class="col-lg-4"></div>
                    <div class="col-lg-4">
	  
	  </br>
<?php
if (isset($_GET["failedlogin"])){
	echo "<div class='alert alert-danger' role='alert'>Login failed. </br>Please try another username or password.</div>";
}
if (isset($_GET["norights"])){
	echo "<div class='alert alert-danger' role='alert'>Login failed. </br>You need more rights to log in.</div>";
}
?>
      <form class="form-signin" action="login.php" method="post">
        <h2 class="form-signin-heading">Please sign in</h2>
        <label for="username" class="sr-only">Email address</label>
        <input type="text" id="username" name="username" class="form-control" placeholder="Username" required autofocus>
		</br>
        <label for="password" class="sr-only">Password</label>
        <input type="password" id="password" name="password" class="form-control" placeholder="Password" required>
		</br>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
      </form>

	  </div>
	  <div class="col-lg-4"></div>
	  
	  </div>
	  
	  
	  <div class="row">
		<div class="col-lg-4"></div>
		  <div class="col-lg-4">  
			</br><p class="text-center"><a href="../index.php">Back home</a></p>
		  </div>
		<div class="col-lg-4"></div>
	  </div>
    </div> <!-- /container -->
  </body>
</body>

</html>
