<?php
function pdo_get_connection()
{
    try {
        $dburl = "mysql:host=localhost;dbname=assignment2;charset=utf8";
        $username = 'root';
        $password = '';
        $conn = new PDO($dburl, $username, $password);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $conn;
    } catch (PDOException $e) {
        echo "Connection failed: " . $e->getMessage();
    }
}
$conn = pdo_get_connection();
