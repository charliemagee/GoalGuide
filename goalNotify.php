<?php
require_once("../includes/utilities.php");
$to = $_POST['notify'];
$from = "info@cognitopia.com";
$subject = $_POST['goalmessage'];
$body = $_POST['goalmessage'];

utMail($to, $from, $subject, $body);

?>