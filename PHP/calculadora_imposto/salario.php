<?php
    function format($number){
        return number_format($number,2,",","."); 
    }

    class Salario{
        private $salario;
        public function setSalario($salario){
            $this->salario = $salario;
        }
        public function getSalario(){
            return $this->salario;
        }
        public function calculoInss(){
            return format($this->salario*0.11,2);
        }
        public function calculoIrpf(){
            $s = $this->salario;
            $faixas = array_fill(0,5,0);

            if($s >= 1903.98 && $s < 2826.65){
                $faixas[1] = ($s-1903.97)*0.075;
            }
            else if($s >= 2826.65 && $s < 3751.06){
                $faixas[1] = 69.20;
                $faixas[2] = ($s-2826.64)*0.15;
            }
            else if($s >= 3751.06 && $s < 4664.68){
                $faixas[1] = 69.20;
                $faixas[2] = 138.66;
                $faixas[3] = ($s-3751.05)*0.225;
            }
            else if($s >= 4664.68){
                $faixas[1] = 69.20;
                $faixas[2] = 138.66;
                $faixas[3] = 205.56;
                $faixas[4] = ($s-4664.67)*0.275;
            }

            $info = array(
                "faixas" => array_map("format",$faixas),
                "taxa" => format(array_sum($faixas))
            );
            return $info;
        }
    }
?>