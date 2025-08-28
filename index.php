<?php
$pdo = new PDO('mysql:host=127.0.0.1;dbname=testdb', 'root', 'root');
$stmt = $pdo->query("SELECT * FROM users");
$users = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo "Hello PHP!<br>";
echo "Version: " . phpversion() . "<br>";
echo "Users from database:<br>";
foreach ($users as $user) {
    echo "- " . $user['name'] . "<br>";
}