/* Construa um banco de dados de uma seguradora de automóveis em que cada cliente possui um ou mais carros. 
Cada carro tem associado a ele zero a qualquer número de acidentes registrados. 
Para cada cliente é necessário registrar seu nome, CPF, número da CNH, endereço e telefone. 
Para cada carro, é necessário registrar uma descrição, número da placa, número do chassi e 
quantidade de quilômetros rodados. Para cada acidente registrar uma descrição, data, hora, local, e valor total dos danos. */

/* Criar tabela clientes */
create table clientes(
    clienteCpf char(11) primary key,
    clienteNome text not null,
    clienteCnh char(11) unique,
    clienteEndereco text,
    clienteTelefone char(11)
);

/* Criar tabela carros */
create table carros(
    carroPlaca char(9) primary key,
    carroChassi char(17) unique not null,
    carroKm real,
    carroDesc text
);

/* Criar tabela acidentes */
create table acidentes(
    acidenteId serial primary key,
    acidenteData date not null,
    acidenteHora time not null,
    acidenteLocal text,
    acidenteDesc text,
    acidenteDanos real
);

/* Mostrar clientes em ordem alfabética de nome */
select * from clientes order by clienteNome asc;

/* Mostar o carro com maior quilometragem */
select * from carros where carroKm = (select max(carroKm) from carros);

/* Mostrar os acidentes (do mais recente ao mais antigo) */
select * from acidentes order by acidenteData desc;
