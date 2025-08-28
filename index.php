<?php
$dbFile = __DIR__ . '/test.db';

try {
    $db = new PDO("sqlite:$dbFile");
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $db->exec("CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
    )");

    $db->exec("INSERT INTO users (name) VALUES ('Tom')");

    $db->exec("INSERT INTO users (name) VALUES ('Jack')");

    
    $rows = $db->query("SELECT * FROM users");

    echo "<h2>SQLite Demo</h2>";
    foreach ($rows as $row) {
        echo "ID: {$row['id']}, Name: {$row['name']}<br>";
    }

} catch (PDOException $e) {
    echo "DB Error: " . $e->getMessage();
}