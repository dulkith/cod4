<?php 

include_once("../header.php");

if ($login->hasPrivilege() == false) {
	header("location: index.php");
	exit('Restricted access');
}
//Page title
$title="Server Admins";



require_once ('../classes/MysqliDb.php');

$admins = $db->get('users');

$db->orderBy("steam_id","asc");
$steam_admins = $db->get('steam_admins');

include_once("../navigation.php");
//Delete admin
if(isset($_POST['btn_delete']))
{
	$db->where('user_id', $_POST['id']);
		if($db->delete('users'))
			$message = 'Admin successfully deleted';
}


?>
	<div class="right_col" role="main">
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="x_panel">
					<div class="x_title">
						<h2>Server <small>Administrators</small></h2>
						<div class="clearfix"></div>
					</div>
					<div class="x_content">
						<p>Here you can manage and view the list of Admins on your Game Server</p>
						<div class="clearfix"></div>
						<table class="table table-striped projects">
							<thead>
								<tr>
									<th style="width: 1%">#</th>
									<th>Admin Name</th>								
									<th>Admin power</th>
									<th>Steam</th>
									<th>Admin UID</th>
									<th>Edit</th>
								</tr>
							</thead>
							<tbody>
								<?php	
									
							if ( !empty ( $admins ) ) {//show if not empty
								foreach ( $admins as $admin ) {?>
								<tr>
									<td>#</td>
									<td><?php echo $admin['user_name'] ?> (<?php echo $admin['user_email'] ?>)</td>
									
									<td class="project_progress">
										<div class="progress progress_sm">
											<div class="progress-bar bg-green" role="progressbar" data-transitiongoal="<?php echo $admin['role'] ?>"></div>
										</div>
										<small><?php echo $admin['role'] ?>% Admin power</small></td>
									<td><a href="<?php echo $admin['steam_profile_url'] ?>" target="_blank"><i class="fa fa-steam-square"></i> Steam Profile</a></td>
									<td><button type="button" class="btn btn-success btn-xs"><?php echo $admin['admin_uid'] ?></button></td>
									<td>
										<a href="<?php home_url() ?>admin/edit-admin.php?user_id=<?php echo $admin['user_id'] ?>" class="btn btn-primary btn-xs"><i class="fa fa-pencil"></i> Edit</a>
										<form method="post" class="pull-left">
											<input type="hidden" name="id" value="<?php echo $admin['user_id'];?>">
											<button type="submit" class="btn btn-danger btn-xs" name="btn_delete"><i class="fa fa-trash-o"></i> Delete</button>
										</form>
									</td>
								</tr>
								<?php } };?>
							</tbody>
							</table>

							<p>Server Administrators from your Steam Group(s) <a href="my-servers.php">Refresh the admin list</a></p>
						<div class="clearfix"></div>
						<table class="table table-striped projects">
							<thead>
								<tr>
									<th style="width: 4%">#</th>
									<th>Steam Admin Name</th>
									<th>Steam profile</th>
									<th>Steam Admin UID</th>
								</tr>
							</thead>
							<tbody>
								<?php	

									if ( !empty ( $steam_admins ) ) {//show if not empty
									foreach ( $steam_admins as $steam_admin ) {?>
										<tr>
											<td>
											<?php if (!empty($steam_admin['steam_avatar'])) {?>
											<img src="<?php echo $steam_admin['steam_avatar'];?>" class="user-profile"><?php };?></td>
											<td>
											<?php if (!empty($steam_admin['steam_user_personaname'])) {?>
											<?php echo $steam_admin['steam_user_personaname'] ?><?php } else {echo 'user has not logged in yet';};?></td>
											<td><a href="http://steamcommunity.com/profiles/<?php echo $steam_admin['steam_id'] ?>" target="_blank"><i class="fa fa-steam-square"></i> Steam 		Profile</a></td>
											<td><button type="button" class="btn btn-success btn-xs"><?php echo $steam_admin['steam_id'] ?></button></td>
										</tr>
								<?php }
								};?>
							</tbody>
						</table>
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
    			generate('<h3>Success</h3><?php echo 'Admin added successfully. Id='.$id.'';?>', "bootstrapTheme");
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
