<?php session_start(); ?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Criar conta - Biblioteca Virtual</title>
    <link rel="icon" href="../img/favicon.ico?" type="image/x-icon">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter&family=Noto+Sans+Osmanya&display=swap">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="../style.css">
</head>
<body class="d-flex flex-column gap-3 py-3">
    <header class="container d-flex flex-column align-items-center gap-2">
        <img src="../img/logo.png" class="d-block mx-auto" width="64" alt="Biblioteca-Virtual-logo">
        <h1 class="text-center fs-3 m-0">Biblioteca Virtual</h1>
        <h2 class="text-center fs-2 m-0">Criar conta</h2>
    </header>
    <main id="main-conta" class="container d-flex flex-column gap-3">
        <form id="form-nova-conta" method="POST" action="script/validar_conta.php" class="d-flex flex-column p-4 border border-2 rounded">
            <div class="mb-3">
                <label for="input-nova-conta-nome" class="form-label">Nome completo</label>
                <input id="input-nova-conta-nome" name="nova-conta-nome" class="form-control" type="text" pattern="^(?=.*[a-zA-Z]).{1,128}$" maxlength="128" required autofocus>
            </div>
            <div class="mb-3">
                <label for="input-nova-conta-email" class="form-label">Email</label>
                <input id="input-nova-conta-email" name="nova-conta-email" class="form-control<?php echo isset($_SESSION['ERRO']) ? " is-invalid" : "" ?>" type="email" maxlength="128" required>
                <?php if (isset($_SESSION['ERRO'])) { ?>
                    <p class="text-danger m-0 mt-2">Usuário já registrado.</p>
                <?php } ?>
            </div>
            <div class="mb-3">
                <label for="input-nova-conta-senha" class="form-label">Senha</label>
                <input id="input-nova-conta-senha" name="nova-conta-senha" class="form-control mb-2" type="password" pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,128}$" maxlength="128" required>
                <input id="input-nova-conta-mostrar-senha" class="form-check-input" type="checkbox">
                <label for="input-nova-conta-mostrar-senha" class="form-check-label">Mostrar senha</label>
            </div>
            <div class="mb-3">
                <h3 class="fs-5">A senha deve conter:</h3>
                <p id="verif-maiuscula" class="m-0 verif-negado">Ao menos uma letra maiúscula</p>
                <p id="verif-minuscula" class="m-0 verif-negado">Ao menos uma letra minúscula</p>
                <p id="verif-digito" class="m-0 verif-negado">Ao menos um dígito numérico</p>
                <p id="verif-especial" class="m-0 verif-negado">Ao menos um caracter especial</p>
                <p id="verif-caracteres" class="m-0 verif-negado">Ao menos 8 caracteres</p>
            </div>
            <!-- CRIAR ADMINISTRADOR -->
            <div class="mb-3">
                <input id="input-nova-conta-admin" name="nova-conta-admin" class="form-check-input" type="checkbox">
                <label for="input-nova-conta-admin" class="form-check-label">Conta de Administrador</label>
            </div>
            <!-- -->
            <button class="btn btn-primary" type="submit">Criar conta</button> 
        </form>
        <div class="d-flex flex-column align-items-center p-4 border border-2 rounded">
            <p class="text-center">Já possui uma conta?</p>
            <a href="login.php" class="btn btn-success w-75">Fazer login</a>
        </div>
    </main>
    <script src="lib/form_check.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
<?php unset($_SESSION['ERRO']); ?>