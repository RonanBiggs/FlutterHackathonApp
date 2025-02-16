<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: description");
header("Access-Control-Allow-Methods: POST, OPTIONS");

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

include 'connect.php';

// Retrieve the 'description' header
$headers = getallheaders();
$description = isset($headers['description']) ? $headers['description'] : '';

// For debugging
error_log("Headers received: " . print_r($headers, true));
error_log("Description value: " . $description);

$query = "INSERT INTO `posts` (`img`, `descr`, `location`, `vegan`, `vegetarian`, `gf`, `fruits`, `grains`, `canned`, `protein`, `other`) 
          VALUES ('', '$description', 'erf', '1', '0', '0', '0', '0', '0', '0', '0')";

$results = mysqli_query($conn, $query);
if ($results) {
    echo "user added successfully";
} else {
    echo "Error: " . mysqli_error($conn);
}
?>