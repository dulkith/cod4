<?php
	

	error_reporting(E_ALL);
	ini_set('display_errors', 1);

	include ("../../header.php");

	include ("../../include/SourceQuery/bootstrap.php");
	use xPaw\SourceQuery\SourceQuery;

if(!isset($_SESSION['steamid'])) {
	
	$captcha;
	 if(isset($_POST['g-recaptcha-response'])){
          $captcha=$_POST['g-recaptcha-response'];
        }
        if(!$captcha){
          echo '<h2>Please check the the captcha form.</h2>';
          exit;
        }
	$secretKey = "6Lcz50EUAAAAALuufrBqml-XuEl2DSqbNJqw6DOe";
	$ip = $_SERVER['REMOTE_ADDR'];
        $response=file_get_contents("https://www.google.com/recaptcha/api/siteverify?secret=".$secretKey."&response=".$captcha."&remoteip=".$ip);
	$responseKeys = json_decode($response,true);
        if(intval($responseKeys["success"]) !== 1) {
			$_SESSION["errormsg"] = "You are spammer ! Please get the @$%K out";
        } else {
          
			
			if (isset( $_POST['command'] )){

		//Get the right server

		$db->where ('id', $_POST['server_id']);
		$servers = $db->get('my_servers');

		if ($servers[0]['server_name']=='')header('location: ../../server-details.php?id='.$_POST['server_id'].'');

		$sq_server_addr = $servers[0]['server_ip'];
		$sq_server_port = $servers[0]['server_port'];
		$sq_server_rcon = $servers[0]['server_identkey'];


		$Query = new SourceQuery( );
		
		try
		{
			$Query->Connect( ''.$sq_server_addr.'', $sq_server_port );
			
			$Query->SetRconPassword( ''.$sq_server_rcon.'' );
			$_SESSION["noramlmsg"]= $Query->Rcon( 'getss '.$_POST['player'].'');
					
			$Query->Disconnect( );
			
			
		}
		catch( SQueryException $e )
		{
			$Query->Disconnect( );
			
			echo "Error: " . $e->getMessage( );
		}
		
	}
			
			
			
        }
	
	

	
	header('location: ../../server-details.php?id='.$_POST['server_id'].'');
}else{
	header('location: ../../server-details.php?id='.$_POST['server_id'].'');
	exit('Not there Wenys');
}
