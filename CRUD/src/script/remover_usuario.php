<?php
    // Conectar ao banco de dados
    include "../lib/dbcon.php";

    $id = $_POST['remover-usuario'];

    // Query
    $query = "DELETE FROM usuario WHERE usuario_id = ?;";

    $dbcon->execute_query($query, [$id]);
    
    header("Location: ../usuarios.php");