<?php 

error_reporting(E_ALL);
ini_set('display_errors', 1);

include_once("../header.php");

if ($login->hasPrivilege() == false) {
	header("location: index.php");
	exit('Restricted access');
}
//Page title
$title="My Servers";

require_once ('../classes/MysqliDb.php');

$servers = $db->get('my_servers');
include_once("../navigation.php");
include ("../include/SourceQuery/bootstrap.php");
use xPaw\SourceQuery\SourceQuery;




// data insert code starts here.
if(isset($_POST['btn_insert']))
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

$id = $db->insert ('my_servers', $data);

if($id)
    $message = 'Server was created. Id=' . $id;
if (!file_exists ('../screenshots/'.$id)) {
   mkdir('../screenshots/'.$id.'', 0777, true);
}

if (!file_exists ('../banned/screenshots/'.$id)) {
   mkdir('../banned/screenshots/'.$id.'', 0777, true);
}


header("location: my-servers.php");
}

function Delete($path)
{
    if (is_dir($path) === true)
    {
        $files = array_diff(scandir($path), array('.', '..'));

        foreach ($files as $file)
        {
            Delete(realpath($path) . '/' . $file);
        }

        return rmdir($path);


    }

    else if (is_file($path) === true)
    {
        return unlink($path);
    }

    return false;

    
}


//Delete server
if(isset($_POST['btn_delete']))
{

$db->where('server_id', $_POST['id']);
if($db->delete('steam_admins'))
	$message = 'Steam admins deleted';

//Delete servers imag folders

Delete('../screenshots/'.$_POST['id']);

Delete('../banned/screenshots/'.$_POST['id']);

$db->where('id', $_POST['id']);
if($db->delete('my_servers'))
	$message = 'All Server admins successfully deleted';
	header("location: my-servers.php");

//Delete all bans made on this server
$db->where('server_id', $_POST['id']);
if($db->delete('banned_players'))
	$message = 'All server bans successfully deleted';
	header("location: my-servers.php");
}
//End delete server
?>
	<div class="right_col" role="main">
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="x_panel">
					<div class="x_title">
						<h2>My Servers <small>server list</small></h2>
						<button data-toggle="modal" data-target="#mySModal" class="pull-right btn btn-info"><i class="fa fa-plus"></i> Add New Server</button>
						<div class="clearfix"></div>
					</div>
					<div class="x_content">
						<table class="table table-striped table-bordered dt-responsive nowrap" id="datatable-responsive">
							<thead>
								<tr>
									<th>#</th>
									<th>Server Name</th>
									<th>IP &amp; Port</th>
									<th>Steam Group</th>
									<th>Edit/Delete server &amp; Import admins from steam group</th>
								</tr>
							</thead>
							<tbody>
							<?php
							if ( !empty ( $servers ) ) {//show if not empty
								foreach ( $servers as $server ) {?>
									<tr>
										<th scope="row"><?php echo $server['id'];?></th>
										<td><?php echo $server['server_name'];?></td>
										<td><?php echo $server['server_ip'];?>:<?php echo $server['server_port'];?></td>
										<td>
										<?php
										if(!empty($server['steam_group_url'])){
											echo '<a href="'.$server['steam_group_url'].'" target="_blank">Steam Group</a>';
										} else {
											echo '<button class="btn btn-warning btn-xs">warning</button> Steam Group is missing';
										};?>

										</td>
										<td><a href="<?php home_url();?>admin/edit-server.php?id=<?php echo $server['id'];?>" class="btn btn-primary btn-xs pull-left"><i class="fa fa-pencil"></i> Edit</a>
										<form method="post" class="pull-left">
											<input type="hidden" name="id" value="<?php echo $server['id'];?>">
											<button type="submit" class="btn btn-danger btn-xs" name="btn_delete"><i class="fa fa-trash-o"></i> Delete</button>
										</form>
										<a href="<?php home_url();?>admin/steam-admins-import.php?id=<?php echo $server['id'];?>" class="btn btn-info btn-xs pull-left" data-toggle="tooltip" title="" data-original-title="Refresh/Import Steam Admin List"> <i class="fa fa-refresh"></i> Steam Admin Group</a>
										</td>
									</tr>
							<?php } //loop end
							}//show if not empty end
							;?>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
<div id="mySModal" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Add a new Server</h4>
			</div>
			<div class="modal-body">
			<form method="post">
					
					<div class="form-group">
						<label for="server_ip">* Server IP :</label>
						<input type="text" id="server_ip" class="form-control" name="server_ip" value="" required />
					</div>
					<div class="form-group">
						<label for="server_port">* Server Port:</label>
						<input type="text" id="server_port" class="form-control" name="server_port" value="" required />
					</div>
					<div class="form-group">
						<label for="server_identkey">Server rcon password</label>
						<input type="text" id="server_identkey" class="form-control" placeholder="your server rcon password" name="server_identkey" value="" />
					</div>
					<div class="form-group">
						<label for="steam_group_url">Steam Group (For server Admins - COD4x mod required)</label>
						<input type="text" id="steam_group_url" class="form-control" placeholder="http://steamcommunity.com/groups/your-steam-group" name="steam_group_url" value="" />
					</div>
					<input type="submit" class="btn btn-primary pull-right" name="btn_insert" value="Add new server">
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">	
function generate(type, theme) {
	var n = noty({
	text        : type,
	<?php
		if(isset($_POST['btn_insert'])) {
			if ($id) {?>	
    			type: 'success',
      <?php } else { ?>	
    			type: 'error',
        <?php }
		}
	?> 
	dismissQueue: true,
	layout      : 'bottomRight',
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
		if(isset($_POST['btn_insert'])) {

			if ($id) {?>	
    			generate('<h3>Success</h3><?php echo 'Server added. Id='.$id.'';?>', "bootstrapTheme");
            <?php } else { ?>	
    			generate('<h3>Error</h3><?php echo 'Insert failed: ' . $db->getLastError().'';?>', "bootstrapTheme");
        <?php }
		}
	?> 
}
$(document).ready(function () {
	generateAll();
	});		
</script>
<?php include("../footer.php"); ?>
