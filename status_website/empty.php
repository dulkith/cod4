<?php 

error_reporting(E_ALL);
ini_set('display_errors', 1);


include_once("header.php");
include_once("navigation.php");
?>


<div class="right_col" role="main">
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">
				<div class="x_title">
					<h2>Buy Game Server <small>This is what we provide and you might looking for</small></h2>
					<div class="clearfix"></div>
				</div>
				<div class="x_content">
					
						
					



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
