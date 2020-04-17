<?php 
include_once("header.php");

// show potential errors / feedback (from login object)
if (isset($login)) {
	if ($login->errors) {
		foreach ($login->errors as $error) {
			$err = $error;
		}
	}
	if ($login->messages) {
		foreach ($login->messages as $message) {
			$msg = $message;
		}
	}
}

$title="Cirkus Serveri";

include_once("navigation.php");

?>
<div class="right_col" role="main">
	  <div class="row">
		<div class="col-md-4 col-sm-8 col-xs-12">
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
				
					<div class="col-md-10 col-sm-12 col-xs-12">
					<form action="login.php" name="loginform" method="post" class="form-horizontal form-label-left input_mask">
						<div class="col-md-12 col-sm-12 col-xs-12 form-group has-feedback">
							<input type="text" id="login_input_username" name="user_name" class="form-control has-feedback-left" placeholder="Email or Username" required autofocus>
							<span class="fa fa-user form-control-feedback left" aria-hidden="true"></span>
						</div>
						<div class="col-md-12 col-sm-12 col-xs-12 form-group has-feedback">
							<input type="password" id="login_input_password" class="form-control has-feedback-left" placeholder="Password" name="user_password" autocomplete="off" required>
							<span class="fa fa-key form-control-feedback left" aria-hidden="true"></span>
						</div>
						
						<div class="fcol-md-12 col-sm-12 col-xs-12 form-group">
							<button type="submit" name="login" class="btn btn-primary pull-left">Sign In</button>


							<div class="clearfix"></div>
						</div>	
					
				</form>
				</div>
			</div>
		  </div>
		</div>
	  </div>
<script type="text/javascript">	
function generate(type, theme) {
	var n = noty({
	text        : type,
	type        : 'error',
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
		if (isset($login)) {
			if ($login->errors) {
				foreach ($login->errors as $error) {?>
					generate('<h3>Error</h3><?php echo "$error";?>', "bootstrapTheme");
				<?php }
			}
			if ($login->messages) {
				foreach ($login->messages as $message) {?>
					generate('<?php echo "$message";?>', "bootstrapTheme");
				<?php }
			}
		}
	?>   
}
$(document).ready(function () {
	generateAll();
	});		
</script>
<?php include("footer.php"); ?>
