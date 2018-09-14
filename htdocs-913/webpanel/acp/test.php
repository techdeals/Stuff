
<?php
include("inc/config.php");
	foreach ($groups as &$group) {
		foreach ($group["members"] as &$member) {
			if($member["username"] == "Slluxx"){
				foreach ($group["rights"] as $right){
					if($right == "kick"){
						echo "user is allowed to kick";
					}
				}
			}
		}
	}
?>
