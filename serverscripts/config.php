<?php

define("DB_HOST", "127.0.0.1"); #db host
define("DB_USER", "youruser"); #db username
define("DB_PASS", "yourpass"); #db password
define("DB_NAME", "yourdb"); #database name

$connection = mysqli_connect(DB_HOST, DB_USER, DB_PASS);
mysqli_select_db($connection,DB_NAME); #our mysql connection

?>