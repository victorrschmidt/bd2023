<?php
    class Bcrypt {
        private static $PREFIXO = '2a';
        private static $CUSTO = 8;
        private static $LARGURA = 22;

        // Hash (codificação) de senha
        public static function hash($string) {
            $salt = self::gerarSalt();
     
            $hash_string = self::gerarHashString(self::$CUSTO, $salt);
     
            return crypt($string, $hash_string);
        }

        // Gerar salt (parâmetro único de codificação - string aleatória)
        private static function gerarSalt() {
            $salt = uniqid(mt_rand(), true);
     
            $salt = base64_encode($salt);
            $salt = str_replace('+', '.', $salt);
     
            return substr($salt, 0, self::$LARGURA);
        }

        // Gerar string com hash
        private static function gerarHashString($custo, $salt) {
            return sprintf('$%s$%02d$%s$', self::$PREFIXO, $custo, $salt);
        }
        
        // Verificar se a senha é equivale a senha criptografada
        public static function check($string, $hash) {
            return (crypt($string, $hash) === $hash);
        }
    }