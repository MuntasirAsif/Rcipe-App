<?php
include '../connection.php';

$RECIPE_ID = $_POST['RECIPE_ID'];

$sqlQuery = "SELECT * FROM instructions WHERE RECIPE_ID = '$RECIPE_ID'";

$resultOfQuery = $connectNow->query($sqlQuery);

if ($resultOfQuery->num_rows > 0) {
    $userRecord = array();
    while ($rowFound = $resultOfQuery->fetch_assoc()) {
        $userRecord[] = $rowFound;
    }

    echo json_encode(array(
        "userData" => $userRecord,
    ));
} else {
    echo json_encode(array(
        "success" => false,
        "message" => "No data found in the table.",
    ));
}
?>
