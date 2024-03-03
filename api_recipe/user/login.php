<?php
include '../connection.php';

//POST = send/save data to mysql db
//GET = retrive/red datda from mysql db
$userEmail = $_POST['user_email'];
$userPassword = md5($_POST['user_Password']);

$sqlQuery = "SELECT *FROM users WHERE EMAIL = '$userEmail' AND PASSWORD ='$userPassword'";

$resultOfQuery = $connectNow->query($sqlQuery);

if($resultOfQuery->num_rows>0){

    $userRecord = array();
    while($rowFound = $resultOfQuery->fetch_assoc()){
        $userRecord[] = $rowFound;
    }

    echo json_encode(array(
        "success"=>true,
        "userData"=>$userRecord[0],
    ));
}else{
    echo json_encode(array(
        "success"=>false,
    ));
}