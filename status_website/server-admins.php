<?php 
include_once("header.php");

include ("include/SourceQuery/bootstrap.php");

use xPaw\SourceQuery\SourceQuery;

if(isset($_GET["id"])){
	$id = htmlentities($_GET['id']);
} else {
	header("location: 404.php");
	exit();	
}



$db->where ('id', $id);
$servers = $db->get('my_servers');

$title="".$servers[0]['server_name'];

if ($servers[0]['server_name']=='')header("location: 404.php");

$sq_server_addr = $servers[0]['server_ip'];
$sq_server_port = $servers[0]['server_port'];
$sq_timeout     = 3;
$sq_engine      = "SourceQuery :: SOURCE";

// Edit this <-

$Timer = MicroTime( true );

$Query = new SourceQuery( );

$Info    = Array( );
$Rules   = Array( );
$Players = Array( );

try
{
	//$Query->Connect( SQ_SERVER_ADDR, SQ_SERVER_PORT, SQ_TIMEOUT, SQ_ENGINE );
	$Query->Connect( $sq_server_addr, $sq_server_port++, $sq_timeout, $sq_engine );
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
if ($InfoKey=='Map') $server_current_map =$result;

/*############################## END OF SERVER VARIABLES ##########################################################*/

endforeach;
$server_online_players2= $server_online_players;
$server_current_map2= $server_current_map;

if ($server_online_players!='') $srv_status='1'; else $srv_status='0';

//Refresh server details

$data = Array (
	'last_refresh' => $db->now(),
	'server_online_players' => $server_online_players2,
	'server_current_map' => $server_current_map2,
	'server_status' => $srv_status
);
$db->where ('id', $id);

$db->update ('my_servers', $data);

include_once("navigation.php");

?>
<div class="right_col" role="main">
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>COD4 Server Information</h2>
					<ul class="nav navbar-right panel_toolbox">
						<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
						<li><a class="close-link"><i class="fa fa-close"></i></a> </li>
					</ul>
					<div class="clearfix"></div>
				</div>
				<div class="x_content">
					<table class="table table-striped projects">
						<thead>
							<tr>
								<th width="5%">#</th>
								<th>Server Name</th>
								<th>Join</th>
								<th>Players</th>
								<th>Server Ip:Port</th>
								<th>Server status</th>
							</tr>
						</thead>
						<tbody>
							<?php
									if ( !empty ( $servers ) ) {//show if not empty
										foreach ( $servers as $server ) {?>
								<tr>
									<td><img src="<?php home_url();?>assets/images/flags/<?php echo $server['server_location'];?>.png"></td>
									<td>
										<a href="/server-details.php?id=<?php echo $server['id'];?>">
											<?php echo $server['server_name'];?>
										</a> <br />
										<small><?php echo $server['server_game'];?></small></td>
									<td><a href="cod4://<?php echo $server['server_ip'];?>:<?php echo $server['server_port'];?>" data-toggle="tooltip" title="Join via COD4x - COD4x Client required"><img src="<?php home_url();?>assets/images/cod4.gif" alt="cod4" class="avatar"></a></td>
									<td class="project_progress">
										<div class="progress progress_sm">
											<div class="progress-bar bg-green" role="progressbar" data-transitiongoal="<?php $get_percent = calculate_total(count( $Players ), $server['server_maxplayers']); echo $get_percent;?>"></div>
										</div>
										<small><?php echo count( $Players );?>/<?php echo $server['server_maxplayers'];?></small></td>
									<td>
										<?php echo $server['server_ip'];?>:
										<?php echo $server['server_port'];?>
									</td>
									<td>
										<?php if ($server['server_status']==1) echo '<span class="label label-success">active</span>'; else echo '<span class="label label-danger">offline</span>'?></td>
								</tr>
								<?php } //loop end
									}//show if not empty end
								;?>
						</tbody>
					</table>
					<?php  
								if(isset($_SESSION["errormsg"])) {
    								echo clear_server_name('<div class="alert alert-block alert-info fade in center">'.$_SESSION["errormsg"].'</div>');
    								unset($_SESSION["errormsg"]);
								};

								if(isset($_SESSION["reportmsg"])) {
    								echo clear_server_name('<div class="alert alert-block alert-success fade in center">'.$_SESSION["reportmsg"].'</div>');
    								unset($_SESSION["reportmsg"]);
								};
							?>

					<div class="x_title">
						<h2>B3 Admins</h2>
						<div class="clearfix"></div>
					</div>

					<?php if ($_GET["id"]==1) { ?>


					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th class="text-center ">NO</th>
								<th>#</th>
								<th>IGN</th>
								<th>LEVEL</th>
								<th>B3 ID</th>
								<th>CONNECT</th>
								<th>KILLES</th>
								<th>DEATHS</th>
								<th>RATIO</th>
								<th>SKILL</th>
								<th>LAST SEEN IN GAME</th>
								<th>STATUS</th>
							</tr>
						</thead>


						<?php
                // Include / load file koneksi.php
                include "b3_echelon/database_b3_1.php";
				include "b3_echelon/functions.php";

                // Buat query untuk menampilkan data siswa sesuai limit yang ditentukan
                $sql = $pdo->prepare("SELECT clients.id, clients.name, clients.ip, clients.connections, clients.time_edit, groups.name as level, xlr_playerstats.kills, xlr_playerstats.deaths, xlr_playerstats.ratio, xlr_playerstats.skill, current_clients.DBID FROM clients LEFT JOIN groups ON clients.group_bits = groups.id LEFT JOIN xlr_playerstats ON clients.id = xlr_playerstats.id LEFT JOIN current_clients ON clients.id=current_clients.DBID WHERE clients.group_bits >= 8 ORDER BY clients.group_bits DESC");
                $sql->execute(); // Eksekusi querynya

                $no = $limit_start + 1; // Untuk penomoran tabel
				include("b3_echelon/geoip.inc");

			$gi = geoip_open("b3_echelon/GeoIP.dat",GEOIP_STANDARD);

				
                while ($data = $sql->fetch()) { // Ambil semua data dari hasil eksekusi $sql
					$humanDateTime = convertDateTime($data['time_edit']);
                ?>
							<tr>
								<td class="align-middle text-center">
									<?php echo $no; ?>
								</td>
								<td class="align-middle">
									<img src="<?php home_url();?>assets/images/flags/<?php echo geoip_country_code_by_addr($gi, $data['ip']); ?>.png">
								</td>
								<td class="align-middle">
									<?php echo $data['name']; ?>
								</td>
								<td class="align-middle">
									<?php
									$adminLevel = $data['level'];
									if ($adminLevel == "Super Admin") {
										echo '<span class="label label-danger">Super Admin [100]</span>';
									} elseif ($adminLevel == "Senior Admin") {
										echo '<span class="label label-warning">Senior Admin [80]</span>';
									} elseif ($adminLevel == "Full Admin") {
										echo '<span class="label label-info">Full Admin [60]</span>';
									} elseif ($adminLevel == "Admin") {
										echo '<span class="label label-success">Admin [40]</span>';
									} else {
										echo '<span class="label label-default">Moderator [20]</span>';
									}
								?>
								</td>
								<td class="align-middle">
									@<?php echo $data['id']; ?>
								</td>
								<td class="align-middle">
									<?php echo $data['connections']; ?>
								</td>
								<td class="align-middle">
									<?php echo $data['kills']; ?>
								</td>
								<td class="align-middle">
									<?php echo $data['deaths']; ?>
								</td>
								<td class="align-middle">
									<?php echo round($data['ratio'],3); ?>
								</td>
								<td class="align-middle">
									<?php echo round($data['skill'],2); ?>
								</td>
								<td class="align-middle">
									<?php echo $humanDateTime; ?>
								</td>
								<td class="align-middle text-center">
								<?php
									if ($data['DBID'] != "") {
										echo '<span class="label label-success">ONLINE</span>';
									} else {
										echo '<span class="label label-danger">OFFLINE</span>';
									}
								?>
								</td>
							</tr>
							<?php
                $no++; // Tambah 1 setiap kali looping
                }
                ?>

					</table>

					<?php } else { ?>
					<div class="myotherdiv">Condition is false</div>
					<?php } ?>



				</div>
			</div>
		</div>
		
		<script src="<?php home_url();?>assets/js/ekko-lightbox.min.js"></script>
		<script type="text/javascript">
			$(document).ready(function($) {

				// delegate calls to data-toggle="lightbox"
				$(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
					event.preventDefault();
					return $(this).ekkoLightbox({
						always_show_close: true
					});
				});

			});

		</script>
		<?php include("footer.php"); ?>
