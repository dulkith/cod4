<?php 

include_once("../header.php");

if(isset($_GET["id"])){
	$id = htmlentities($_GET['id']);
} else {
    header("location: my-servers.php");
    exit();	
}


if ($login->hasPrivilege() == false) {
	header("location: index.php");
	exit('Restricted access');
}
//Page title
$title="Edit Servers";



require_once ('../classes/MysqliDb.php');

//Get the #ID
$db->where ("id", $id);
$server = $db->getOne ("my_servers");


include ("../include/SourceQuery/bootstrap.php");
use xPaw\SourceQuery\SourceQuery;

// data edit code starts here.
if(isset($_POST['btn_edit']))
{

include_once('../include/geoip.inc.php');


$ip = ''.$_POST['server_ip'].''.''.$_POST['server_port'].''; //Edit IP					
					
//set an IPv6 address for testing
if((strpos($_POST['server_ip'], ":") === false)) {
	//server_ipv4
	$gi = geoip_open("../include/GeoIP.dat",GEOIP_STANDARD);
	$country = geoip_country_code_by_addr($gi, $_POST['server_ip']);
}
else {
	//ipv6
	$gi = geoip_open("../include/GeoIPv6.dat",GEOIP_STANDARD);
	$country = geoip_country_code_by_addr_v6($gi, $_POST['server_ip']);
}

	
	
	// Edit this ->
	define( 'SQ_SERVER_ADDR', ''.$_POST['server_ip'].'' );
	define( 'SQ_SERVER_PORT', ''.$_POST['server_port'].'' );
	define( 'SQ_TIMEOUT', 3 );
	define( 'SQ_ENGINE', SourceQuery::SOURCE );
	// Edit this <-
	
	$Timer = MicroTime( true );
	
	$Query = new SourceQuery( );
	
	$Info    = Array( );
	$Rules   = Array( );
	$Players = Array( );
	
	try
	{
		$Query->Connect( SQ_SERVER_ADDR, SQ_SERVER_PORT, SQ_TIMEOUT, SQ_ENGINE );
		//$Query->SetUseOldGetChallengeMethod( true ); // Use this when players/rules retrieval fails on games like Starbound
		
		$Info    = $Query->GetInfo( );
		$Players = $Query->GetPlayers( );
		$Rules   = $Query->GetRules( );
	}
	catch( Exception $e )
	{
		$Exception = $e;
	}
	finally
	{
		$Query->Disconnect( );
	}
	
	$Timer = Number_Format( MicroTime( true ) - $Timer, 4, '.', '' );


foreach( $Info as $InfoKey => $InfoValue ):

	if( Is_Array( $InfoValue ) )
	{
		$result = ( $InfoValue );
		
		
	}
	else
	{
		if( $InfoValue === true )
		{
			$result = 'true';
		}
		else if( $InfoValue === false )
		{
			$result = 'false';
		}
		else
		{
			$result = htmlspecialchars( $InfoValue );
		}
	}


/*############################## SERVER VARIABLES ##########################################################*/

if ($InfoKey=='HostName') $server_name =$result;
if ($InfoKey=='Players') $server_online_players =$result;
if ($InfoKey=='MaxPlayers') $server_maxplayers =$result;
if ($InfoKey=='ModDesc') $server_game_name =$result;
if ($InfoKey=='Map') $server_current_map =$result;

/*############################## END OF SERVER VARIABLES ##########################################################*/

endforeach;
$server_name2= $server_name;
$server_maxplayers2= $server_maxplayers;
$server_online_players2= $server_online_players;
$server_current_map2= $server_current_map;
$server_location2= $country;

//Add server to DB

$data = Array (
    'server_ip' => $_POST['server_ip'],
    'server_port' => $_POST['server_port'],
	'server_identkey' => $_POST['server_identkey'], 
    'steam_group_url' => $_POST['steam_group_url'],
    'last_refresh' => $db->now(),
    'server_name' => $server_name2,
    'server_maxplayers' => $server_maxplayers2,
    'server_online_players' => $server_online_players2,
    'server_current_map' => $server_current_map2,
    'server_location' => $server_location2


);

$db->where ('id', $id);
if ($db->update ('my_servers', $data))
    $msg = 'Server updated';
else
    $msg = 'Update failed: ' . $db->getLastError();
}
include_once("../navigation.php");
?>
	<div class="right_col" role="main">
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="x_panel">
					<div class="x_title">
						<h2>Edit <small><?php echo $server['server_name'];?></small></h2>
						<div class="clearfix"></div>
					</div>
					<div class="x_content">
						<form method="post">
            				<div class="form-group">
            				  <label for="server_ip">* Server IP:</label>
            				  <input type="text" id="server_ip" class="form-control" name="server_ip" value="<?php echo htmlentities($server['server_ip']);?>" required />
            				</div>
            				<div class="form-group">
            				  <label for="server_port">* Server Port:</label>
            				  <input type="text" id="server_port" class="form-control" name="server_port" value="<?php echo htmlentities($server['server_port']);?>" required />
            				</div>
            				<div class="form-group">
            				  <label for="server_identkey">* Server rcon password:</label>
            				  <input type="text" id="server_identkey" class="form-control" name="server_identkey" value="<?php echo htmlentities($server['server_identkey']);?>" required />
            				</div>
            				<div class="form-group">
            				  <label for="steam_group_url">Steam Group (For server Admins - COD4x mod required):</label>
            				  <input type="text" id="steam_group_url" class="form-control" name="steam_group_url" value="<?php echo htmlentities($server['steam_group_url']);?>" />
            				</div>
            				<div class="form-group">
            				<a href="my-servers.php" class="pull-right btn btn-info">Go back to my servers</a>
            				  <input type="submit" class="btn btn-primary pull-right" name="btn_edit" value="Edit server">
            				</div>
						</form>
							
					</div>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>

<script type="text/javascript">	
function generate(type, theme) {
	var n = noty({
	text        : type,
	<?php
		if(isset($_POST['btn_edit'])) {
			if ($msg=='Server updated') {?>	
    			type: 'success',
      <?php } else { ?>	
    			type: 'error',
        <?php }
		}
	?> 
	dismissQueue: true,
	layout      : 'topRight',
	theme       : theme,
	closeWith   : ['button', 'click'],
	maxVisible  : 20,
	timeout     : 10000,
	modal       : false,
	animation   : 
		{
			open  : 'animated lightSpeedIn',
			close : 'animated lightSpeedOut',
			easing: 'swing',
			speed : 500
		}
	});
		console.log('html: ' + n.options.id);
}

function generateAll() {
	<?php
		// show potential errors / feedback (from login object)
		if(isset($_POST['btn_edit'])) {

			if ($msg == 'Server updated') {?>	
    			generate('<h3>Success</h3><?php echo "$msg";?>', "bootstrapTheme");

            <?php } else { ?>	
    			generate('<h3>Error</h3><?php echo "$msg";?>', "bootstrapTheme");
        <?php }
		}
	?> 
}
$(document).ready(function () {
	generateAll();
	});		
</script>
<?php include("../footer.php"); ?>
