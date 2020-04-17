<?php
$auth_user_here = false;
$page = 'pubbans';
$page_title = 'Public Ban List';
$b3_conn = true; // this page needs to connect to the B3 database
$pagination = true; // this page requires the pagination part of the footer
$query_normal = true;
//require ROOT.'app/bootstrap.php';

checkBL(); // check the blacklist for the users IP (this is needed because this is a public page)

##########################
######## Varibles ########

## Default Vars ##
$orderby = "time_add";
$order = "DESC";

## Sorts requests vars ##
if(isset($_GET['ob']) && $_GET['ob'])
	$orderby = addslashes($_GET['ob']);

if(isset($_GET['o']) && $_GET['o'])
	$order = addslashes($_GET['o']);

// allowed things to sort by
$allowed_orderby = array('name', 'time_add', 'time_expire');
if(!in_array($orderby, $allowed_orderby)) // Check if the sent varible is in the allowed array 
	$orderby = 'time_add'; // if not just set to default id

## Page Vars ##
if(isset($_GET['p']) && $_GET['p'])
  $page_no = addslashes($_GET['p']);

$start_row = $page_no * $instance->config['limit-rows'];

$time = time();

###########################
######### QUERIES #########
$query = "SELECT SQL_CACHE c.id as client_id, c.name, p.id as ban_id, p.type, p.time_add, p.time_expire, p.reason, p.duration FROM penalties p LEFT JOIN clients c ON p.client_id = c.id WHERE p.inactive = 0 AND p.type != 'Warning' AND p.type != 'Notice' AND (p.time_expire = -1 OR p.time_expire > $time)";

$query .= sprintf(" ORDER BY %s ", $orderby);

## Append this section to all queries since it is the same for all ##
if($order == "DESC")
	$query .= " DESC"; // set to desc 
else
	$query .= " ASC"; // default to ASC if nothing adds up

$query_limit = sprintf("%s LIMIT %s, %s", $query, $start_row, $instance->config['limit-rows']); // add limit section

## Require Header ##	

if(!$db->error) :
?>
<div class="page-header">
	<h1>Public Ban List</h1>
	<p><span class="badge"><?= $total_rows; ?></span> active bans/tempbans for
</div>
<table class="table table-striped table-hover">
	<form action="pubbans.php" method="get" id="pubbans-form">
		<select class="form-control spacer" name="game" onchange="this.form.submit()">
			<?php

			$games_list = $dbl->getGamesList();
			$i = 0;
			$count = count($games_list);
			$count--; // minus 1
			while($i <= $count) :

				if($game == $games_list[$i]['id'])
					$selected = 'selected="selected"';
				else
					$selected = NULL;

				echo '<option value="'. $games_list[$i]['id'] .'" '. $selected .'>'. $games_list[$i]['name'] .'</option>';

				$i++;
			endwhile;

			?>
		</select>
	</form>
<thead>
	<tr>
		<th>Client
			<?php linkSort('name', 'Name'); ?>
		</th>
		<th>Ban-id</th>
		<th>Type</th>
		<th>Added
			<?php linkSort('time_add', 'time the penalty was added'); ?>
		</th>
		<th>Duration</th>
		<th>Expires
			<?php linkSort('time_expire', 'time the penalty expires'); ?>
		</th>
		<th>Reason</th>
	</tr>
</thead>
<tfoot>
	<tr>
		<th colspan="7"></th>
	</tr>
</tfoot>
<tbody>
<?php
if($num_rows > 0) : // query contains stuff

	foreach($data_set as $pen): // get data from query and loop
		$ban_id = $pen['ban_id'];
		$type = $pen['type'];
		$time_add = $pen['time_add'];
		$time_expire = $pen['time_expire'];
		$reason = tableClean($pen['reason']);
		$client_id = $pen['client_id'];
		$client_name = tableClean($pen['name']);
		$duration = $pen['duration'];

		## Tidt data to make more human friendly
		if($time_expire != '-1')
			$duration_read = time_duration($duration*60); // all penalty durations are stored in minutes, so multiple by 60 in order to get seconds
		else
			$duration_read = '';

		$time_expire_read = timeExpirePen($time_expire);
		$time_add_read = date($instance->config['time-format'], $time_add);
		$reason_read = removeColorCode($reason);
		
		if($mem->loggedIn())
			$client_name_read = clientLink($client_name, $client_id);
		else
			$client_name_read = $client_name;
			
		## Row color
		$alter = alter();

		// setup heredoc (table data)			
		$data = <<<EOD
		<tr class="$alter">
			<td><strong>$client_name_read</strong></td>
			<td>$ban_id</td>
			<td>$type</td>
			<td>$time_add_read</td>
			<td>$duration_read</td>
			<td>$time_expire_read</td>
			<td>$reason_read</td>
		</tr>
EOD;

		echo $data;
	endforeach;
	
	$no_data = false;
else:
	$no_data = true;
	echo '<tr class="odd"><td colspan="7">There no active bans in the B3 Database</td></tr>';
endif;
?>
</tbody>
</table>

<?php 
	endif; // db error

?>