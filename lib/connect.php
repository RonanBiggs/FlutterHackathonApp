<?php

// connect.php

$server = '127.0.0.1:3306';

$username = 'mysqllocal';

$password = 'mysqlpass';

$database = 'hackathon';

$conn = mysqli_connect($server, $username, $password, $database);


// Check connection

if (!$conn) {

    exit('Error: could not establish database connection');

}

// Select database


echo"test at end of connect php";

?>
