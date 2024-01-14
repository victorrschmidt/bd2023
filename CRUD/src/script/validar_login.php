<?php
    // Conectar ao banco de dados
    include "../lib/dbcon.php";
    include "../lib/criptografia.php";

    // Resumir sessão
    session_start();
    
    // Parâmetros
    $email = $_POST['login-email'];
    $senha = $_POST['login-senha'];

    // Query
    $query = "SELECT usuario_id, usuario_nome, usuario_senha, usuario_tipo FROM usuario WHERE usuario_email = ?;";

    $result = $dbcon->execute_query($query, [$email]);

    // Retornar ao login se não existe nenhum usuário com o email especificado
    if ($result->nuw_rows === 0) {
        $_SESSION['ERRO'] = True;
        header("Location: ../login.php");
        exit();
    }

    $linha = $result->fetch_assoc();

    $hash = $linha['usuario_senha'];

    // Retornar ao login se a senha estiver incorreta
    if (!(Bcrypt::check($senha, $hash))) {
        $_SESSION['ERRO'] = True;
        header("Location: ../login.php");
        exit();
    }

    // Redirecionar à página inicial
    $_SESSION['EMAIL'] = $email;
    $_SESSION['ID'] = $linha['usuario_id'];
    $_SESSION['NOME'] = $linha['usuario_nome'];
    $_SESSION['TIPO'] = $linha['usuario_tipo'];
    
    if ($_SESSION['TIPO'] === 'A') {
        $_SESSION['MENU'] = "menu_admin.php";
    }
    else {
        $_SESSION['MENU'] = "menu.php";
    }
        
    header("Location: ../" . $_SESSION['MENU']);