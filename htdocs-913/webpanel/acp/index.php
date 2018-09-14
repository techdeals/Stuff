<?php 
session_start();
if(!isset($_SESSION['username'])) {
header( "refresh:0;url=login.php" );
die();
}
?>

<!DOCTYPE html>
<html lang="en">

<?php
include("inc/config.php");
include("inc/head.php");
?>

<body>
    <!-- Preloader -->
    <div class="preloader">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
        <!-- Navigation -->
		<?php include("inc/nav.php");?>
        <!-- Page Content -->
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-12">
                        <h4 class="page-title">Welcome back, <?php echo $_SESSION['username']; ?></h4>
                        <ol class="breadcrumb">
                            <li><a href="#">Dashboard</a></li>
                        </ol>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
                <div class="row">
				<?php
					ini_set('default_socket_timeout', $timeoutAfterSeconds);
					
					foreach ($servers as &$server) {
						$url = "http://".$server["ip"].":".$server["port"]."/players.json";
						$json = @file_get_contents($url); // this WILL do an http request for you
						if($json === FALSE ){
							echo "
							<div class='col-xs-6 col-md-3'>
								<div class='panel status panel-danger'>
									<div class='panel-heading'>
										<h1 class='panel-title text-center'>Offline</h1>
									</div>
									<div class='panel-body text-center'>                        
										<strong>".$server["name"]."</strong>
									</div>
								</div>
							</div>  
							";
						} else {
							echo "
							<div class='col-xs-6 col-md-3'>
								<div class='panel status panel-success'>
									<div class='panel-heading'>
										<h1 class='panel-title text-center'>Online</h1>
									</div>
									<div class='panel-body text-center'>                        
										<strong>".$server["name"]."</strong>
									</div>
								</div>
							</div>  
							";
						}
					}
					?>
	
						
						
						
                </div>
                <!-- /.row -->
            </div>
            <!-- /.container-fluid -->
        </div>
        <!-- /#page-wrapper -->
	<?php include("inc/footer.php");?>
</body>

</html>
