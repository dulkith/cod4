<?php
$host = 'localhost'; // Nama hostnya
$username = 'root'; // Username
$password = '1234'; // Password (Isi jika menggunakan password)
$database = 'b3_snd_promod'; // Nama databasenya

// Koneksi ke MySQL dengan PDO
$pdo = new PDO('mysql:host='.$host.';dbname='.$database, $username, $password);
?>

