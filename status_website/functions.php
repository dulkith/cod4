<?php
// Get the config file

require_once (dirname(__FILE__).'/classes/MysqliDb.php');

// Get the page title
function the_title(){
  global $title;
  echo $title;
}

// Output home url
function home_url(){
  echo ABS_URL;
}

// get home url
function full_home_url(){
  return ABS_URL;
}

// Output Absolute Path url
function path_url(){
  echo ABS_PATH;
}

function breaklines($string) {

	$text = str_replace(array("\r\n", "\r", "\n"), "<br />", $string);

	
	return $text;

}

function clear_server_name($string) {

	$text = str_replace(array("^1", "^2","^3","^4","^5","^6","^7","^8","^9","^0"), "", $string);
	
	return $text;

}

function calculate_total($online_players, $max_players) {

	$percent = 100;
	
	if ($online_players > 0) {
	
		$get_result = ($online_players/$max_players)*$percent;
	
	}else {
	
		$get_result = 0;
	
	}
	
	return $get_result;

}

function friendly_mapname($mapname) {

	$mp_mapname = str_replace('mp_', '', $mapname);

	$new_mapname = ucfirst($mp_mapname); 
	
	return $new_mapname;

}

function GetBetween($content,$start,$end){
    $r = explode($start, $content);
    if (isset($r[1])){
        $r = explode($end, $r[1]);
        return $r[0];
    }
    return '';
}

;?>