<?php
    // Conectar ao banco de dados
    include "../lib/dbcon.php";

    $id = $_POST['remover-livro'];

    // Query
    $query = "DELETE FROM livro WHERE livro_id = ?;";

    $dbcon->execute_query($query, [$id]);
    
    header("Location: ../menu_admin.php");