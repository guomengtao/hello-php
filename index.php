<?php
// 自动创建 SQLite 数据库文件 test.db
$db = new PDO('sqlite:./test.db');

// 创建表
$db->exec("CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT
)");

// 插入一条数据
$db->exec("INSERT INTO users (name) VALUES ('Tom')");

// 查询并显示
$rows = $db->query("SELECT * FROM users");
foreach ($rows as $row) {
    echo "ID: {$row['id']}, Name: {$row['name']}<br>";
}