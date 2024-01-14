<?php
    // Conectar ao banco de dados
    include "../lib/dbcon.php";

    // Resumir sessão
    session_start();

    $livro_id = $_POST['devolver-livro'];

    // Query (remover livro da tabela aluguel)
    $query = "DELETE FROM aluguel WHERE livro_id = ? AND usuario_id = ?;";

    $dbcon->execute_query($query, [$livro_id, $_SESSION['ID']]);

    // Query (adicionar o livro que foi devolvido à quantidade atual)
    $query = "UPDATE livro SET livro_quantidade = livro_quantidade + 1 WHERE livro_id = ?;";

    $dbcon->execute_query($query, [$livro_id]);

    header("Location: ../meus_livros.php");