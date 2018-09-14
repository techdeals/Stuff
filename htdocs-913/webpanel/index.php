<!DOCTYPE html>
<html lang="en">

<?php 


include("acp/inc/config.php"); 
?>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="FiveM Webmanager by Slluxx">
    <meta name="author" content="Slluxx">
    <link rel="icon" type="image/png" sizes="16x16" href="assets/images/favicon.png">
    <title><?php echo $websiteTitle; ?></title>
    <!-- Bootstrap Core CSS -->
    <link href="acp/assets/bower_components/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Menu CSS -->
    <link href="acp/assets/bower_components/metisMenu/dist/metisMenu.min.css" rel="stylesheet">
    <!-- Menu CSS -->
    <!-- <link href="assets/bower_components/morrisjs/morris.css" rel="stylesheet"> -->
    <!-- Custom CSS -->
    <link href="acp/assets/css/style.css" rel="stylesheet">
	<script src="acp/assets/js/hexconvert.js"></script>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>


<?php
	  
	ini_set('default_socket_timeout', $timeoutAfterSeconds);
	foreach ($servers as &$server) {
		//echo $server;
		$url = "http://".$server["ip"].":".$server["port"]."/players.json";
		$json = @file_get_contents($url); // this WILL do an http request for you
		// if($json === FALSE ){ echo "<script type='text/javascript'>alert('".$server["name"]." might be down or hard to reach.')</script>";}
		$data = json_decode($json);
		$server["players"] = $data;
	}
?>

<body>
    <!-- Preloader -->
    <div class="preloader">
        <div class="cssload-speeding-wheel"></div>
    </div>
    <div id="wrapper">
        <!-- Navigation -->
		       <nav class="navbar navbar-default navbar-static-top" style="margin-bottom: 0">
            <div class="navbar-header"> <a class="navbar-toggle hidden-sm hidden-md hidden-lg " href="javascript:void(0)" data-toggle="collapse" data-target=".navbar-collapse"><i class="ti-menu"></i></a>
                <div class="top-left-part"><a class="logo" href="index.php"><i class="glyphicon glyphicon-fire"></i>&nbsp;<span class="hidden-xs"><?php echo $websiteTitle; ?></span></a></div>
                <ul class="nav navbar-top-links navbar-left hidden-xs">
                    <li><a href="javascript:void(0)" class="open-close hidden-xs hidden-lg waves-effect waves-light"><i class="ti-arrow-circle-left ti-menu"></i></a></li>
                </ul>
            </div>
            <!-- /.navbar-header -->
            <!-- /.navbar-top-links -->
            <!-- /.navbar-static-side -->
        </nav>
        <div class="navbar-default sidebar nicescroll" role="navigation">
            <div class="sidebar-nav navbar-collapse ">
                <ul class="nav" id="side-menu">
				
				
				
				
					<!-- https://themify.me/themify-icons -->
                    <li><a href="index.php" class="waves-effect"><i class="ti-user fa-fw"></i> Playerlist</a></li>
					<li><a href="acp/index.php" class="waves-effect"><i class="ti-lock fa-fw"></i> ACP login</a></li>
					
					
					
					
					
                </ul>
            </div>
            <!-- /.sidebar-collapse -->
        </div>
        <!-- Page Content -->
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-12">
                        <h4 class="page-title"><?php echo $websiteTitle; ?></h4>
                        <ol class="breadcrumb">
                            <li><a href="#">Playerlist</a></li>
                        </ol>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!-- row -->
                <div class="row">
                    <div class="col-sm-12" id="container">
					
						<script type="text/javascript">
							var servers = <?php echo json_encode($servers) ?>;
							var groups = <?php echo json_encode($groups) ?>;
							
							var container = "";
							console.log(servers);
							console.log(groups);
							
							for (var server in servers) {
								// skip loop if the property is from prototype
								
								var whitebox = document.createElement("div");
								whitebox.className = "white-box";
								
								var title = document.createElement("h3");
								title.innerHTML = servers[server].name;
								
								var tablediv = document.createElement("div");
								tablediv.className = "table-responsive table-sm";
								
								var table = document.createElement("table");
								table.className = "table table-sm";
								table.id = servers[server].name;
								
								var tablehead = document.createElement("thead");
								var tablehead_tr = document.createElement("tr");
								tablehead_tr.innerHTML = "<th width='10%' >ID</th><th width='25%' >Name</th><th width='15%' >Ping</th>";
								
								tablehead.appendChild(tablehead_tr);
								table.appendChild(tablehead);
								tablediv.appendChild(table);
								whitebox.appendChild(title);
								whitebox.appendChild(tablediv);
								
								container = document.getElementById("container");
								container.appendChild(whitebox);
								
								// redefine table to add body
								table = document.getElementById(servers[server].name);
								var tablebody = document.createElement("tbody");
								table.appendChild(tablebody);
								var tbody = document.getElementById(servers[server].name).childNodes[1];
								
								// now insert players					
								for (var player in servers[server].players) {
									var tag = "";
									
									var tr = document.createElement("tr");
									var identifiers = servers[server].players[player].identifiers[0];
									var identifiers_org = servers[server].players[player].identifiers[0];
									if (identifiers.indexOf("steam:") >= 0) {
										identifiers = identifiers.replace("steam:", "");
										identifiers = hexToDec(identifiers)
										identifiers_realsteam = "steam:" + identifiers;
										
										for (var group in groups) {
											for (var member in groups[group].members) {
												if (groups[group].members[member].steam == identifiers_realsteam) {
													tag = "<span class='" + groups[group].class + "'>[" + groups[group].name + "]</span>";
													
												}
											}
										}
										
										identifiers = identifiers_org + " <a href='https://steamcommunity.com/profiles/" + identifiers + "'>(Profile)</a>";
									} else {
										var identifiers = servers[server].players[player].identifiers[0];
									}

									
									var s_p_id 		= "<td width='15%' >" + servers[server].players[player].id + "</td>";
									var s_p_name 	= "<td width='30%' >" + servers[server].players[player].name + "  " + tag + "</td>";
									var s_p_ping	= "<td width='15%' >" + servers[server].players[player].ping + "</td>";
									tr.innerHTML 	= s_p_id + s_p_name + s_p_ping;
									tbody.appendChild(tr);
									
									group = "";
								}				
							}
						</script>
                    </div>
                </div>
            </div>
            <!-- /.container-fluid -->
        </div>
        <!-- /#page-wrapper -->


            <footer class="footer text-center"> 2018 &copy; by Slluxx </footer>
    </div>
    <!-- /#wrapper -->
    <!-- jQuery -->
    <script src="acp/assets/bower_components/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap Core JavaScript -->
    <script src="acp/assets/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- Menu Plugin JavaScript -->
    <script src="acp/assets/bower_components/metisMenu/dist/metisMenu.min.js"></script>
    <!--Nice scroll JavaScript -->
    <script src="acp/assets/js/jquery.nicescroll.js"></script>
    <!--Morris JavaScript -->
    <script src="acp/assets/bower_components/raphael/raphael-min.js"></script>
    <!-- <script src="assets/bower_components/morrisjs/morris.js"></script>-->
    <!--Wave Effects -->
    <script src="acp/assets/js/waves.js"></script>
    <!-- Custom Theme JavaScript -->
    <script src="acp/assets/js/myadmin.js"></script>
</body>

</html>
