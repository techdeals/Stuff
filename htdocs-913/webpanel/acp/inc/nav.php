

       <nav class="navbar navbar-default navbar-static-top" style="margin-bottom: 0">
            <div class="navbar-header"> <a class="navbar-toggle hidden-sm hidden-md hidden-lg " href="javascript:void(0)" data-toggle="collapse" data-target=".navbar-collapse"><i class="ti-menu"></i></a>
                <div class="top-left-part"><a class="logo" href="index.php"><i class="glyphicon glyphicon-fire"></i>&nbsp;<span class="hidden-xs"><?php echo $websiteTitle; ?></span></a></div>
                <ul class="nav navbar-top-links navbar-left hidden-xs">
                    <li><a href="javascript:void(0)" class="open-close hidden-xs hidden-lg waves-effect waves-light"><i class="ti-arrow-circle-left ti-menu"></i></a></li>
                </ul>
                <ul class="nav navbar-top-links navbar-right pull-right">
                    <li>
                        <a class="profile-pic" href="login.php?logout=true"><b class="hidden-xs"><?php echo $_SESSION['username']; ?></b> </a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-header -->
            <!-- /.navbar-top-links -->
            <!-- /.navbar-static-side -->
        </nav>
        <div class="navbar-default sidebar nicescroll" role="navigation">
            <div class="sidebar-nav navbar-collapse ">
                <ul class="nav" id="side-menu">
                    <li><a href="index.php" class="waves-effect"><i class="glyphicon glyphicon-fire fa-fw"></i> Dashboard</a></li>
                    <!-- <li><a href="profile.html" class="waves-effect"><i class="ti-settings fa-fw"></i>Settings</a></li> -->
					<!-- <li><a href="basic-table.html" class="waves-effect"><i class="ti-layout-tab fa-fw"></i>Groups</a></li> -->
                    <li><a href="players.php" class="waves-effect"><i class="ti-user fa-fw"></i>Players</a></li>
					<?php
						foreach ($groups as &$group) {
							foreach ($group["members"] as &$member) {
								if($member["username"] == $_SESSION['username']){
									foreach ($group["rights"] as &$right) {
										if ($right == "rcon") {
											echo "<li><a href='rcon.php' class='waves-effect'><i class='ti-shortcode fa-fw'></i>RCON</a></li>";
										}
									}
								}
							}
						}
					?>
					
					<!-- <li><a href="serverevents.php" class="waves-effect"><i class="ti-menu-alt fa-fw"></i>Server events</a></li> -->

					<!--<li><a href="basic-table.html" class="waves-effect"><i class="ti-comments fa-fw"></i>Messages</a></li>-->
					<!-- <li><a href="basic-table.html" class="waves-effect"><i class="ti-server fa-fw"></i>Server(s)</a></li>-->
					<!--<li><a href="basic-table.html" class="waves-effect"><i class="ti-list fa-fw"></i>To do</a></li>-->
					<!-- <li><a href="basic-table.html" class="waves-effect"><i class="ti-github fa-fw"></i>Visit Github</a></li>-->
                </ul>
            </div>
            <!-- /.sidebar-collapse -->
        </div>