<?php
include '../connection.php';

$recipeID = $_POST['RECIPE_ID'];
$recipeName = $_POST['RECIPE_NAME'];
$dishName = $_POST['DISH_NAME'];
$categoryName = $_POST['CATEGORY_NAME'];

$sqlQuery = "INSERT INTO recipes SET RECIPE_ID='$recipeID',RECIPE_NAME='$recipeName',DISH_NAME='$dishName',CATAGORY_NAME = '$categoryName'";

$resultOfQuery = $connectNow->query($sqlQuery);

if($resultOfQuery){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}