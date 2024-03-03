<?php
include '../connection.php';

$userEmail = $_POST['user_email'];

$sqlQuery = "SELECT *FROM users WHERE EMAIL = '$userEmail'";

$resultOfQuery = $connectNow->query($sqlQuery);

if($resultOfQuery->num_rows>0){
    echo json_encode(array("Email_found"=>true));
}else{
    echo json_encode(array("Email_found"=>false));
}