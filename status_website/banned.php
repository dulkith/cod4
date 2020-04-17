<?php 

error_reporting(E_ALL);
ini_set('display_errors', 1);


include_once("header.php");

if(isset($_GET["server_id"])){
	$id = htmlentities($_GET['server_id']);
} else {
	header("location: 404.php");
	exit();	
}
$db->where ('server_id', $id);
$db->orderBy("id","desc");
$b_players = $db->get('banned_players');

if(!empty($b_players[0]['server_name'])){
	$server_title=$b_players[0]['server_name'];
}else {
	$server_title=$_GET["server_id"];
}
	

$title="Banned players - ".$server_title;
include_once("navigation.php");
?>
		
			
<div class="right_col" role="main">
	  <div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
		  <div class="x_panel">
			<div class="x_title">
			  <h2>Banned players <small><?php echo $server_title;?></small></h2>
			  <div class="clearfix"></div>
			</div>
			<div class="x_content">
			  <p class="text-muted font-13 m-b-30"> Here is the list of players who have ben banned on our servers. If you think that you are unfairly banned please contact us, <strong>check first the evidence against you here</strong>. </p>
			  <?php if(isset($_SESSION['steamid'])) {?>
				<?php			
					if(isset($_SESSION["delreport"])) {
    					echo '<div class="alert alert-block alert-success fade in center">'.$_SESSION["delreport"].'</div>';
    					unset($_SESSION["delreport"]);
					};
				?>
				<?php };?>
			  <table id="datatable-responsive" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
				<thead>
				  <tr>
					<th>Player name</th>
					<th>Server name</th>
					<th>Map</th>
					<th>Time</th>
					<th>Guid</th>
					<th>Banned by Admin</th>
					<th style="width:15%">Link to screenshot</th>
									  </tr>
				</thead>
				<tbody>
				<?php foreach ($b_players as $player){ ?>
					<tr>
					  <td><?php echo $player['player_name'];?>
					  <?php if(isset($_SESSION['steamid'])) {?> 
						<form method="post" class="pull-right" action="addons/rcon_cmd/unban.php">
							<input type="hidden" name="player" value="<?php echo $player['guid'];?>">
							<input type="hidden" name="command" value="unban">
							<input type="hidden" name="screenshot_url" value="<?php echo '../../'.$player['screenshot_url'].'';?>">
							<input type="hidden" name="id" value="<?php echo $player['id'];?>">
							<input type="hidden" name="server_id" value="<?php echo $_GET['server_id'];?>">
							<button type="submit" class="btn btn-danger btn-xs pull-right" name="delban" data-toggle="tooltip" title="" data-original-title="Delete ban" required"><i class="fa fa-trash" aria-hidden="true"></i> Delete ban</button>
						</form>
					  <?php };?></td>
					  <td><?php echo $player['server_name'];?></td>
					  <td><?php echo $player['map'];?></td>
					  <td><?php echo $player['time'];?></td>
					  <td><?php echo $player['guid'];?></td>
					  <td><?php echo $player['banned_by'];?></td>
						 <td>                      
							<a href="<?php echo ''.$player['screenshot_url'].'?'.date('U').'';?>" data-toggle="lightbox" data-gallery="multiimages" data-title="<?php echo $player['player_name'];?> (<?php echo $player['map'];?>)"><i class="fa fa-camera"></i> Screenshot</a>
						 </td>
					</tr>
				<?php };?>
				</tbody>
			  </table>
			</div>
		  </div>
		</div>
	  </div>			
<!-- Datatables --> 
<!-- <script src="js/datatables/js/jquery.dataTables.js"></script>
  <script src="js/datatables/tools/js/dataTables.tableTools.js"></script> --> 

<!-- Datatables--> 
<script src="<?php home_url();?>assets/js/datatables/jquery.dataTables.min.js"></script> 
<script src="<?php home_url();?>assets/js/datatables/dataTables.bootstrap.js"></script> 
<script src="<?php home_url();?>assets/js/datatables/dataTables.buttons.min.js"></script> 
<script src="<?php home_url();?>assets/js/datatables/buttons.bootstrap.min.js"></script> 
<script src="<?php home_url();?>assets/js/datatables/dataTables.fixedHeader.min.js"></script> 
<script src="<?php home_url();?>assets/js/datatables/dataTables.keyTable.min.js"></script> 
<script src="j<?php home_url();?>assets/js/datatables/dataTables.responsive.min.js"></script> 
<script src="<?php home_url();?>assets/js/datatables/responsive.bootstrap.min.js"></script> 
<script type="text/javascript">
          $(document).ready(function() {
            $('#datatable').dataTable();
            $('#datatable-keytable').DataTable({
              keys: true
            });
            $('#datatable-responsive').DataTable();
            $('#datatable-scroller').DataTable({
              ajax: "js/datatables/json/scroller-demo.json",
              deferRender: true,
              scrollY: 380,
              scrollCollapse: true,
              scroller: true
            });
            var table = $('#datatable-fixed-header').DataTable({
              fixedHeader: true
            });
          });
          TableManageButtons.init();
</script>
<script src="<?php home_url();?>assets/js/ekko-lightbox.min.js"></script>
<script type="text/javascript">
			$(document).ready(function ($) {

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
