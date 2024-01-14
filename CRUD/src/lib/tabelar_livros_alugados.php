<?php
    // Conectar ao banco de dados
    include "dbcon.php";
    include "formatacao.php";

    // Resumir a sessão atual
    session_start();

    // Parâmetro
    if (isset($_GET['livros-alugados'])) {
        $_SESSION['livros-alugados'] = $_GET['livros-alugados'];
        $_SESSION['usuario-livros'] = $_GET['usuario-livros'];
    }

    $id = $_SESSION['livros-alugados'];
    $nome = $_SESSION['usuario-livros'];

    // Query
    $query = "SELECT l.livro_id, l.livro_titulo, l.livro_autor, a.aluguel_inicio
        FROM livro AS l 
        JOIN aluguel AS a ON l.livro_id = a.livro_id 
        JOIN usuario AS u ON a.usuario_id = u.usuario_id 
        WHERE u.usuario_id = ?
        ORDER BY a.aluguel_inicio DESC;";

    $result = $dbcon->execute_query($query, [$id]);