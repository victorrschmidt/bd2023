/* Primeiro Trabalho do 2º bimestre */

/* Criar tabela clientes */
create table clientes(
    clienteId serial primary key,
    clienteNome varchar(255) not null,
    clienteEndereco varchar(255)
);

/* Criar tabela funcionarios */
create table funcionarios(
    funcionarioId serial primary key,
    funcionarioNome varchar(255) not null,
    funcionarioFuncao varchar(255)
);

/* Criar tabela medicamentos */
create table medicamentos(
    medicamentoId serial primary key,
    medicamentoNome varchar(255) not null,
    medicamentoLab varchar(255) not null,
    medicamentoPreco real not null check(medicamentoPreco > 0),
    medicamentoQtd int not null check(medicamentoQtd > 0)
);

/* Criar tabela compras */
create table compras(
    compraId serial primary key,
    compraCliente int references clientes(clienteId),
    compraFuncionario int references funcionarios(funcionarioId),
    compraMedicamento int references medicamentos(medicamentoId),
    compraData timestamp not null
);


/* Popular o sistema */
insert into clientes(clienteNome, clienteEndereco) values ('Miguel Santos Alves', 'Rua Gonçalo de Carvalho, 340');
insert into clientes(clienteNome, clienteEndereco) values ('Alice Oliveira Pereira', 'Rua das Pedras, 743');
insert into clientes(clienteNome, clienteEndereco) values ('Heitor Souza Lima', 'Rua da Aurora, 711');
insert into clientes(clienteNome, clienteEndereco) values ('Beatriz Rodrigues Gomes', 'Rua XV de Novembro, 399');
insert into clientes(clienteNome, clienteEndereco) values ('Julia Ferreira Ribeiro', 'Rua Nascimento da Silva, 540');

insert into funcionarios(funcionarioNome, funcionarioFuncao) values ('Lucas Andrade Cardoso','A');
insert into funcionarios(funcionarioNome, funcionarioFuncao) values ('Bruna Rocha Fernandes','A');
insert into funcionarios(funcionarioNome, funcionarioFuncao) values ('José Barbosa Garcia','F');
insert into funcionarios(funcionarioNome, funcionarioFuncao) values ('Amanda Teixeira Melo','F');
insert into funcionarios(funcionarioNome, funcionarioFuncao) values ('Camila Duarte da Silva','G');

insert into medicamentos(medicamentoNome, medicamentoLab, medicamentoPreco, medicamentoQtd) values ('Rinosoro', 'Hypera', 22.79, 82);
insert into medicamentos(medicamentoNome, medicamentoLab, medicamentoPreco, medicamentoQtd) values ('Busonid', 'Aché', 36.50, 77);
insert into medicamentos(medicamentoNome, medicamentoLab, medicamentoPreco, medicamentoQtd) values ('Ciflogex', 'Cimed', 11.99, 34);
insert into medicamentos(medicamentoNome, medicamentoLab, medicamentoPreco, medicamentoQtd) values ('Olmetec', 'Pfizer', 128.20, 14);
insert into medicamentos(medicamentoNome, medicamentoLab, medicamentoPreco, medicamentoQtd) values ('Zitromax', 'Pfizer', 29.99, 21);

insert into compras(compraCliente, compraFuncionario, compraMedicamento, compraData) values (3, 2, 1, '2021-04-28 13:45:12');
insert into compras(compraCliente, compraFuncionario, compraMedicamento, compraData) values (1, 1, 3, '2023-05-26 21:20:30');
insert into compras(compraCliente, compraFuncionario, compraMedicamento, compraData) values (4, 3, 4, '2023-02-06 14:28:58');
insert into compras(compraCliente, compraFuncionario, compraMedicamento, compraData) values (3, 2, 1, '2022-08-04 23:01:27');
insert into compras(compraCliente, compraFuncionario, compraMedicamento, compraData) values (2, 4, 2, '2023-01-08 04:23:04');


/* Apresentar todos os funcionários */
select * from funcionarios;

/* Apresentar compras em ordem cronológica (mais recente para a mais antiga) */
select * from compras order by compraData desc;

/* Apresentar clientes por ordem alfabética de nome */
select * from clientes order by clienteNome asc;

/* Apresentar medicamento com MAIOR número de quantidade em estoque */
select * from medicamentos where medicamentoQtd = (select max(medicamentoQtd) from medicamentos);

/* Apresentar medicamento com MENOR número de quantidade em estoque */
select * from medicamentos where medicamentoQtd = (select min(medicamentoQtd) from medicamentos);

/* Apresentar medicamento com preço mais alto */
select * from medicamentos where medicamentoPreco = (select max(medicamentoPreco) from medicamentos);

/* Apresentar a quantidade de remédios que tem no sistema */
select count(medicamentoId) from medicamentos;
