<?php
    // Conectar ao banco de dados
    include "dbcon.php";
    include "formatacao.php";

    // Resumir a sessão atual
    session_start();

    // Ordem da tabela
    $ORDENS = array(
        "a-z" => "l.livro_titulo ASC",
        "z-a" => "l.livro_titulo DESC",
        "id-c" => "l.livro_id ASC",
        "id-d" => "l.livro_id DESC",
        "qtd-c" => "l.livro_quantidade ASC",
        "qtd-d" => "l.livro_quantidade DESC"
    );

    $ordem = "";

    if (isset($_GET['input-ordem'])) {
        $ordem = " ORDER BY " . $ORDENS[$_GET['input-ordem']];
    }

    // Para o usuário, mostrar livros que: não estão atualmente alugados por ele E que tenham mais de 0 exemplares disponíveis
    if ($_SESSION['TIPO'] === 'U') {
        $query = "SELECT l.livro_id, l.livro_titulo, l.livro_quantidade, l.livro_autor, l.livro_editora, l.livro_ano
            FROM livro AS l 
            LEFT OUTER JOIN aluguel AS a ON l.livro_id = a.livro_id
            WHERE (a.usuario_id IS NULL OR a.usuario_id != ?) AND l.livro_quantidade > 0";

        $query .= $ordem;   
        $query .= ";";

        $result = $dbcon->execute_query($query, [$_SESSION['ID']]);
    }
    // Para o administrador, mostrar todos os livros
    else {
        $query = "SELECT l.livro_id, l.livro_titulo, l.livro_quantidade, l.livro_autor, l.livro_editora, l.livro_ano FROM livro AS l";

        $query .= $ordem;
        $query .= ";";

        $result = $dbcon->query($query);
    }