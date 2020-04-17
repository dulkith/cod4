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
		<div class="col-sm-12">
			<div class="x_panel">
				<div class="x_title">
					<?php
									if ( !empty ( $servers ) ) {//show if not empty
										foreach ( $servers as $server ) {?>
						<h2>Screenshot Panel -
							<?php echo $server['server_name'];?>
						</h2>
						<ul class="nav navbar-right panel_toolbox">
							<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
							<li><a class="close-link"><i class="fa fa-close"></i></a> </li>
						</ul>
						<div class="clearfix"></div>
				</div>
				<div class="x_content">

					<?php if(isset($_SESSION["errormsg"])) {
    								echo clear_server_name('<div class="alert alert-block alert-info fade in center">'.$_SESSION["errormsg"].'</div>');
    								unset($_SESSION["errormsg"]);
								};

								if(isset($_SESSION["reportmsg"])) {
    								echo clear_server_name('<div class="alert alert-block alert-success fade in center">'.$_SESSION["reportmsg"].'</div>');
    								unset($_SESSION["reportmsg"]);
								};
							?>


					<?php if ($_GET["id"]==1) { ?>



					<?php if(!isset($_SESSION['steamid'])) {?>
					<div class="panel panel-default">
						<div class="panel-heading"><i class="fa fa-camera"></i> Latest screenshots


							<form method="post" class="pull-right" action="addons/screenshots/delete-imgs.php">
								<button type="submit" class="btn btn-dark btn-xs pull-right" name="delimages" data-toggle="tooltip" title="" data-original-title="Delete all screenshots" "><i class="fa fa-trash " aria-hidden="true "></i> Delete All</button>
											<input type="hidden " name="server_id " value="<?php echo $server[ 'id'];?>">
							</form>

						</div>
						<div class="panel-body">
							<?php  
											if(isset($_SESSION["imgdell"])) {
    											echo '<div class="alert alert-block alert-info fade in center">'.$_SESSION["imgdell"].'</div>';
    											unset($_SESSION["imgdell"]);
											};
										?>




<div class="gallery">
        <?php
        //Include database configuration file
        // include('dbConfig.php');

        require_once(dirname(__FILE__) . '/functions.php');


        echo '<div class="row text-center text-lg-left my_text">';


        //get images from database
        // $query = $db->query("SELECT * FROM images ORDER BY uploaded_on DESC");

        $directory = 'screenshots/';
        $images = glob($directory . "*.jpg");

        $num_img = 1;
        $c = 1;
        $d = 1;

        usort($images, create_function('$a,$b', 'return filemtime($b) - filemtime($a);')); // Sort by date

        foreach ($images as $image) {
            $filecontent = file_get_contents($image);
            $metapos = strpos($filecontent, "CoD4X");
            $meta = substr($filecontent, $metapos);
            $data = explode("\0", $meta);
            $hostname = $data[1];
            $map = $data[2];
            $playername = $data[3];
            $guid = $data[4];
            $shotnum = $data[5];
            $time = $data[6];

            $datetime = new DateTime($time);
            $sdate = $datetime->format('Y-m-d');
            $stime = $datetime->format('g:i:s A');

             echo '<div class="col-lg-3 col-md-4 col-xs-6">';

			$ss = $image.'?'.date('U');
				
            echo '<div class="card" style="width: 12rem;">
                <a href="'.$ss.'" data-fancybox="gallery" data-fancybox="gallery" data-caption=' . clear_server_name($playername) . ' ">
                    <img class="img-thumbnail card-img-top" src="img/nothumb.png" data-src="' . $image . '?' . date('U') . '" alt="">
                  </a> 
                  <div class="card-body">
                    <h5 class="card-title">' . clear_server_name($playername) . '</h5>
                    
                    <a href="#" class="btn btn-danger"><i class="fa fa-ban"></i> Request Ban</a>
                  </div>
                </div><br />';


            /*
                            echo '<a href="'.$image.'?'.date('U').'" data-fancybox="gallery" class="d-block mb-4 h-100" data-caption='.clear_server_name($playername).' data-toggle="lightbox" data-gallery="multiimages" data-title="'.clear_server_name($playername).' ('.friendly_mapname($map).')"><i class="fa fa-camera"></i> '.clear_server_name($playername).' ('.friendly_mapname($map).')';
                                                  //  echo '<a href="'.$image.'?'.date('U').' class="d-block mb-4 h-100" data-caption='.clear_server_name($playername).' data-toggle="lightbox" data-gallery="multiimages" data-title="'.clear_server_name($playername).' ('.friendly_mapname($map).')"></a> ';

                                                    echo '<img src="img/nothumb.png" data-src="'.$image.'?'.date('U').'" class="img-thumbnail" alt="" />';
            echo '</a>';*/
            echo '</div>';
        }

        ?>


    </div>




							
											   
				</div>
			</div>
		</div>





		<?php } else { ?>
		<div class="myotherdiv">Condition is false</div>
		<?php } ?>



	</div>
</div>
</div>
<div class="col-sm-4">
	<div class="x_panel">
		<div class="x_title">


			<strong><?php echo $server['server_name'];?></strong>
			<ul class="nav navbar-right panel_toolbox">
				<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
				<li><a class="close-link"><i class="fa fa-close"></i></a> </li>
			</ul>
			<div class="clearfix"></div>
		</div>
		<div class="x_content">
			<div class="dashboard-widget-content">
				<div class="panel panel-default">

					<div class="panel-heading">Current map :
						<strong><?php echo friendly_mapname($server['server_current_map']);?></strong>
					</div>
					<div class="panel-body text-center">
						<?php
									$file = 'assets/images/maps/'.$server['server_current_map'].'.jpg';
										if (file_exists($file)) {?>
							<img src="<?php home_url();?>assets/images/maps/<?php echo $server['server_current_map'];echo '.jpg?='.date('U').''?>" alt="cod4" class="img-responsive thumbnail">
							<?php } else {
										    echo "No image available";
											};?>
							<div class="progress">
								<div class="progress-bar progress-bar-striped active" role="progressbar" data-transitiongoal="<?php $get_percent = calculate_total(count( $Players ), $server['server_maxplayers']); echo $get_percent;?>" style="width:100%;">
									<?php $get_percent = calculate_total(count( $Players ), $server['server_maxplayers']); echo round($get_percent);?>%</div>
							</div>
					</div>

					<div class="panel-footer text-center">
						<strong>Server Ip:Port</strong><br>
						</button>
						<?php echo $server['server_ip'];?>:
						<?php echo $server['server_port'];?>
					</div>


					<div class="panel-body">
						<table class="table">
							<tbody>
								<tr>
									<th>Server status</th>
									<td>
										<?php if ($server['server_status']==1) echo '<span class="label label-success">active</span>'; else echo '<span class="label label-danger">offline</span>'?></td>
								</tr>
								<tr>
									<th>Players</th>
									<td><span class="badge">
												<?php echo count( $Players );?> /
												<?php echo $server['server_maxplayers'];?>
												</span>
									</td>
								</tr>
								<tr>
									<th>Location</th>
									<td><img src="<?php home_url();?>assets/images/flags/<?php echo $server['server_location'];?>.png"> Sri Lanka </td>
								</tr>
								<tr>
									<th>Join Server</th>
									<td><a href="cod4://<?php echo $server['server_ip'];?>:<?php echo $server['server_port'];?>" data-toggle="tooltip" title="Join via COD4x - COD4x Client required"><img src="<?php home_url();?>assets/images/cod4.gif" alt="cod4" class="avatar"></a></td>
								</tr>
								<tr>
									<th>Server Version</th>
									<td>COD4x 1.8</td>
								</tr>
								<tr>
									<th>Mod</th>
									<td>Custom Promod</td>
								</tr>
								<tr>
									<th>Game Type</th>
									<td>Search and Destroy</td>
								</tr>
								<tr>
									<th>Server Admin</th>
									<td>&lt;&lt;HM&gt;</td>
								</tr>
							</tbody>
						</table>
						<?php } //loop end
									}//show if not empty end
								;?>
					</div>
				</div>


				<div class="panel panel-default">

					<?php };?>



					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th class="info-column">Server Info recived in</th>
								<th><span class="label label-<?php echo $Timer > 1.0 ? 'danger' : 'success'; ?>"><?php echo $Timer; ?>seconds</span></th>
							</tr>
						</thead>
					</table>
				</div>



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
