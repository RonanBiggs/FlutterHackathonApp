<?php

include 'connect.php';

$name = 'test';
$query = "INSERT INTO `test` (`name`) VALUES ('$name')";
$results = mysqli_query($conn, $query);

if ($results) {
    echo "user added successfully";
} else {
    echo "Error: " . mysqli_error($conn);
}

?>