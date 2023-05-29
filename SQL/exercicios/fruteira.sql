/* Em uma fruteira temos vários produtos (frutas, ovos, carne, refrigerante, etc). 
Em nossa fruteira temos apenas 1 funcionário, então ele será negligenciado. Temos uma compra e temos um cliente. 
Um cliente pode comprar vários produtos. Um produto pode ser vendido para vários clientes, desde que tenha no estoque. */

/* Criar tabela clientes */
create table clientes(
    clienteId serial primary key,
    clienteNome varchar(255) not null,
    clienteEndereco varchar(255)
);

/* Criar tabela produtos */
create table produtos(
    produtoId serial primary key,
    produtoNome varchar(255) not null,
    produtoPreco real check(produtoPreco > 0),
    produtoQuantidade int check(produtoQuantidade > 0)
);

/* Popular o sistema */
insert into clientes(clienteNome, clienteEndereco) values ('Pedro da Silva Magalhães', 'Rua 221');
insert into clientes(clienteNome, clienteEndereco) values ('Julia Alves da Costa', 'Rua 452');
insert into clientes(clienteNome, clienteEndereco) values ('Augusto Soares Barbosa', 'Rua 523');
insert into clientes(clienteNome, clienteEndereco) values ('Beatriz de Castro Lopes', 'Rua 312');
insert into clientes(clienteNome, clienteEndereco) values ('Diggo da silva Raluca', 'Rua 613');

insert into produtos(produtoNome, produtoPreco, produtoQuantidade) values ('Banana caturra', 1.82, 28);
insert into produtos(produtoNome, produtoPreco, produtoQuantidade) values ('Bala sete belo', 0.1, 74);
insert into produtos(produtoNome, produtoPreco, produtoQuantidade) values ('Tomate italiano', 2.50, 32);
insert into produtos(produtoNome, produtoPreco, produtoQuantidade) values ('Salpicão abençoado', 8.99, 23);
insert into produtos(produtoNome, produtoPreco, produtoQuantidade) values ('Chocolate vencido', 1.50, 14);

/* Mostrar todos os produtos com quantidade maior que 5 */
select * from produtos where produtoQuantidade > 5;

/* Mostrar o(s) produto(s) mais caro(s) */
select * from produtos where produtoPreco = (select max(produtoPreco) from produtos);

/* Mostrar os produtos com preço acima da média de preços */
select * from produtos where produtoPreco > (select avg(produtoPreco) from produtos);

/* Mostrar clientes em ordem alfabética de nome */
select * from clientes order by clienteNome asc;
