<?php
    // Conectar ao banco de dados
    include "dbcon.php";

    // Query
    $query = "SELECT usuario_id, usuario_nome, usuario_email FROM usuario WHERE usuario_tipo = 'U';";

    $result = $dbcon->query($query);