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
		<div class="col-sm-8">
			<div class="x_panel">
				<div class="x_title">

					<?php
				if ( !empty ( $servers ) ) {//show if not empty
										foreach ( $servers as $server ) {?>
						<?php } //loop end
									}//show if not empty end
								;?>

						<h2><i class="fa fa-user"></i> Online Players -
							<?php echo $server['server_name'];?>
						</h2>
						<ul class="nav navbar-right panel_toolbox">
							<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
							<li><a class="close-link"><i class="fa fa-close"></i></a> </li>
						</ul>
						<div class="clearfix"></div>
				</div>
				<div class="x_content">




					<?php  
								if(isset($_SESSION["errormsg"])) {
    								echo clear_server_name('<div class="alert alert-block alert-danger fade in center">'.$_SESSION["errormsg"].'</div>');
    								unset($_SESSION["errormsg"]);
								};
					
								if(isset($_SESSION["noramlmsg"])) {
    								echo clear_server_name('<div class="alert alert-block alert-success fade in center">'.$_SESSION["errormsg"].'</div>');
    								unset($_SESSION["errormsg"]);
								};

								if(isset($_SESSION["reportmsg"])) {
    								echo clear_server_name('<div class="alert alert-block alert-warning fade in center">'.$_SESSION["reportmsg"].'</div>');
    								unset($_SESSION["reportmsg"]);
								};
							?>
					<table class="table table-bordered table-striped">
						<thead>
							<tr>
								<th>Number</th>
								<th>IGN <span class="label label-info"><?php echo count( $Players ); ?></span></th>
								<th class="frags-column">Score</th>
								<th class="frags-column">Time</th>
								<th class="frags-column">Take Live Screenshot</th>
								<?php if(isset($_SESSION['steamid'])) {?>
								<th class="frags-column">Admin actions</th>
								<?php };?>
							</tr>
						</thead>
						<tbody>
							<?php if( !empty( $Players ) ): ?>
							<?php 
										$i=1;
										$a=1;
										$b=1;


									?>
							<?php foreach( $Players as $Player ): ?>
							<tr>
								<td>
									<?php echo $i++ ;?>
								</td>
								<td>
									<?php echo htmlspecialchars( $Player[ 'Name' ] ); ?>
								</td>
								<td>
									<?php echo $Player[ 'Frags' ]; ?>
								</td>
								<td>
									<?php echo $Player[ 'TimeF' ]; ?>
								</td>
								<td class="text-center">
									<?php if(!isset($_SESSION['steamid'])) {?>






									<!-- Modal button getss command -->
									<button type="button" class="btn btn-danger btn-xs " data-toggle="modal" data-target="#tell-<?php echo $a++ ;?>"><i class="fa fa-camera" aria-hidden="true"></i> Take Screenshot</button>
									<!-- Modal -->
									<div id="tell-<?php echo $b++ ;?>" class="modal fade" role="dialog">
										<div class="modal-dialog">
											<!-- Modal tell command-->
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal">&times;</button>
													<h4 class="modal-title">Take Screenshot of :
														<?php echo htmlspecialchars( $Player[ 'Name' ] ); ?>
													</h4>
												</div>
												<div class="modal-body">
													<p>
														<form method="post" action="addons/rcon_cmd/getss.php">
															<div class="form-group">
																<p>Please verify your Humanity</p>
																<div class="g-recaptcha" data-sitekey="6Lcz50EUAAAAAKUxr0eSY1UWPFeWCh5ht2rlKAFC"></div>
																<button type="submit" class="btn btn-danger"><i class="fa fa-camera" aria-hidden="true"></i> Take Screenshot</button>
															</div>
															<input type="hidden" name="command" value="getss">
															<input type="hidden" name="player" value="<?php echo $Player[ 'Id' ]; ?>">
															<input type="hidden" name="player_name" value="<?php echo htmlspecialchars($Player['Name']);?>">
															<input type="hidden" name="server_id" value="<?php echo $server['id'];?>">

														</form>
													</p>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
												</div>
											</div>
										</div>
									</div>



									<?php };?>
								</td>

								<!-- Modal -->
								<div class="modal fade" id="myModalss" role="dialog">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
												<h4 class="modal-title">Take Screenshot of :
													<?php echo htmlspecialchars($Player['Name']);?>
												</h4>
											</div>
											<div class="modal-body">
												<p>Continue reCAPTHA</p>
												<form method="post" class="pull-left" id="comment_form" action="addons/rcon_cmd/getss.php" method="post">

													<div class="g-recaptcha" data-sitekey="6Lcz50EUAAAAAKUxr0eSY1UWPFeWCh5ht2rlKAFC"></div>
											</div>
											<div class="modal-footer">
												<button type="submit" class="btn btn-default" data-dismiss="modal">Close</button>
												<button type="button" name="submit" class="btn btn-primary">Take ScreenShot</button>
												</form>
											</div>
										</div>
									</div>
								</div>







								<?php if(isset($_SESSION['steamid'])) {?>
								<td>

									<!-- Modal button tell command -->
									<button type="button" class="btn btn-info btn-xs pull-left" data-toggle="modal" data-target="#tell-<?php echo $a++ ;?>">PM</button>
									<!-- Modal -->
									<div id="tell-<?php echo $b++ ;?>" class="modal fade" role="dialog">
										<div class="modal-dialog">
											<!-- Modal tell command-->
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal">&times;</button>
													<h4 class="modal-title">Send a private message to
														<?php echo htmlspecialchars( $Player[ 'Name' ] ); ?>
													</h4>
												</div>
												<div class="modal-body">
													<p>
														<form method="post" action="addons/rcon_cmd/tell.php">
															<div class="form-group">
																<input type="text" name="message" class="form-control" placeholder="Your Private Message" value="" required="">
															</div>
															<div class="form-group">
																<button type="submit" class="btn btn-primary">Send message</button>
															</div>
															<input type="hidden" name="command" value="tell">
															<input type="hidden" name="player" value="<?php echo $Player[ 'Id' ]; ?>">
															<input type="hidden" name="player_name" value="<?php echo $user['steam_user_personaname'];?>">
															<input type="hidden" name="server_id" value="<?php echo $server['id'];?>">
														</form>
													</p>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
												</div>
											</div>
										</div>
									</div>


									<!-- Modal button kick command -->
									<button type="button" class="btn btn-success btn-xs pull-right" data-toggle="modal" data-target="#kick-<?php echo $a++ ;?>">Kick</button>
									<!-- Modal -->
									<div id="kick-<?php echo $b++ ;?>" class="modal fade" role="dialog">
										<div class="modal-dialog">
											<!-- Modal kick command-->
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal">&times;</button>
													<h4 class="modal-title">Kick player
														<?php echo htmlspecialchars( $Player[ 'Name' ] ); ?>
													</h4>
												</div>
												<div class="modal-body">
													<p>
														<form method="post" action="addons/rcon_cmd/kick.php">
															<div class="form-group">
																<input type="text" name="message" class="form-control" placeholder="Reason for the kick" value="" required="">
															</div>
															<div class="form-group">
																<button type="submit" class="btn btn-primary">Kick player</button>
															</div>
															<input type="hidden" name="command" value="kick">
															<input type="hidden" name="player" value="<?php echo $Player[ 'Id' ]; ?>">
															<input type="hidden" name="player_name" value="<?php echo $user['steam_user_personaname'];?>">
															<input type="hidden" name="server_id" value="<?php echo $server['id'];?>">
														</form>
													</p>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
												</div>
											</div>
										</div>
									</div>

									<!-- Modal button tempban command -->
									<button type="button" class="btn btn-warning btn-xs pull-right" data-toggle="modal" data-target="#tempban-<?php echo $a++ ;?>">Tempban</button>
									<!-- Modal -->
									<div id="tempban-<?php echo $b++ ;?>" class="modal fade" role="dialog">
										<div class="modal-dialog">
											<!-- Modal tempban command-->
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal">&times;</button>
													<h4 class="modal-title">Tempban player
														<?php echo htmlspecialchars( $Player[ 'Name' ] ); ?>
													</h4>
												</div>
												<div class="modal-body">
													<p>
														<form method="post" action="addons/rcon_cmd/tempban.php">
															<div class="form-group">
																<input type="text" name="message" class="form-control" placeholder="Reason for the tempban" value="" required="">
															</div>
															<div class="form-group">
																<label for="tempban_time">Tempban expires in:</label>
																<select class="selectpicker form-control" name="tempban_time">
																				<optgroup label="Minutes">
																					<option value="5m">5 min</option>
 																					<option value="10m">10 min</option>
 																					<option value="20m">20 min</option>
 																					<option value="30m">30 min</option>
 																					<option value="45m">45 min</option>
																				</optgroup>
																				<optgroup label="Hours">
																					<option value="1h">1 hour</option>
 																					<option value="2h">2 hour</option>
 																					<option value="5h">5 hour</option>
 																					<option value="8h">8 hour</option>
 																					<option value="12h">12 hour</option>
																				</optgroup>
																				<optgroup label="Days">
																					<option value="1d">1 day</option>
 																					<option value="2d">2 day</option>
 																					<option value="3d">3 day</option>
 																					<option value="5d">5 day</option>
 																					<option value="7d">7 day</option>
																				</optgroup>
																			</select>
															</div>
															<div class="form-group">
																<button type="submit" class="btn btn-primary">Tempban player</button>
															</div>
															<input type="hidden" name="command" value="tempban">
															<input type="hidden" name="player" value="<?php echo $Player[ 'Id' ]; ?>">
															<input type="hidden" name="player_name" value="<?php echo $user['steam_user_personaname'];?>">
															<input type="hidden" name="server_id" value="<?php echo $server['id'];?>">
														</form>
													</p>
												</div>
												<div class="modal-footer">
													<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
												</div>
											</div>
										</div>
									</div>








								</td>
								<?php };?>
							</tr>
							<?php endforeach; ?>
							<?php else: ?>
							<tr>
								<td colspan="3">No players received</td>
							</tr>
							<?php endif; ?>
						</tbody>
					</table>
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






								<?php if(isset($_SESSION['steamid'])) {?>
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
										<?php
								echo '
								<table id="datatable-responsive" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">';
					
									$server_ip = $server['server_ip'];
									$server_port = $server['server_port'];                    
									$directory = 'screenshots/'.$server['id'].'/';
									$images = glob($directory . "*.jpg");
									
									include("include/PHP_JPEG_Metadata_Toolkit_1.12/JPEG.php");
									
									$num_img=1;
									$c=1;
									$d=1;
									
									foreach($images as $image)
									{
										$filecontent=file_get_contents($image); 
										$metapos=strpos($filecontent, "CoD4X");
										$meta = substr($filecontent,$metapos);
										$data=explode("\0",$meta);
										$hostname=$data[1];
										$map=$data[2];
										$playername=$data[3];
										$guid=$data[4];
										$shotnum=$data[5];
										$time=$data[6];
				  echo'
				  <tr>
					  <td>';
					  		
							echo '<a href="'.$image.'?'.date('U').'" data-toggle="lightbox" data-gallery="multiimages" data-title="'.clear_server_name($playername).' ('.friendly_mapname($map).')"><i class="fa fa-camera"></i> '.clear_server_name($playername).'</a> ('.friendly_mapname($map).')';

							echo '
					  			<div class="btn-group pull-right">
                      				<button type="button" class="btn btn-danger btn-xs">Action</button>
                      				<button type="button" class="btn btn-danger btn-xs dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                      				  <span class="caret"></span>
                      				  <span class="sr-only">Toggle Dropdown</span>
                      				</button>
                      				<ul class="dropdown-menu" role="menu">
										<li>
											<form method="post" action="addons/screenshots/delete-img.php">
												<input type="hidden" name="img_path" value="'.$image.'">
												<input type="hidden" name="server_id" value="'.$server['id'].'">
												<button name="delimage" class="btn btn-link" type="submit">Delete this screenshot</button></li>
											</form>
										</li>	
                      				  <li class="divider"></li>
                      				  <li>';?>
											<!-- Modal button permban command -->
											<button type="button" class="btn btn-link" data-toggle="modal" data-target="#permban-<?php echo $c++ ;?>">Permban</button>
											<?php echo '
                      				  </li>
                      				</ul>';?>
											<div id="permban-<?php echo $d++ ;?>" class="modal fade" role="dialog">
												<div class="modal-dialog">
													<!-- Modal permban command-->
													<div class="modal-content">
														<div class="modal-header">
															<button type="button" class="close" data-dismiss="modal">&times;</button>
															<h4 class="modal-title">Permban player
																<?php echo $playername; ?>
															</h4>
														</div>
														<div class="modal-body">
															<p>
																<form method="post" action="addons/rcon_cmd/permban.php">
																	<div class="form-group">
																		<input type="text" name="message" class="form-control" placeholder="Reason for the permban" value="" required="">
																	</div>
																	<div class="form-group">
																		<button type="submit" class="btn btn-primary">Permban player</button>
																	</div>
																	<input type="hidden" name="command" value="permban">
																	<input type="hidden" name="server_id" value="<?php echo $server['id'];?>">
																	<?php 
																		echo '
																			<input type="hidden" name="player_name" value="'.clear_server_name($playername).'">
																			<input type="hidden" name="server_name" value="'.clear_server_name($hostname).'">
																			<input type="hidden" name="map" value="'.friendly_mapname($map).'">
																			<input type="hidden" name="time" value="'.$time.'">
																			<input type="hidden" name="guid" value="'.$guid.'">
																			<input type="hidden" name="banned_by" value="'.clear_server_name($steamprofile['personaname']).'">
																			<input type="hidden" name="screenshot_url" value="'.$image.'">
																		';
																		?>
																</form>
															</p>
														</div>
														<div class="modal-footer">
															<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
														</div>
													</div>
												</div>
											</div>
											<?php echo'
								</div>';
						echo '</td>';}
				echo'</tr>
				</tbody>
			</table>';
			?>
									</div>
								</div>

								<div class="panel panel-default">
									<div class="panel-heading">Commands wiki</div>
									<div class="panel-body">
										<ul class="list-group">
											<li class="list-group-item"><span class="btn btn-dark btn-xs"><i class="fa fa-camera" aria-hidden="true"></i></span> Create a screenshot of Player</li>
											<li class="list-group-item"><span class="btn btn-info btn-xs">PM</span> Send private message to Player</li>
											<li class="list-group-item"><span class="btn btn-success btn-xs">Kick</span> Kick Player</li>
											<li class="list-group-item"><span class="btn btn-warning btn-xs">TempBan</span> Tempban Player</li>
											<li class="list-group-item"><span class="btn btn-danger btn-xs">Permban</span> Permban Player on all servers</li>
										</ul>
									</div>
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
