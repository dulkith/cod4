<?php 

include_once("../header.php");

if(isset($_GET["user_id"])){
	$id = htmlentities($_GET['user_id']);
} else {
    header("location: server-admins.php");
    exit();	
}

if ($login->hasPrivilege() == false) {
	header("location: index.php");
	exit('Restricted access');
}
//Page title
$title="Server Admins";

include_once("../navigation.php");

require_once ('../classes/MysqliDb.php');

//Get the #ID
$db->where ("user_id", $id);
$user = $db->getOne ("users");

if(isset($_POST['btn_edit'])){

	$data = Array (
    'user_name' => $_POST['user_name'],
    'user_email' => $_POST['user_email'],
    'admin_uid' => $_POST['admin_uid'],
    'steam_profile_url' => $_POST['steam_profile_url'],
    'role' => $_POST['role']
	);
$db->where ('user_id', $id);
if ($db->update ('users', $data))
    $msg = 'User updated';
else
    $msg = 'Update failed: ' . $db->getLastError();
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
						<div class="clearfix"></div>
						<div class="col-md-6 col-sm-12 col-xs-12">
							<form method="post">
								<div class="form-group">
								    <!-- the user name input field uses a HTML5 pattern check -->
								    <label for="user_name">Username (only letters and numbers, 2 to 64 characters)</label>
								    <input class="form-control" type="text" pattern="[a-zA-Z0-9]{2,64}" name="user_name" value="<?php echo htmlentities($user['user_name']);?>" required />
								</div>
								<div class="form-group">
								    <!-- the email input field uses a HTML5 email type check -->
								    <label for="user_email">User's email</label>
								    <input class="form-control" type="email" name="user_email" value="<?php echo htmlentities($user['user_email']);?>" required />
								</div>
								<div class="form-group">
								    <label for="admin_uid">Admin UID</label>
								    <input class="form-control" type="text" name="admin_uid" value="<?php echo htmlentities($user['admin_uid']);?>" required />
								</div>
								<div class="form-group">
								    <label for="steam_profile_url">Steam profile url</label>
								    <input class="form-control" type="text" name="steam_profile_url" value="<?php echo htmlentities($user['steam_profile_url']);?>" required />
								</div>
								<div class="form-group">
								    <label for="role">Power</label>
								     <select class="form-control" name="role" required>
    									<option value="<?php echo htmlentities($user['role']);?>"><?php echo htmlentities($user['role']);?></option>
    									<option value="20">20</option>
    									<option value="40">40</option>
    									<option value="60">60</option>
    									<option value="80">80</option>
    									<option value="100">100</option>
    								</select>
								</div>
								<a href="server-admins.php" class="pull-right btn btn-info">Go back to server Admins</a>
								<input type="submit" class="btn btn-primary pull-right" name="btn_edit" value="Edit Admin" />			
							</form>
						</div>
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
		if(isset($_POST['btn_edit'])) {

			if ($id) {?>	
    			generate('<h3>Success</h3><?php echo 'Admin edited successfully. Id='.$id.'';?>', "bootstrapTheme");
            <?php } else { ?>	
    			generate('<h3>Error</h3><?php echo 'Edit failed: ' . $db->getLastError().'';?>', "bootstrapTheme");
        <?php }
		}
	?> 
}
$(document).ready(function () {
	generateAll();
	});		
</script>
<?php include("../footer.php"); ?>
