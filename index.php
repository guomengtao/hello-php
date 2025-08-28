<?php
echo "Hello PHP!<br>Version: " . phpversion() . "<hr>";

// MySQL 配置
$host = '127.0.0.1';
$db   = 'test';
$user = 'root';
$pass = 'root';
$charset = 'utf8mb4';

// 连接 MySQL
$dsn = "mysql:host=$host;dbname=$db;charset=$charset";
$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
    echo "Connected to MySQL successfully.<br><br>";

    // 查询 users 表
    $stmt = $pdo->query("SELECT * FROM users");
    $users = $stmt->fetchAll();

    if ($users) {
        echo "<h3>Users Table:</h3><ul>";
        foreach ($users as $u) {
            echo "<li>ID: {$u['id']}, Username: {$u['username']}, Email: {$u['email']}</li>";
        }
        echo "</ul>";
    } else {
        echo "No users found in the table.";
    }

} catch (PDOException $e) {
    echo "MySQL connection failed: " . $e->getMessage();
}