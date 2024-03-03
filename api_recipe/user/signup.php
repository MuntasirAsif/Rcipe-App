<?php
include '../connection.php';

//POST = send/save data to mysql db
//GET = retrive/red datda from mysql db
$userID=$_POST['user_id'];
$userName = $_POST['user_name'];
$userEmail = $_POST['user_email'];
$userPassword = md5($_POST['user_Password']);

$sqlQuery = "INSERT INTO users SET USER_ID = '$userID',USER_NAME = '$userName',EMAIL = '$userEmail',PASSWORD = '$userPassword'";

$resultOfQuery = $connectNow->query($sqlQuery);

if($resultOfQuery){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}