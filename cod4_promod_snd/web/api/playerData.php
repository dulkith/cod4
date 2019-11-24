<?php

// Initialize variable for database credentials
$dbhost = 'localhost';
$dbuser = 'root';
$dbpass = 'OADOdfkdo340dfksa3nofdsdfkdpfk';
$dbname = 'sles_snd_promod';

if(isset($_GET["id"])){
	$id = $_GET['id'];
	
} else {
	header("location: ../404.php");
	exit();	
}

//Create database connection
  $dblink = new mysqli($dbhost, $dbuser, $dbpass, $dbname);

//Check connection was successful
  if ($dblink->connect_errno) {
     printf("Failed to connect to database");
     exit();
  }

//Fetch 3 rows from actor table
  $result = $dblink->query("SELECT clients.guid, clients.id, clients.name, clients.ip, clients.connections, clients.time_add, clients.time_edit, groups.name as level, xlr_playerstats.kills, xlr_playerstats.deaths, xlr_playerstats.teamdeaths, xlr_playerstats.teamkills, xlr_playerstats.suicides, xlr_playerstats.ratio, xlr_playerstats.skill, xlr_playerstats.assists, xlr_playerstats.rounds, current_clients.DBID FROM clients LEFT JOIN groups ON clients.group_bits = groups.id LEFT JOIN xlr_playerstats ON clients.id = xlr_playerstats.id LEFT JOIN current_clients ON clients.id=current_clients.DBID where clients.guid='$id'");
  //$result = $dblink->query("SELECT * FROM clients where guid='$id'");

//Initialize array variable
  $dbdata = array();

//Fetch into associative array
  while ( $row = $result->fetch_assoc())  {
	$dbdata[]=$row;
  }
  
	$dbdata[0]['time_edit'] =  convertDateTime($dbdata[0]['time_edit']);
	$dbdata[0]['time_add'] =  convertDateTime($dbdata[0]['time_add']);
	
	$adminLevel = $dbdata[0]['level'];
	
	if ($adminLevel == "Super Admin") {
		$dbdata[0]['level'] = "Super Admin [100]";
	} elseif ($adminLevel == "Senior Admin") {
		$dbdata[0]['level'] = "Senior Admin [80]";
	} elseif ($adminLevel == "Full Admin") {
		$dbdata[0]['level'] = "Full Admin [60]";
	} elseif ($adminLevel == "Admin") {
		$dbdata[0]['level'] = "Admin [40]";
	} elseif ($adminLevel == "Moderator") {
		$dbdata[0]['level'] = "Moderator [20]";
	}elseif ($adminLevel == "Regular") {
		$dbdata[0]['level'] = "Regular [2]";
	}elseif ($adminLevel == "User") {
		$dbdata[0]['level'] = "User [1]";
	} else {
		$dbdata[0]['level'] = "Guest [0] ^7!reg to register";
	}
	
//Print array in JSON format
 echo json_encode($dbdata[0]);
 
 function convertDateTime($unixTime) {
		$dt = new DateTime("@$unixTime");
		return $dt->format('Y/m/d g:i:s A');
	}
 
 
?>