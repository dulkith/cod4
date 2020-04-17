<?php 

error_reporting(E_ALL);
ini_set('display_errors', 1);


include_once("header.php");
$servers = $db->get('my_servers');

$db->orderBy("id","desc");
$b_players = $db->get('banned_players', 5);
$title="Cirkus Serveri";
include_once("navigation.php");
?>
<div class="right_col" role="main">
	<div class="row">
		<div class="col-md-8 col-sm-8 col-xs-12">

			<div class="">



				<div id="myCarousel" class="carousel slide" data-ride="carousel">
					<!-- Indicators -->
					<ol class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<li data-target="#myCarousel" data-slide-to="2"></li>
					</ol>

					<!-- Wrapper for slides -->
					<div class="carousel-inner">
						<div class="item active">
							<img src="assets/images/slide1.jpg" alt="Los Angeles" style="width:100%;">
						</div>

						<div class="item">
							<img src="assets/images/slide1.jpg" alt="Chicago" style="width:100%;">
						</div>

						<div class="item">
							<img src="assets/images/slide1.jpg" alt="New york" style="width:100%;">
						</div>
					</div>

					<!-- Left and right controls -->
					<a class="left carousel-control" href="#myCarousel" data-slide="prev">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
					<a class="right carousel-control" href="#myCarousel" data-slide="next">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
				</div>



			</div>
			</br>


			<div class="x_panel">
				<div class="x_title">
					<h2>COD4 Servers</h2>
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
								<th>Map</th>
							</tr>
						</thead>
						<tbody>
							<?php	
									if ( !empty ( $servers ) ) {//show if not empty
										foreach ( $servers as $server ) {?>
								<tr>
									<td><img src="<?php home_url();?>assets/images/flags/<?php echo $server['server_location'];?>.png"></td>
									<td>
										<a href="<?php home_url();?>server-details.php?id=<?php echo $server['id'];?>">
											<?php echo $server['server_name'];?>
										</a> <br />
										<small><?php echo $server['server_game'];?></small></td>
									<td><a href="cod4://<?php echo $server['server_ip'];?>:<?php echo $server['server_port'];?>" data-toggle="tooltip" title="Join via COD4x - COD4x Client required"><img src="<?php home_url();?>assets/images/cod4.gif" alt="cod4" class="avatar"></a></td>
									<td class="project_progress">
										<div class="progress progress_sm">
											<div class="progress-bar bg-red" role="progressbar" data-transitiongoal="<?php $get_percent = calculate_total($server['server_online_players'], $server['server_maxplayers']); echo $get_percent;?>"></div>
										</div>
										<small><?php echo $server['server_online_players'];?>/<?php echo $server['server_maxplayers'];?></small></td>
									<td>
										<?php echo $server['server_ip'];?>:
										<?php echo $server['server_port'];?>
									</td>
									<td>
										<?php echo friendly_mapname($server['server_current_map']);?>
									</td>
								</tr>
								<?php }};?>
						</tbody>
					</table>
				</div>
			</div>

			<div class="x_panel" style="background-color:#fff; width:100%" id="chatwee-widget">
				<div class="x_title">
					<h2>Gametracker<small>Server information</small></h2>
					<ul class="nav navbar-right panel_toolbox">
						<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
						<li><a class="close-link"><i class="fa fa-close"></i></a> </li>
					</ul>
					<div class="clearfix"></div>
				</div>
				<div class="x_content">

					<a href="https://www.gametracker.com/server_info/188.166.182.27:28960/" target="_blank"><img src="http://cache.gametracker.com/server_info/188.166.182.27:28960/b_560_95_1.png" border="0" width="100%" height="120" alt=""/></a>

					<hr>

					<a href="https://www.gametracker.com/server_info/139.99.102.214:28961/" target="_blank"><img src="http://cache.gametracker.com/server_info/139.99.102.214:28961/b_560_95_1.png" border="0" width="100%"" height="120" alt=""/></a>

					<hr>

					<a href="https://www.gametracker.com/server_info/139.99.102.214:28960/" target="_blank"><img src="http://cache.gametracker.com/server_info/139.99.102.214:28960/b_560_95_1.png" border="0" width="100%" height="120" alt=""/></a>

				</div>
			</div>


			<div class="x_panel" style="background-color:#fff; width:100%" id="chatwee-widget">
				<div class="x_content">

					<div id="fb-root"></div>
					<script>
						(function(d, s, id) {
							var js, fjs = d.getElementsByTagName(s)[0];
							if (d.getElementById(id)) return;
							js = d.createElement(s);
							js.id = id;
							js.src = 'https://connect.facebook.net/si_LK/sdk.js#xfbml=1&version=v2.12&appId=403073069772231&autoLogAppEvents=1';
							fjs.parentNode.insertBefore(js, fjs);
						}(document, 'script', 'facebook-jssdk'));

					</script>

					<div class="fb-comments" data-href="https://www.facebook.com/groups/darklioncod4/" data-width="100%" data-numposts="5" data-order-by="reverse_time"></div>

				</div>
			</div>




		</div>
		<div class="col-md-4 col-sm-4 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>Dark Lion<small>Game Rules</small></h2>

					<ul class="nav navbar-right panel_toolbox">

						<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a> </li>
						<li><a class="close-link"><i class="fa fa-close"></i></a> </li>
					</ul>
					<div class="clearfix"></div>
					<li class="list-group-item">★ රූල් #1 : කනාවට මැච් එකක ඉස්කෝ කරා කියල නිකං Pro කියල ඛෙරිහන් දෙන්න එපා හෙන චාටර් හොදේ. ඊයා.....</li>
					<li class="list-group-item">★ රූල් #2 : Lag කියල කෑගහන්න එපා අපිට අදාල නෑ ඒක.</li>
					<li class="list-group-item">★ රූල් #3 : කුණුහබ්බ නම් කියන්න එපා අපිත් දන්නව උඔලට වඩා කියන්නෙ නැත්තෙ ගොනා වෙන්න අකමැති නිසා.</li>
					<li class="list-group-item">★ රූල් #4 : Admin වෙන්න කලින් Reguler වෙලා හිටපං වාතයක් නොවී.</li>
					<li class="list-group-item">★ රූල් #5 : Hack දාගෙන ගහල ගොනා වෙන්නෙ තමන්මයි, Hack දාගෙන ගේම් ගහන්නැතුව ගේම් ගහන කාලෙ මිනිහෙක් වෙයං බං ඉස්සෙල්ල.</li>
					<li class="list-group-item">★ රූල් #6 : Iam Pro කියුවොත් දෙපාරක් හිතන්නෙ නැතුව පිිලිගනිං පවුනෙ ආසවනෙ.</li>
					<li class="list-group-item">★ රූල් #7 : You're Noob කියුවොත් අනේ ඔන්න ඔහෙ පිිලිගනිං ඇගෙං ඇටයක් යනවද ආසවනෙ.</li>
					<li class="list-group-item">★ රූල් #8 : Promod SnD එකේ අන්තිමට ඉතුරු වෙන එකා බයකරන්න එපා යකූ ඌ ඉන්න තත්වෙ දන්නෙ ඌ විතරයි.</li>
					<li class="list-group-item">★ රූල් #9 : Admin අප්පුලට කියන්නේ Ban කරන්න කිලින් Screenshot කෑල්ලක් ගනිල්ල.</li>
					<li class="list-group-item">★ රූල් #10 : රූල් 10 කියල එකක් නෑ ඔය රූල් ටික පිළිපැදපං.</li><br>

					<li class="list-group-item">Number of Visits:
						<div id="sfcqqd6fqqkf7c6h4qmazml3ncffaxuq6en"></div>
						<script type="text/javascript" src="https://counter2.freecounter.ovh/private/counter.js?c=qqd6fqqkf7c6h4qmazml3ncffaxuq6en&down=async" async></script>
						<noscript><img src="https://counter2.freecounter.ovh/private/freecounterstat.php?c=qqd6fqqkf7c6h4qmazml3ncffaxuq6en" border="0" title="web hit counter" alt="web hit counter"></noscript>
					</li>
				</div>
			</div>
		</div>
		<?php include("footer.php"); ?>
