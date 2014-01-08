<?php
require_once("../includes/utilities.php");
$to = "charlie@signaldesign.net"; //$_POST['notify'];
$from = "info@cognitopia.com";
$subject = "A Goal has been Completed";
$body = $_POST['goalmessage'];

utMail($to, $from, $subject, $body);

?>