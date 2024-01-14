<?php
    // Conectar ao banco de dados
    include "../lib/dbcon.php";
    include "../lib/criptografia.php";

    // Resumir sessão
    session_start();

    // Parâmetro
    $email = $_POST['nova-conta-email'];

    // Query
    $query = "SELECT * FROM usuario WHERE usuario_email = ?;";

    $result = $dbcon->execute_query($query, [$email]);
    
    // Retornar à página de criação de conta se já existe um usuário com o email especificado 
    if ($result->num_rows !== 0) {
        $_SESSION['ERRO'] = True;
        header("Location: ../criar_conta.php");
        exit();
    }

    // Inserir no banco de dados
    $nome = $_POST['nova-conta-nome'];
    $senha = $_POST['nova-conta-senha'];
    // Conta de admin
    isset($_POST['nova-conta-admin']) ? $tipo = 'A' : $tipo = 'U';

    // Criptografar senha
    $senha = Bcrypt::hash($senha);

    $query = "INSERT INTO usuario (usuario_nome, usuario_email, usuario_senha, usuario_tipo) VALUES (?, ?, ?, ?);";

    $dbcon->execute_query($query, [$nome, $email, $senha, $tipo]);

    // Id do usuário
    $query = "SELECT usuario_id FROM usuario WHERE usuario_email = ?;";
    $id = $dbcon->execute_query($query, [$email])->fetch_assoc()['usuario_id'];

    // Redirecionar à página inicial
    $_SESSION['EMAIL'] = $email;
    $_SESSION['ID'] = $id;
    $_SESSION['NOME'] = $nome;
    $_SESSION['TIPO'] = $tipo;
    $_SESSION['MENU'] = "menu.php";
        
    header("Location: ../" . $_SESSION['MENU']);