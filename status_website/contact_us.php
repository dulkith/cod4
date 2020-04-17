<?php 

error_reporting(E_ALL);
ini_set('display_errors', 1);


include_once("header.php");
include_once("navigation.php");
?>

<script src='https://www.google.com/recaptcha/api.js'></script>
<script src="contact_form/validator.js"></script>
<script src="contact_form/contact.js"></script>


<div class="right_col" role="main">
	<div class="row">
		<div class="col-md-12 col-sm-12 col-xs-12">
			<div class="x_panel">

                    <div class="row">

                        <div class="col-lg-8 col-lg-offset-2">

                            <h1>Contact us</h1>

                            <p class="lead">DARK LION GAMING SRI LANKA</p>


                            <form id="contact-form" method="POST" action="contact.php" role="form">

                                <div class="messages"></div>

                                <div class="controls">

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="form_name">Firstname *</label>
                                                <input id="form_name" type="text" name="name" class="form-control" placeholder="Please enter your firstname *" required="required" data-error="Firstname is required.">
                                                <div class="help-block with-errors"></div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="form_lastname">Lastname *</label>
                                                <input id="form_lastname" type="text" name="surname" class="form-control" placeholder="Please enter your lastname *" required="required" data-error="Lastname is required.">
                                                <div class="help-block with-errors"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="form_email">Email *</label>
                                                <input id="form_email" type="email" name="email" class="form-control" placeholder="Please enter your email *" required="required" data-error="Valid email is required.">
                                                <div class="help-block with-errors"></div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label for="form_phone">Phone</label>
                                                <input id="form_phone" type="tel" name="phone" class="form-control" placeholder="Please enter your phone">
                                                <div class="help-block with-errors"></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="form_message">Message *</label>
                                                <textarea id="form_message" name="message" class="form-control" placeholder="Message for me *" rows="4" required="required" data-error="Please,leave us a message."></textarea>
                                                <div class="help-block with-errors"></div>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <!-- Replace data-sitekey with your own one, generated at https://www.google.com/recaptcha/admin -->
                                                <div class="g-recaptcha" data-sitekey="6Lcz50EUAAAAAKUxr0eSY1UWPFeWCh5ht2rlKAFC"></div>
                                            </div>
                                        </div>

                                        <div class="col-md-12">
                                            <input type="submit" class="btn btn-success btn-send" value="Send message">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <p class="text-muted"><strong>*</strong> These fields are required.</p>
                                        </div>
                                    </div>
                                </div>

                            </form>

                        </div><!-- /.8 -->

                    </div> <!-- /.row-->




                </div>
			</div>
		</div>
	</div>
	<!-- Datatables -->
	<!-- <script src="js/datatables/js/jquery.dataTables.js"></script>
  <script src="js/datatables/tools/js/dataTables.tableTools.js"></script> -->

	<!-- Datatables-->


	<script type="text/javascript">

	</script>
	<?php include("footer.php"); ?>
