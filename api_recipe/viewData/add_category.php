<?php
include '../connection.php';

//POST = send/save data to mysql db
//GET = retrive/red datda from mysql db
$categoryName = $_POST['CATEGORY_NAME'];

$sqlQuery = "INSERT INTO category SET CATEGORY_NAME = '$categoryName'";

$resultOfQuery = $connectNow->query($sqlQuery);

if($resultOfQuery){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}