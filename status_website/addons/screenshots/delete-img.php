<?php
//Delete only one screenshot

	error_reporting(E_ALL);
	ini_set('display_errors', 1);

	include ("../../header.php");

	if(isset($_SESSION['steamid'])) {

		if(isset($_POST['delimage'])){

			$server_id= $_POST['server_id'];
	
			$return = unlink('../../'.$_POST['img_path'].'');
    	        if($return)
    	        	{$_SESSION["imgdell"]= "Screenshot successfully deleted";}
    	        else{
    	        	$_SESSION["imgdell"]= "Screenshot not deleted";}
		};

		header('location: ../../server-details.php?id='.$_POST['server_id'].'');

	} else {
		/* Redirect browser */
		header("Location: ../../");
		/* Make sure that code below does not get executed when we redirect. */
		exit;
	};