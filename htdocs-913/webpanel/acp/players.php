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

	  
	ini_set('default_socket_timeout', $timeoutAfterSeconds);
	foreach ($servers as &$server) {
		//echo $server;
		$url = "http://".$server["ip"].":".$server["port"]."/players.json";
		$json = @file_get_contents($url); // this WILL do an http request for you
		if($json === FALSE ){ echo "<script type='text/javascript'>alert('".$server["name"]." might be down or hard to reach.')</script>";}
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
		<?php include("inc/nav.php");?>
        <!-- Page Content -->
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row bg-title">
                    <div class="col-lg-12">
                        <h4 class="page-title">Players</h4>
                        <ol class="breadcrumb">
                            <li><a href="#">Dashboard</a></li>
                            <li class="active">Players</li>
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
								tablehead_tr.innerHTML = "<th width='10%' >ID</th><th width='25%' >Name</th><th width='40%' >Identifier</th><th width='15%' >Ping</th><th width='25%' ></th>";
								
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
									var s_p_steam	= "<td width='40%' >" + identifiers + "</td>";
									var s_p_ping	= "<td width='15%' >" + servers[server].players[player].ping + "</td>";
									var s_p_action	= "<td width='15%' ><a href='#' class='btn btn-warning btn-xs' role='button' aria-pressed='true' onclick='showModal(" + servers[server].players[player].id + ")'>Action</a></td>"
									tr.innerHTML 	= s_p_id + s_p_name + s_p_steam + s_p_ping + s_p_action;
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
		

		<script>
			function showModal(playerID) {
				
				for (var server in servers) {
					for (var player in servers[server].players) {
						if ( servers[server].players[player].id == playerID) {
							
							var identifiers = servers[server].players[player].identifiers[0];
							var identifiers_org = servers[server].players[player].identifiers[0];
							if (identifiers.indexOf("steam:") >= 0) {
								identifiers = identifiers.replace("steam:", "");
								identifiers_stripped = identifiers;
								identifiers = hexToDec(identifiers)
								identifiers = "steam:" + identifiers;
							} else if (identifiers.indexOf("license:") >= 0) {
								identifiers_stripped = identifiers;
								identifiers_stripped = identifiers_stripped.replace("license:", "");
							} else {
								
							}
							
							document.getElementById("modal_username").value = servers[server].players[player].name;
							document.getElementById("modal_steam_fivem").value = identifiers_org;
							document.getElementById("modal_steam_real").value = identifiers;
							
							
							if (identifiers.indexOf("steam:") >= 0) {
								identifiers = identifiers.replace("steam:", "");
								document.getElementById("steamprofileurl").href = "https://steamcommunity.com/profiles/" + identifiers;
							} else {
								document.getElementById("steamprofileurl").href = "#"
							}
							
							
							// disable both buttons before checking rights
							document.getElementById("modal_action_kick").setAttribute("disabled", true);
							document.getElementById("modal_action_ban").setAttribute("disabled", true);
							// check for kick right
							for (var group in groups) {
								for (var member in groups[group].members) {
									if (groups[group].members[member].username == "<?php echo $_SESSION['username'] ?>") {
										for (var right in groups[group].rights){
											if (groups[group].rights[right] == "kick") {
												document.getElementById("modal_action_kick").removeAttribute("disabled");
												document.getElementById("modal_action_kick").href = "players_action.php?action=clientkick&steam=" + identifiers_stripped + "&pass=sincislovesincislife";
											}
										}
										
									}
								}
							}
							// check for ban right
							for (var group in groups) {
								for (var member in groups[group].members) {
									if (groups[group].members[member].username == "<?php echo $_SESSION['username'] ?>") {
										for (var right in groups[group].rights){
											if (groups[group].rights[right] == "ban") {
												document.getElementById("modal_action_ban").removeAttribute("disabled");
												document.getElementById("modal_action_ban").href  = "players_action.php?action=tempbanclient&steam=" + identifiers_stripped + "&pass=sincislovesincislife";
											}
										}
										
									}
								}
							}							
							
							
							
							var base_kick_url = document.getElementById("modal_action_kick").href;
							var base_ban_url = document.getElementById("modal_action_kick").href;
							
							var custom_kick_message = ""
							$( "#modal_custom_message" ).bind('input', function(){
								custom_message = document.getElementById("modal_custom_message").value
								document.getElementById("modal_action_kick").href = base_kick_url + "&message=" + custom_message
								document.getElementById("modal_action_ban").href = base_ban_url + "&message=" + custom_message
							});
							$('#exampleModalCenter').modal('show');
						}
					}
				}	
			}
		</script>
		<!-- Modal -->
		<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
		  <div class="modal-dialog" role="document">
			<div class="modal-content">
			  <div class="modal-header">
				<h5 class="modal-title" id="exampleModalLongTitle">Player action.</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				  <span aria-hidden="true">&times;</span>
				</button>
			  </div>
			  <div class="modal-body">
				<div class="row">
                    <div class="col-lg-5">
					  <div class="form-group">
						<label for="exampleInputEmail1">Username</label>
						<input type="text" class="form-control" id="modal_username" readonly>
					  </div>
					  <div class="form-group">
						<label for="exampleInputPassword1">SteamID (FiveM) or IP</label>
						<input type="text" class="form-control" id="modal_steam_fivem" readonly>
					  </div>
					  <div class="form-group">
						<label for="exampleInputPassword1">SteamID (Real)</label>
						<input type="text" class="form-control" id="modal_steam_real" readonly>
					  </div>
					</div>
					<div class="col-lg-1"></div>
					<div class="col-lg-5">
						</br>
						<p>Visit the Steam profile <a id='steamprofileurl' href=''>HERE</a></p>
					</div>
				</div>
				<hr>
				<div class="row">
                    <div class="col-lg-12">	
					  <div class="form-group">
						<label for="exampleInputEmail1">Custom kick/ban message</label>
						<input type="text" class="form-control" id="modal_custom_message">
					  </div>
	
					</div>
				</div>
			  </div>
			  <div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				<a id="modal_action_kick" href='#' type="button" class="btn btn-warning">Kick</a>
				<a id="modal_action_ban" href='#' type="button" class="btn btn-danger">Ban</a>
				
				
			  </div>
			</div>
		  </div>
		</div>


    <?php include("inc/footer.php");?>
</body>

</html>
