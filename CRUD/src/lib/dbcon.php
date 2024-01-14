<?php
    // Conexão com o banco de dados
    $dbcon = new mysqli("localhost", "root", "", "biblioteca");

    // Erro de conexão com o banco de dados
    if ($dbcon->connect_error) {
        print("Erro de conexão com o banco de dados: " . $dbcon->connect_error);
        $dbcon->close();
        exit();
    }