<?php

include_once("../header.php");

if ($login->hasPrivilege() == false) {
	header("location: index.php");
	exit('Restricted access');
}
//Page title
$title="Import/Update steam admins";

if(isset($_GET["id"])){
	$id = htmlentities($_GET['id']);
} else {
	header("location: my-servers.php");
	exit();	
}

//Get the server ID
$db->where ('id', $id);
$servers = $db->get('my_servers');

if ($servers[0]['server_name']=='')header("location: my-servers.php");

$server_id = $servers[0]['id'];

//Delete admin list

$db->where('server_id', $server_id);
if($db->delete('steam_admins')) echo 'successfully deleted<br />';

//Get the new admin list and insert it

$steam_url = $servers[0]['steam_group_url'];

$getfile = file_get_contents($steam_url.'/memberslistxml/list.xml?xml=1');

$arr = simplexml_load_string($getfile);

foreach($arr->members->steamID64 as $a => $b) {

$data = Array (
    'steam_id' => ''.$b.'',
    'server_id' => ''.$server_id.''
);

$id = $db->insert ('steam_admins', $data);
}
if($id)
    header('Location: my-servers.php');
else
    echo 'Admin List update failed: ' . $db->getLastError();
?>


