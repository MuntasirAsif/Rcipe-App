<?php
include '../connection.php';

$sqlQuery = "SELECT * FROM category";

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
