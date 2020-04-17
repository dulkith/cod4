<?php
// checking for minimum PHP version
if (version_compare(PHP_VERSION, '5.3.7', '<')) {
	exit("Sorry, CoD4 Status does not run on a PHP version smaller than 5.3.7 !");
} else if (version_compare(PHP_VERSION, '5.5.0', '<')) {
	// if you are using PHP 5.3 or PHP 5.4 you have to include the password_api_compatibility_library.php
	// (this library adds the PHP 5.5 password hashing functions to older versions of PHP)
	require_once("../libraries/password_compatibility_library.php");
}
// load the login class
require_once("../classes/Login.php");
// create a login object
$login = new Login();
require ('../steamauth/steamauth.php');
require_once ('../classes/MysqliDb.php');
require_once ('../functions.php');
?>