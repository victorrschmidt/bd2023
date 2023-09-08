<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Salário</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css?v=<?php echo time(); ?>">
</head>
<body>
    <table id="imposto">
        <?php
            require_once "salario.php";
            $form = $_GET["salario"];
            $salario = new Salario();
            $salario->setSalario($form);
            $SALARIO = $salario->getSalario();
            $INSS = $salario->calculoInss();
            $IRPF = $salario->calculoIrpf();
            $FAIXAS = $IRPF["faixas"];
            $TOTAL = $IRPF["taxa"];
        ?>
        <caption>Tabela de Imposto para um salário de R$<?php echo format($SALARIO) ?></caption>
        <tr>
            <th>Faixa de Cálculo (R$)</th>
            <th>Alíquota (%)</th>
            <th>Valor do Imposto (R$)</th>
        </tr>
        <tr>
            <td>< 1.903,98</td>
            <td>0,0</td>
            <td><?php echo $FAIXAS[0] ?></td>
        </tr>
        <tr>
            <td>≥ 1.903,98 e < 2.826,65</td>
            <td>7,5</td>
            <td><?php echo $FAIXAS[1] ?></td>
        </tr>
        <tr>
            <td>≥ 2.826,65 e < 3.751,06</td>
            <td>15,0</td>
            <td><?php echo $FAIXAS[2] ?></td>
        </tr>
        <tr>
            <td>≥ 3.751,06 e < 4.664,68</td>
            <td>22,5</td>
            <td><?php echo $FAIXAS[3] ?></td>
        </tr>
        <tr>
            <td>> 4.664,68</td>
            <td>27,5</td>
            <td><?php echo $FAIXAS[4] ?></td>
        </tr>
    </table>
    <table id="total">
        <tr>
            <td class="bold">Total IRPF</td>
            <td>R$<?php echo $TOTAL ?></td>
        </tr>
        <tr>
            <td class="bold">Total INSS</td>
            <td>R$<?php echo $INSS ?></td>
        </tr>
    </table>
</body>
</html>