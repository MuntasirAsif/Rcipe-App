<?php
include '../connection.php';

$INSTRUCTION_ID = $_POST['INSTRUCTION_ID'];
$RECIPE_ID = $_POST['RECIPE_ID'];
$DESCRIPTION = $_POST['DESCRIPTION'];

$sqlQuery = "INSERT INTO instructions SET INSTRUCTION_ID='$INSTRUCTION_ID',RECIPE_ID='$RECIPE_ID',DESCRIPTION = '$DESCRIPTION'";

$resultOfQuery = $connectNow->query($sqlQuery);

if($resultOfQuery){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}