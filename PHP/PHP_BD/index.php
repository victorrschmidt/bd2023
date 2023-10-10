<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Query postgreSQL + PHP</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <?php
        /* Observações:
        * - Para ver o produto inserido dentro da tabela, é necessário reiniciar a página
        * - Para remover o produto é necessário clicar uma única vez no botão de "Remover", mas para removê-lo da tabela é necessário uma clique a mais
        */

        // conectar ao db 
        $dbcon = pg_connect("host=127.0.0.1 port=5432 dbname=produtos user=postgres password=postgres");

        print_r(error_get_last());

        $produtos = pg_query($dbcon, "SELECT * FROM produtos;");
        $produtos_min = pg_query($dbcon, "SELECT * FROM produtos WHERE preco = (SELECT MIN(preco) FROM produtos) ORDER BY qtd_uni DESC;");
        $produtos_max = pg_query($dbcon, "SELECT * FROM produtos WHERE preco = (SELECT MAX(preco) FROM produtos) ORDER BY qtd_uni ASC;");
        $produtos_nul = pg_query($dbcon, "SELECT * FROM produtos WHERE qtd_est = 0 ORDER BY nome ASC;");
   
        // adicionar ao db
        if(!empty($_POST["nome"])){
            $nome = $_POST["nome"];
            $preco = $_POST["preco"];
            $qtd_uni = $_POST["qtd-uni"];
            $qtd_est = $_POST["qtd-est"];

            $query = "INSERT INTO produtos (nome,preco,qtd_uni,qtd_est) VALUES ('$nome',$preco,$qtd_uni,$qtd_est);";
            pg_query($dbcon, $query);
        }
        
        // remover do db
        if(!empty($_POST["remover-produto"])){
            $id = $_POST["remover-produto"];

            $query = "DELETE FROM produtos WHERE id = $id;";
            pg_query($dbcon, $query);
        }
    ?>
</head>
<body>
    <h1 class="text-center mt-4">Informações do banco de dados</h1>
    <main class="container my-5">
        <form method="post" action="index.php" class="border border-2 rounded p-4 mb-5">
            <fieldset>
                <legend class="fw-bold fs-2">Inserir produtos</legend>
                <div class="row">
                    <div class="col-sm mb-3">
                        <label for="nome" class="form-label">Nome do produto</label>
                        <input type="text" minlength="1" maxlength="50" pattern="[^'\x22]+" name="nome" class="form-control w-75" id="nome" aria-describedby="nome-desc" required>
                        <div id="nome-desc" class="form-text">De 1 a 50 caracteres, sem aspas</div>
                    </div>
                    <div class="col-sm mb-3">
                        <label for="preco" class="form-label">Preço</label>
                        <input type="number" step="0.01" min="0.01" max="1000000" name="preco" class="form-control w-50" id="preco" aria-describedby="preco-desc" required>
                        <div id="preco-desc" class="form-text">Em R$ (Max: 1.000.000)</div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm mb-3">
                        <label for="qtd-uni" class="form-label">Quantidade por unidade</label>
                        <input type="number" step="1" min="1" max="100" name="qtd-uni" class="form-control w-50" id="qtd-uni" aria-describedby="qtd-uni-desc" required>
                        <div id="qtd-uni-desc" class="form-text">Min: 1 Max: 100</div>
                    </div>
                    <div class="col-sm mb-3">
                        <label for="qtd-est" class="form-label">Quantidade em estoque</label>
                        <input type="number" step="1" min="0" max="10000" name="qtd-est" class="form-control w-50" id="qtd-est" aria-describedby="qtd-est-desc" required>
                        <div id="qtd-est-desc" class="form-text">Min: 0 Max: 10.000</div>
                    </div>
                </div>
            </fieldset>
            <button name="inserir-produto" type="submit" class="btn btn-success mt-3">Inserir</button>
        </form>
        <hr>
        <table class="table table-striped">
            <caption>Lista de produtos</caption>
            <thead>
                <tr class="table-dark">
                    <th scope="col">#</th>
                    <th scope="col">Nome</th>
                    <th scope="col">Preço (R$)</th>
                    <th scope="col">Qtd. por unidade</th>
                    <th scope="col">Qtd. em estoque</th>
                    <th scope="col"></th>
                </tr>
            </thead>
            <tbody>               
                <?php
                    // inserir produtos na tabela
                    while($row = pg_fetch_row($produtos)){
                        
                        $row[2] = number_format($row[2],2,",",".");
                        $id = $row[0];

                        echo "<tr id=\"produto-$id\">";

                        foreach($row as $info){
                            echo "<td> $info </td>";
                        }
                                               
                        echo "<td>";

                        echo "<form method=\"post\" action=\"index.php\">";
                        echo "<input type=\"hidden\" id=\"remove-$id\" name=\"remover-produto\" value=\"$id\">";
                        echo "<button type=\"submit\" class=\"btn btn-danger\" onclick=\"remove($id)\">Remover</button>";

                        echo "</form> </td> </tr>";
                    }
                ?>
            </tbody>
        </table>
        <hr>
        <table class="table table-striped">
            <caption>Produto(s) mais caro(s)</caption>
            <thead>
                <tr class="table-dark">
                    <th scope="col">#</th>
                    <th scope="col">Nome</th>
                    <th scope="col">Preço (R$)</th>
                    <th scope="col">Qtd. por unidade</th>
                    <th scope="col">Qtd. em estoque</th>
                    <th scope="col"></th>
                </tr>
            </thead>
            <tbody>
                <?php
                    while($row = pg_fetch_row($produtos_max)){
                        
                        $row[2] = number_format($row[2],2,",",".");

                        echo "<tr>";

                        foreach($row as $info){
                            echo "<td> $info </td>";
                        }
                                               
                        echo "</tr>";
                    }
                ?>            
            </tbody>
        </table>
        <hr>
        <table class="table table-striped">
            <caption>Produto(s) mais barato(s)</caption>
            <thead>
                <tr class="table-dark">
                    <th scope="col">#</th>
                    <th scope="col">Nome</th>
                    <th scope="col">Preço (R$)</th>
                    <th scope="col">Qtd. por unidade</th>
                    <th scope="col">Qtd. em estoque</th>
                    <th scope="col"></th>
                </tr>
            </thead>
            <tbody>
                <?php
                    while($row = pg_fetch_row($produtos_min)){
                        
                        $row[2] = number_format($row[2],2,",",".");

                        echo "<tr>";

                        foreach($row as $info){
                            echo "<td> $info </td>";
                        }
                                               
                        echo "</tr>";
                    }
                ?>            
            </tbody>
        </table>
        <hr>
        <table class="table table-striped">
            <caption>Produto(s) em falta (0 em estoque)</caption>
            <thead>
                <tr class="table-dark">
                    <th scope="col">#</th>
                    <th scope="col">Nome</th>
                    <th scope="col">Preço (R$)</th>
                    <th scope="col">Qtd. por unidade</th>
                    <th scope="col">Qtd. em estoque</th>
                    <th scope="col"></th>
                </tr>
            </thead>
            <tbody>
                <?php
                    while($row = pg_fetch_row($produtos_nul)){
                        
                        $row[2] = number_format($row[2],2,",",".");

                        echo "<tr>";

                        foreach($row as $info){
                            echo "<td> $info </td>";
                        }
                                               
                        echo "</tr>";
                    }
                ?>            
            </tbody>
        </table>
        <hr>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.min.js" integrity="sha384-Rx+T1VzGupg4BHQYs2gCW9It+akI2MM/mndMCy36UVfodzcJcF0GGLxZIzObiEfa" crossorigin="anonymous"></script>
</body>
</html>
