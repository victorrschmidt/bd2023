<?php
    // Conectar ao banco de dados
    include "../lib/dbcon.php";
    include "../lib/formatacao.php";

    // Resumir a sessão atual
    session_start();

    // Parâmetros
    $titulo = $_POST['atualizar-titulo'];
    
    // Query
    $query = "SELECT * FROM livro WHERE livro_titulo = ?;";

    $result = $dbcon->execute_query($query, [$titulo]);
   
    // Retornar à página de inserção se o livro já estiver cadastrado
    if ($result->num_rows !== 0 && $result->fetch_assoc()['livro_id'] != $_SESSION['atualizar-id']) {
        $_SESSION['ERRO'] = True;
        $_SESSION['TENTATIVA-TITULO'] = $titulo;
        header("Location: ../atualizar_livro.php");
        exit();
    }

    // Atualizar informações
    $id = $_SESSION['atualizar-id'];
    $quantidade = $_POST['atualizar-quantidade'];
    $autor = $_POST['atualizar-autor'];
    $editora = $_POST['atualizar-editora'];
    $ano = $_POST['atualizar-ano'];

    $info = array_map("Formatacao::paginaBanco", [$titulo, $quantidade, $autor, $editora, $ano]);
    
    $query = "UPDATE livro SET livro_titulo = ?, livro_quantidade = ?, livro_autor = ?, livro_editora = ?, livro_ano = ? WHERE livro_id = ?;";

    $result = $dbcon->execute_query($query, [...$info, $id]);

    // Mensagem
    $_SESSION['MENSAGEM'] = "Livro atualizado com sucesso!";
    
    header("Location: ../menu_admin.php");