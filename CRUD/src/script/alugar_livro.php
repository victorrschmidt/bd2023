<?php
    // Conectar ao banco de dados
    include "../lib/dbcon.php";

    // Resumir sessão
    session_start();

    $livro_id = $_POST['alugar-livro'];

    // Query (remover uma unidade do estoque atual do livro selecionado)
    $query = "UPDATE livro SET livro_quantidade = livro_quantidade - 1 WHERE livro_id = ?;";

    $dbcon->execute_query($query, [$livro_id]);

    // Query (adicionar o livro a tabela aluguel)
    $query = "INSERT INTO aluguel (aluguel_inicio, livro_id, usuario_id) VALUES (?, ?, ?);";

    // Data do aluguel
    date_default_timezone_set('America/Sao_Paulo');
    $data = date('Y/m/d H:i:s', time());

    $dbcon->execute_query($query, [$data, $livro_id, $_SESSION['ID']]);

    // Mensagem
    $_SESSION['MENSAGEM'] = True;

    header("Location: ../meus_livros.php");