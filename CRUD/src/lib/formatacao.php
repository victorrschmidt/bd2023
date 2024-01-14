<?php
    class Formatacao {
        // Transforma NULL em "--"
        public static function bancoPagina($string) {
            return ($string === NULL ? "--" : $string);
        }

        // Transforma "" em NULL
        public static function paginaBanco($string) {
            $string = trim($string);

            return ($string === "" ? NULL : $string);
        }

        // Formatação de data
        public static function data($string) {
            [$data, $hora] = explode(" ", $string);

            $data = date_format(date_create($data), 'd/m/Y');

            return ("$data às $hora");
        }
    }