<?php
    // Conectar ao banco de dados
    include "dbcon.php";

    // Resumir a sessão atual
    session_start();

    // Parâmetro
    if (isset($_GET['atualizar-livro'])) {
        $_SESSION['atualizar-id'] = $_GET['atualizar-livro'];
    }

    $id = $_SESSION['atualizar-id'];
    
    // Query
    $query = "SELECT * FROM livro WHERE livro_id = ?;";

    $linha = $dbcon->execute_query($query, [$id]);
    $linha = $linha->fetch_assoc();