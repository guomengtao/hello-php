<?php
try {
    $pdo = new PDO('mysql:host=127.0.0.1;dbname=testdb', 'root', '');
    $stmt = $pdo->query("SHOW TABLES");
    $tables = $stmt->fetchAll(PDO::FETCH_COLUMN);
    echo "<h2>Hello PHP!</h2>";
    echo "<p>PHP Version: " . phpversion() . "</p>";
    echo "<p>Database tables:</p><pre>";
    print_r($tables);
    echo "</pre>";
} catch (PDOException $e) {
    echo "DB Connection failed: " . $e->getMessage();
}