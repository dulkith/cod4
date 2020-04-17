<?php
// checking for minimum PHP version
if (version_compare(PHP_VERSION, '5.3.7', '<')) {
  exit("Sorry, CoD4 Status does not run on a PHP version smaller than 5.3.7 !");
} else if (version_compare(PHP_VERSION, '5.5.0', '<')) {
  // if you are using PHP 5.3 or PHP 5.4 you have to include the password_api_compatibility_library.php
  // (this library adds the PHP 5.5 password hashing functions to older versions of PHP)
  require_once("libraries/password_compatibility_library.php");
}
// include the configs / constants for the database connection
require_once("config/db.php");
// load the login class
require_once("classes/Login.php");
// create a login object
$login = new Login();

require_once (dirname(__FILE__).'/functions.php');

require_once ('classes/MysqliDb.php');
?>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>COD4 Stats 404 error</title>
<!-- Bootstrap core CSS -->
    <link href="<?php home_url();?>assets/css/bootstrap.min.css" rel="stylesheet">
    <link href="<?php home_url();?>assets/fonts/css/font-awesome.min.css" rel="stylesheet">
    <link href="<?php home_url();?>assets/css/animate.min.css" rel="stylesheet">
    <link href="<?php home_url();?>assets/css/switchery/switchery.min.css" rel="stylesheet">
    
    <!-- Custom styling plus plugins -->
    <link href="<?php home_url();?>assets/css/icheck/flat/green.css" rel="stylesheet" />
    <link href="<?php home_url();?>assets/css/custom.css" rel="stylesheet">
    <link href="<?php home_url();?>assets/js/datatables/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
    <link href="<?php home_url();?>assets/js/datatables/buttons.bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="<?php home_url();?>assets/js/datatables/fixedHeader.bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="<?php home_url();?>assets/js/datatables/responsive.bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="<?php home_url();?>assets/js/datatables/scroller.bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script src="<?php home_url();?>assets/js/nprogress.js"></script>
    <script src="<?php home_url();?>assets/js/jquery.min.js"></script>
    <!--[if lt IE 9]>
        <script src="<?php home_url();?>assets/js/ie8-responsive-file-warning.js"></script>
    <![endif]-->
    
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body class="nav-md">
<div class="container body">
  <div class="main_container">
    <div class="col-md-12">
      <div class="col-middle">
        <div class="text-center text-center">
          <h1 class="error-number">404</h1>
          <h2>Sorry but we couldnt find this page</h2>
          <p>This page you are looking for does not exsist <a href="<?php home_url();?>">Go to Homepage</a> </p>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
