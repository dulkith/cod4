<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Dark Lion Gaming</title>

	<!-- Bootstrap core CSS -->
	<link href="<?php home_url();?>assets/css/bootstrap.min.css" rel="stylesheet">
	<link href="<?php home_url();?>assets/fonts/css/font-awesome.min.css" rel="stylesheet">
	<link href="<?php home_url();?>assets/css/animate.min.css" rel="stylesheet">
	<link href="<?php home_url();?>assets/css/switchery/switchery.min.css" rel="stylesheet">

	<link href="<?php home_url();?>assets/css/ekko-lightbox.css" rel="stylesheet">
	<link href="<?php home_url();?>assets/css/dark.css" rel="stylesheet">

	<!-- Custom styling plus plugins -->
	<link href="<?php home_url();?>assets/css/icheck/flat/red.css" rel="stylesheet" />
	<link href="<?php home_url();?>assets/css/custom.css" rel="stylesheet">
	<link href="<?php home_url();?>assets/js/datatables/jquery.dataTables.min.css" rel="stylesheet" type="text/css" />
	<link href="<?php home_url();?>assets/js/datatables/buttons.bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<?php home_url();?>assets/js/datatables/fixedHeader.bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<?php home_url();?>assets/js/datatables/responsive.bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="<?php home_url();?>assets/js/datatables/scroller.bootstrap.min.css" rel="stylesheet" type="text/css" />
	<script src="<?php home_url();?>assets/js/nprogress.js"></script>
	<script src="<?php home_url();?>assets/js/jquery.min.js"></script>
	
	 <script src='https://www.google.com/recaptcha/api.js'></script>
	<!--[if lt IE 9]>
				<script src="<?php home_url();?>assets/js/ie8-responsive-file-warning.js"></script>
		<![endif]-->

	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
			<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery.lazyloadxt/1.0.0/jquery.lazyloadxt.min.js"></script>

    <script type="text/javascript">
        $("[data-fancybox]").fancybox({});
    </script>

</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<div class="col-md-3 left_col">
				<div class="left_col scroll-view">
					<div class="navbar nav_title"> <a href="<?php home_url();?>" class="site_title"><img src="assets/images/dark lion cod4_min.png"></a></div>
					<div class="clearfix"></div>

					<br />
					<div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
						<div class="menu_section">
							<h3>General menu</h3>
							<ul class="nav side-menu">

								<li><a href="<?php home_url();?>"><i class="fa fa-home"></i> Home </a></li>

								<li><a><i class="fa fa-desktop"></i> Game Servers <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">

										<?php
												$nav_servers = $db->get('my_servers');
												if ( !empty ( $nav_servers ) ) {//show if not empty
													foreach ( $nav_servers as $nav_server ) {
											?>

											<li>
												<a href="<?php home_url();?>server-details.php?id=<?php echo $nav_server['id'];?>">
													<?php echo $nav_server['server_name'];?>
												</a>
											</li>
											<?php } //loop end
											}//show if not empty end
											;?>
									</ul>
								</li>

								<li><a><i class="fa fa-image"></i> Screenshots <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">

										<?php
												$nav_servers = $db->get('my_servers');
												if ( !empty ( $nav_servers ) ) {//show if not empty
													foreach ( $nav_servers as $nav_server ) {
											?>

											<li>
												<a href="<?php home_url();?>server-screenshots.php?id=<?php echo $nav_server['id'];?>">
													<?php echo $nav_server['server_name'];?>
												</a>
											</li>
											<?php } //loop end
											}//show if not empty end
											;?>
									</ul>
								</li>

								<li><a><i class="fa fa-ban"></i> Ban / TempBan / Kick<span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
										<?php
												$nav_servers = $db->get('my_servers');
												if ( !empty ( $nav_servers ) ) {//show if not empty
													foreach ( $nav_servers as $nav_server ) {
											?>

											<li>
												<a href="<?php home_url();?>public-ban-list.php?id=<?php echo $nav_server['id'];?>">
													<?php echo $nav_server['server_name'];?>
												</a>
											</li>
											<?php } //loop end
											}//show if not empty end
											;?>
									</ul>
								</li>
								
								<li><a><i class="fa fa-list-ol"></i> Top Skill Players <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">

										<?php
												$nav_servers = $db->get('my_servers');
												if ( !empty ( $nav_servers ) ) {//show if not empty
													foreach ( $nav_servers as $nav_server ) {
											?>

											<li>
												<a href="<?php home_url();?>top-20.php?id=<?php echo $nav_server['id'];?>">
													<?php echo $nav_server['server_name'];?>
												</a>
											</li>
											<?php } //loop end
											}//show if not empty end
											;?>
									</ul>
								</li>

								<li><a><i class="fa fa-users"></i> Server Admins <span class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu" style="display: none">
										<?php
												$nav_servers = $db->get('my_servers');
												if ( !empty ( $nav_servers ) ) {//show if not empty
													foreach ( $nav_servers as $nav_server ) {
											?>

											<li>
												<a href="<?php home_url();?>server-admins.php?id=<?php echo $nav_server['id'];?>">
													<?php echo $nav_server['server_name'];?>
												</a>
											</li>
											<?php } //loop end
											}//show if not empty end
											;?>
									</ul>
								</li>
								
								<li><a href="http://darklion.tk/xlr/index.php/1"><i class="fa fa-trophy"></i> XLRstats </a></li>
								
								<li><a href="clan.php"><i class="fa fa-gamepad"></i> [DL] Clan </a></li>

								<li><a href="promod-music.php"><i class="fa fa-music"></i> Promod Kill-Cam Music </a></li>

								<li><a href="cart.php"><i class="fa fa-shopping-cart"></i> Buy Game Server </a></li>

								<li><a href="http://darklion.tk/gpanel/index.php"><i class="fa fa-tachometer"></i> Game Panel </a></li>

								<li><a href="ts3server://darklion.tk/?port=9987&nickname=DARK LION Guest"><i class="fa fa-microphone"></i> Join Teamspesk 3 Server </a></li>

								<li><a href="<?php home_url();?>contact_us.php"><i class="fa fa-envelope"></i> Contact </a>
								</li>

								<li><a data-toggle="modal" data-target="#myModal"><i class="fa fa-info-circle"></i> About </a></li>


								<!-- Modal -->
								<div class="modal fade" id="myModal" role="dialog">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
												<h4 class="modal-title">ABOUT DARK LION PANEL</h4>
											</div>
											<div class="modal-body">
												<p>Panel Vershion : 3.1</p>
												<p class="text-warning"><small></small></p>
												<p class="text-warning"><small>Developed by : GAPPIYA</small></p>
												<p class="text-warning"><small>Date : 2018/02/08</small></p>
												<p class="text-warning"><small>Country : Sri Lanka</small></p>
											</div>
											<div class="modal-footer">
												<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
											</div>
										</div>
									</div>
						</div>



						</ul>
					</div>

					<?php if ($login->hasPrivilege() == true) {?>
					<div class="menu_section">
						<h3>Administration</h3>
						<ul class="nav side-menu">
							<li><a><i class="fa fa-bug"></i> Server Settings <span class="fa fa-chevron-down"></span></a>
								<ul class="nav child_menu" style="display: none">
									<li><a href="<?php home_url();?>admin/my-servers.php">My Servers</a> </li>
									<li><a href="<?php home_url();?>admin/server-admins.php">Server Admins</a> </li>
								</ul>
							</li>
						</ul>
					</div>
					<?php };?>
				</div>
				<div class="sidebar-footer hidden-small">
					<?php if ($login->isUserLoggedIn() == false) {?>
					<a data-toggle="tooltip" data-placement="top" href="<?php home_url();?>admin/index.php" title="" data-original-title="Admin Login"><span class="fa fa-sign-in" aria-hidden="true"></span></a>
					<?php };?>
					<?php if ($login->isUserLoggedIn() == true) {?>
					<a data-toggle="tooltip" href="<?php home_url();?>?logout" data-placement="top" title="" data-original-title="Admin Logout"><span class="fa fa-sign-out" aria-hidden="true"></span></a>
					<?php };?>
					<a href="http://darklion.tk/gpanel/index.php" data-toggle="tooltip" data-placement="top" title="" data-original-title="Game Panel"><span class="fa fa-tachometer "></span></a>
					<a data-toggle="tooltip" data-placement="top" title="" data-original-title="Powered by Dark Lion"><span class="fa fa-info-circle" aria-hidden="true"></span></a>
					<a href="https://www.facebook.com/groups/darklioncod4/" target="_blank" data-toggle="tooltip" data-placement="top" title="" data-original-title="Dark Lion Group"><i class="fa fa-facebook-square" aria-hidden="true"></i></a>

				</div>
			</div>
		</div>
		<div class="top_nav">
			<div class="nav_menu">
				<nav class="">
					<div class="nav toggle"> <a id="menu_toggle"><i class="fa fa-bars"></i></a> </div>
					<ul class="nav navbar-nav navbar-right">
						<?php
									if(!isset($_SESSION['steamid'])) {
									    echo "<li class=''>";
									    loginbutton();
										echo "</li>";
										} else {
									    
						
									   	$db->where ('steam_id', $steam_admin);
										$st_admins = $db->get('steam_admins');
										$data = Array (
    											'steam_user_personaname' => clear_server_name($steamprofile['personaname']),
    											'steam_profile_url' => $steamprofile['profileurl'],
    											'steam_avatar' => $steamprofile['avatar']
											);
						
										$db->where ('steam_id', $steam_admin);

										if ($db->update ('steam_admins', $data))
										    $msg = 'Server updated';
										else
										    $msg = 'Update failed: ' . $db->getLastError();

										
										?>
							<li class="">
								<a href="#" class="user-profile dropdown-toggle" data-toggle="dropdown" aria-expanded="false"> <img src="<?php echo $user['steam_avatar'];echo '?='.date('U').''?>" alt=""><?php echo $user['steam_user_personaname'];?> <span class=" fa fa-angle-down"></span></a>
								<ul class="dropdown-menu dropdown-usermenu animated fadeInDown pull-right">
									<li><a href="<?php home_url();?>?logout"><i class="fa fa-sign-out pull-right"></i> Sign Out</a> </li>
								</ul>
							</li>'

							<?php };?>
					</ul>
				</nav>
			</div>
		</div>
