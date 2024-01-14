<?php
    // Conectar ao banco de dados
    include "../lib/dbcon.php";
    include "../lib/formatacao.php";

    // Resumir sessão
    session_start();

    // Parâmetros
    $titulo = $_POST['inserir-titulo'];
    
    // Query
    $query = "SELECT * FROM livro WHERE livro_titulo = ?;";

    $result = $dbcon->execute_query($query, [$titulo]);
    
    // Retornar à página de inserção se o livro já estiver cadastrado
    if ($result->num_rows !== 0) {
        $_SESSION['ERRO'] = True;
        header("Location: ../inserir.php");
        exit();
    }

    // Inserir no banco de dados
    $quantidade = $_POST['inserir-quantidade'];
    $autor = $_POST['inserir-autor'];
    $editora = $_POST['inserir-editora'];
    $ano = $_POST['inserir-ano'];
    
    $info = array_map("Formatacao::paginaBanco", [$titulo, $quantidade, $autor, $editora, $ano]);

    $query = "INSERT INTO livro (livro_titulo, livro_quantidade, livro_autor, livro_editora, livro_ano) VALUES (?, ?, ?, ?, ?);";
    
    $result = $dbcon->execute_query($query, $info);

    // Mensagem
    $_SESSION['MENSAGEM'] = "Livro adicionado com sucesso!";
    
    header("Location: ../menu_admin.php");