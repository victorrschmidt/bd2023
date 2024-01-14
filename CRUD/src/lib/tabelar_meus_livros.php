<?php
    // Conectar ao banco de dados
    include "dbcon.php";
    include "formatacao.php";

    // Resumir sessão
    session_start();

    // Query
    $query = "SELECT l.livro_id, l.livro_titulo, l.livro_autor, a.aluguel_inicio
        FROM livro AS l 
        JOIN aluguel AS a ON l.livro_id = a.livro_id 
        JOIN usuario AS u ON a.usuario_id = u.usuario_id 
        WHERE u.usuario_id = ?
        ORDER BY a.aluguel_inicio DESC;";

    $result = $dbcon->execute_query($query, [$_SESSION['ID']]);