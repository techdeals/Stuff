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


	foreach ($groups as &$group) {
		foreach ($group["members"] as &$member) {
			if($member["username"] == $_SESSION['username'] ){
				foreach ($group["rights"] as &$right) {
					if ($right == "rcon") {
						$rightFound = true;
					}
				}
				if(!isset($rightFound)){
					header( "refresh:0;url=index.php");
					die();
				}
			}
		}
	}
	

	
	
	  
if (isset($_POST['server'])) {
	if($_POST['server'] == ""){
		$hideTerminal = true;
		$terminal = "";
	} else {
		$hideTerminal = false;
		$terminal = $_POST['server'];
	}
} else {
	$hideTerminal = true;
	$terminal = "";
}

?>
<link href="assets/css/terminal.css" rel="stylesheet">
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
                        <h4 class="page-title">RCON</h4>
                        <ol class="breadcrumb">
                            <li><a href="#">Dashboard</a></li>
                            <li class="active">RCON</li>
                        </ol>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
                <div class="row">
					<div class="col-lg-4">
						<form action="rcon.php" method="post">
						  <div class="form-group">
							<select class="form-control" id="selectserver" name="server">
							  <option selected disabled hidden>Choose a server ...</option disabled hidden>
							</select>
						  </div>
					</div>
					<div class="col-lg-1">
						<button type="submit" class="btn btn-info" style="padding-top: 10px;">SET</button>
						</form>
					</div>
					<div class="col-lg-7">
						<p>- <a href='https://wiki.fivem.net/wiki/Administering_your_Dedicated_Server#clientkick'>Rcon commands</a> start with "rcon". Eg. <b>rcon status</b> or <b>rcon tempbanclient 43 cheating</b></br>
						- <a href='https://wiki.fivem.net/wiki/Event:RconCommand'>How to create custom rcon commands</a></br>
						- For help type <b>help</b></p>
						</form>
					</div>
                </div>
				<script type="text/javascript">
				var servers = <?php echo json_encode($servers) ?>;
				var groups = <?php echo json_encode($groups) ?>;
					for (var server in servers) {
						var list = document.getElementById("selectserver");
						var option = document.createElement("option");
						option.text = servers[server].name;
						option.value = servers[server].name;
						option.name = servers[server].name;
						if(servers[server].name == "<?php echo $terminal; ?>"){
						option.selected = true;
						list.options[0].selected = false
						}
						list.add(option);
					}
					
					
				
				</script>
				
				<?php
				if($hideTerminal == false){
					echo "
					</br>
					<div class='row'>
						<div class='col-lg-12'>
							<div class='window'>
								<div class='handle'>
										<span class='title'></span>
								</div>
								<div class='terminal' id='myterminal'></div>
							</div>
						</div>
					</div>
					
					";
				}
				?>
                
				

                <!-- /.row -->
            </div>
            <!-- /.container-fluid -->
        </div>
        <!-- /#page-wrapper -->
		
		
	<?php include("inc/footer.php");?>
	<script src='assets/js/stopExecutionOnTimeout.js'></script>
	<script >/*
//	Made with <3 by Marcus Bizal
//	github.com/marcbizal
//	linkedin.com/in/marcbizal
*/

$(document).ready(function() {
		"use strict";
		if ("<?php echo $hideTerminal; ?>" == true) {
			return false;
		}
		
			function updateScroll(){
				var element = document.getElementById("myterminal");
				element.scrollTop = element.scrollHeight;
			}
					
		// Get chosen server variables
		var serverName = "";
		var serverIP = "";
		var serverPort = "";
		var serverRcon = "";
		
		for (var server in servers) {
			if(servers[server].name == ""){
				
			}else if(servers[server].name == "<?php echo $terminal; ?>"){
				serverName = servers[server].name;
				serverIP = servers[server].ip;
				serverPort = servers[server].port;
				serverRcon = servers[server].rcon;
				
			}
		}
		if (serverName == ""){
			console.log("Servername undefined!")
			return false;
		}

		// UTILITY
		function getRandomInt(min, max) {
				return Math.floor(Math.random() * (max - min)) + min;
		}
		// END UTILITY

		// COMMANDS
		function clear() {
				terminal.text("");
		}

		function help() {
				terminal.append("start		-	Starts the resource specified in the argument, if it was stopped.\n"+
								"stop		-	Stops the resource specified in the argument, if it was started.\n"+
								"restart		-	Restarts the resource specified in the argument, if it was started.\n"+
								"refresh		-	Rescans the resources folder and loads all __resource.lua files\n"+
								"			in them, making new resources available to start using start.\n"+
								"status		-	Shows a list of players with their primary identifier, server ID, \n"+
								"			name, endpoint, and ping.\n"+
								"clientkick	-	Kicks the client with the specified server ID (as seen in status) from \n"+
								"			the server, for the stated reason.\n"+
								"tempbanclient	-	Kicks the client with the specified server ID, and prevents them from \n"+
								"			reconnecting until the server is restarted.\n"+
								"say		-	Sends a message in the chat as console.\n");
								
		}
			
		
		function sendrcon(args){
			// var args = args.join(" ");
			var xhr = new XMLHttpRequest();
				xhr.open('GET', "rcon/rcon.php?securitykey=<?php echo $securityKey;?>&server="+serverName+"&command="+args, false);
				xhr.send(null);

				if (xhr.status === 200) {
						var fortunes = xhr.responseText.split("%");
						var fortune = fortunes[getRandomInt(0, fortunes.length)].trim();
						terminal.append(fortune + "\n");
				}
		}
		
		function echo(args) {
				var str = args.join(" ");
				terminal.append(str + "\n");
		}

		function fortune() {
				var xhr = new XMLHttpRequest();
				xhr.open('GET', 'https://cdn.rawgit.com/bmc/fortunes/master/fortunes', false);
				xhr.send(null);

				if (xhr.status === 200) {
						var fortunes = xhr.responseText.split("%");
						var fortune = fortunes[getRandomInt(0, fortunes.length)].trim();
						terminal.append(fortune + "\n");
				}
		}
		// END COMMANDS

		var title = $(".title");
		var terminal = $(".terminal");
		var prompt = "➜";
		var path = "~";

		var commandHistory = [];
		var historyIndex = 0;

		var command = "";
		var commands = [{
						"name": "clear",
						"function": clear
				}, {
						"name": "help",
						"function": help
				}, {
						"name": "fortune",
						"function": fortune
				}, {
						"name": "echo",
						"function": echo
				}, {
						"name": "rcon",
						"function": sendrcon
				}
				];

function processCommand() {
		var isValid = false;

		// Create args list by splitting the command
		// by space characters and then shift off the
		// actual command.

		var args = command.split(" ");
		var cmd = args[0];
		args.shift();

		// Iterate through the available commands to find a match.
		// Then call that command and pass in any arguments.
		for (var i = 0; i < commands.length; i++) {if (window.CP.shouldStopExecution(1)){break;}
				if (cmd === commands[i].name) {
						commands[i].function(args);
						isValid = true;
						break;
				}
		}
window.CP.exitedLoop(1);


		// No match was found...
		if (!isValid) {
				terminal.append("terminal: command not found: " + command + "\n");
		}

		// Add to command history and clean up.
		commandHistory.push(command);
		historyIndex = commandHistory.length;
		command = "";
		
		// scroll down
		updateScroll();
}

function displayPrompt() {
		terminal.append("<span class=\"prompt\">" + prompt + "</span> ");
		terminal.append("<span class=\"path\">" + path + "</span> ");
}

// Delete n number of characters from the end of our output
function erase(n) {
		command = command.slice(0, -n);
		terminal.html(terminal.html().slice(0, -n));
}

function clearCommand() {
		if (command.length > 0) {
				erase(command.length);
		}
}

function appendCommand(str) {
		terminal.append(str);
		command += str;
}

/*
	//	Keypress doesn't catch special keys,
	//	so we catch the backspace here and
	//	prevent it from navigating to the previous
	//	page. We also handle arrow keys for command history.
	*/

$(document).keydown(function(e) {
		e = e || window.event;
		var keyCode = typeof e.which === "number" ? e.which : e.keyCode;

		// BACKSPACE
		if (keyCode === 8 && e.target.tagName !== "INPUT" && e.target.tagName !== "TEXTAREA") {
				e.preventDefault();
				if (command !== "") {
						erase(1);
				}
		}

		// UP or DOWN
		if (keyCode === 38 || keyCode === 40) {
			updateScroll();
				// Move up or down the history
				if (keyCode === 38) {
						// UP
						historyIndex--;
						if (historyIndex < 0) {
								historyIndex++;
						}
				} else if (keyCode === 40) {
						// DOWN
						historyIndex++;
						if (historyIndex > commandHistory.length - 1) {
								historyIndex--;
						}
				}

				// Get command
				var cmd = commandHistory[historyIndex];
				if (cmd !== undefined) {
						clearCommand();
						appendCommand(cmd);
				}
		}
});

$(document).keypress(function(e) {
		// Make sure we get the right event
		e = e || window.event;
		var keyCode = typeof e.which === "number" ? e.which : e.keyCode;

		// Which key was pressed?
		switch (keyCode) {
				// ENTER
				case 13:
						{
								terminal.append("\n");

								processCommand();
								displayPrompt();
								break;
						}
				default:
						{
								appendCommand(String.fromCharCode(keyCode));
						}
		}
});

// Set the window title
title.text("<?php echo $_SESSION['username']; ?>@<?php echo $terminal; ?>: ~ (rcon)");

// Get the date for our fake last-login
var date = new Date().toString(); date = date.substr(0, date.indexOf("GMT") - 1);

// Display last-login and promt
terminal.append("Last login: " + date + " on ttys000\n"); displayPrompt();
});
//# sourceURL=pen.js
</script>
</body>

</html>
