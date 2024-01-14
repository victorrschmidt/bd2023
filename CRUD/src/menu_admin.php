<?php
    include "lib/tabelar_livros.php";
       
    // Retornar à página de login caso a sessão de um administrador não esteja ativa (para evitar acesso direto à página pela URL)
    if ($_SESSION['TIPO'] !== 'A') {
        header("Location: login.php");
    }
?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ADMIN - Menu - Biblioteca Virtual</title>
    <link rel="icon" href="../img/favicon.ico?" type="image/x-icon">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter&family=Noto+Sans+Osmanya&display=swap">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <header class="container-fluid grey">
        <nav class="container navbar navbar-expand-lg py-3">
            <div id="header-content" class="container-fluid">
                <section id="header-left-content" class="overflow-hidden">
                    <span id="avatar-icon" class="material-symbols-outlined">account_circle</span>
                    <div class="d-flex flex-column">
                        <p class="m-0"><?php echo $_SESSION['NOME']; ?></p>
                        <p class="m-0"><?php echo $_SESSION['EMAIL']; ?></p>
                    </div>
                </section>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#header-right-content" aria-controls="header-right-content" aria-expanded="false" aria-label="Abrir menu">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <section id="header-right-content" class="collapse navbar-collapse">
                    <ul id="header-right-content-list" class="navbar-nav">
                        <li class="nav-item">
                            <a href="inserir.php" class="d-flex align-items-center">
                                <span class="material-symbols-outlined header-icon">add</span>
                                <p class="m-0">Adicionar livro</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="menu_admin.php" class="link-active d-flex align-items-center">
                                <span class="material-symbols-outlined header-icon">menu_book</span>
                                <p class="m-0">Livros disponíveis</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="usuarios.php" class="d-flex align-items-center">
                                <span class="material-symbols-outlined header-icon">person</span>
                                <p class="m-0">Lista de usuários</p>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="script/logout.php" class="btn btn-danger">Encerrar sessão</a>
                        </li>
                    </ul>
                </section>
            </div>
        </nav>
    </header>
    <main class="container py-3">
        <h1 class="text-center my-3">Livros disponíveis</h1>
        <?php if (isset($_SESSION['MENSAGEM'])) { ?>
            <p class="text-center text-success mb-4 fs-4"><?php echo $_SESSION['MENSAGEM']; ?></p>
        <?php } ?>
        <form method="GET" action="menu_admin.php" id="form-ordem" class="mb-4">
            <div class="input-group">
                <select class="form-control" name="input-ordem">
                    <option value="a-z" <?php echo isset($_GET['input-ordem']) && $_GET['input-ordem'] == "a-z" ? "selected" : ""; ?>>A-Z (crescente)</option>
                    <option value="z-a" <?php echo isset($_GET['input-ordem']) && $_GET['input-ordem'] == "z-a" ? "selected" : ""; ?>>Z-A (decrescente)</option>
                    <option value="id-c" <?php echo !isset($_GET['input-ordem']) || (isset($_GET['input-ordem']) && $_GET['input-ordem'] == "id-c") ? "selected" : ""; ?>>ID (crescente)</option>
                    <option value="id-d" <?php echo isset($_GET['input-ordem']) && $_GET['input-ordem'] == "id-d" ? "selected" : ""; ?>>ID (decrescente)</option>
                    <option value="qtd-c" <?php echo isset($_GET['input-ordem']) && $_GET['input-ordem'] == "qtd-c" ? "selected" : ""; ?>>Quantidade (crescente)</option>
                    <option value="qtd-d" <?php echo isset($_GET['input-ordem']) && $_GET['input-ordem'] == "qtd-d" ? "selected" : ""; ?>>Quantidade (decrescente)</option>
                </select>
                <button class="btn btn-primary" type="submit">Aplicar</button>
            </div>
        </form>
        <div class="table-responsive">
            <table id="tabela-livros" class="table table-striped border border-2">
                <thead>
                    <th scope="col">#</th>
                    <th scope="col">Título</th>
                    <th scope="col">Quantidade</th>
                    <th scope="col">Autor(a)</th>
                    <th scope="col">Editora</th>
                    <th scope="col">Ano</th>
                    <th scope="col">EDITAR</th>
                    <th scope="col">EXCLUIR</th>
                </thead>
                <tbody>
                    <?php
                        while ($linha = $result->fetch_row()) {
                    ?>
                    <tr valign="middle">
                        <th scope="row"><?php echo $linha[0]; ?></th>
                        <?php
                            for ($i = 1; $i < sizeof($linha); $i++) {
                        ?>
                        <td><?php echo Formatacao::bancoPagina($linha[$i]); ?></td>
                        <?php } ?>
                        <td>
                            <form method="GET" action="atualizar_livro.php">
                                <input name="atualizar-livro" value="<?php echo $linha[0]; ?>" type="hidden">  
                                <button class="btn btn-primary d-flex align-items-center" type="submit">
                                    <span class="material-symbols-outlined">edit</span>
                                </button> 
                            </form>
                        </td>
                        <td>
                            <form method="POST" action="script/remover_livro.php">
                                <input name="remover-livro" value="<?php echo $linha[0]; ?>" type="hidden">  
                                <button class="btn btn-danger d-flex align-items-center" type="submit">
                                    <span class="material-symbols-outlined">close</span>
                                </button> 
                            </form>
                        </td>
                    </tr>
                    <?php } ?>
                </tbody>
            </table>
        </div>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
<?php unset($_SESSION['MENSAGEM']); ?>