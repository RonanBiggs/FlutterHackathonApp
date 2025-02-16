<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, description, location, vegan, vegetarian, glutenFree, fruits, grains, canned, protein, other");

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}

include 'connect.php';

// Retrieve the 'description' header
// Retrieve the headers
$headers = getallheaders();
$description = isset($headers['description']) ? $headers['description'] : '';
$location = isset($headers['location']) ? $headers['location'] : '';
$vegan = isset($headers['vegan']) && $headers['vegan'] === 'true' ? 1 : 0;
$vegetarian = isset($headers['vegetarian']) && $headers['vegetarian'] === 'true' ? 1 : 0;
$glutenFree = isset($headers['glutenFree']) && $headers['glutenFree'] === 'true' ? 1 : 0;
$fruits = isset($headers['fruits']) && $headers['fruits'] === 'true' ? 1 : 0;
$grains = isset($headers['grains']) && $headers['grains'] === 'true' ? 1 : 0;
$canned = isset($headers['canned']) && $headers['canned'] === 'true' ? 1 : 0;
$protein = isset($headers['protein']) && $headers['protein'] === 'true' ? 1 : 0;
$other = isset($headers['other']) && $headers['other'] === 'true' ? 1 : 0;


// For debugging
error_log("Headers received: " . print_r($headers, true));
error_log("Description value: " . $description);

$query = "INSERT INTO `posts` (`img`, `descr`, `location`, `vegan`, `vegetarian`, `gf`, `fruits`, `grains`, `canned`, `protein`, `other`) 
          VALUES ('', '$description', '', $vegan, $vegetarian, $glutenFree, $fruits, $grains, $canned, $protein, $other)";

$results = mysqli_query($conn, $query);
if ($results) {
    echo "user added successfully";
} else {
    echo "Error: " . mysqli_error($conn);
}
?>