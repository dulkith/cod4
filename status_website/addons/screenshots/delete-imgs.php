<?php
//Delete only one screenshot

	error_reporting(E_ALL);
	ini_set('display_errors', 1);

	include ("../../header.php");

	if(isset($_SESSION['steamid'])) {

		//Delete images if there are no cheaters

		if(isset($_POST['delimages'])){

			$id=$_POST['server_id'];
	
			$ekstenzije = array('jpg', 'jpeg'); //Delete JPG files only 
						$files = array();
						$putanja = "../../screenshots/".$id."/"; 
						$dir = opendir($putanja); 
						$count=0; 
						$debug = ""; 
						while( ($file = readdir($dir)) != false ) 
							{ 
								if( !is_dir($file) && !in_array($file,array('.','..')) && in_array(substr($file,strrpos($file,'.')+1),$ekstenzije) ) 
									{ 
										if (file_exists($putanja.$file)) 
							 				{$count++; $debug.= "\n$count | $file"; unlink($putanja.$file);} 
					} 
				} 
			closedir($dir);
	
			$_SESSION["imgdell"]="All Screenshots successfully deleted";
	
			header('location: ../../server-details.php?id='.$_POST['server_id'].'');
		};
	} else {
		/* Redirect browser */
		header("Location: ../../");
		/* Make sure that code below does not get executed when we redirect. */
		exit;
	};