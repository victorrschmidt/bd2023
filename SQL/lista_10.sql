/* Clientes */
create table clientes(
    clienteCod int primary key check(clienteCod > 0),
    clienteNome varchar(50) not null,
    clienteEndereco varchar(50) not null,
    clienteTipo char(1) check(clienteTipo in('F','J')),
    clienteRg char(15),
    clienteCpf char(11),
    clienteCnpj char(14),
    clienteObs text
);

/* Fones_cliente */
create table fones(
    foneCliente int references clientes(clienteCod),
    foneTelefone char(10),
    primary key(foneCliente, foneTelefone)
);

/* Funcionários */
create table funcionarios(
    funcionarioCod int primary key,
    funcionarioNome varchar(50) not null,
    funcionarioEndereco varchar(50) not null,
    funcionarioCpf char(11) not null unique,
    funcionarioTipo char(1) check(funcionarioTipo in('1','2','3'))
);

/* Ordens serviços */
create table ordensServicos(
    ordensServicosNum int primary key,
    ordensServicosData date not null,
    ordensServicosValorTotal numeric(10,2) not null,
    ordensServicosStatus char(1) check(ordensServicosStatus in ('A', 'F')),
    ordensServicosFuncionario int not null references funcionarios(funcionarioCod),
    ordensServicosCliente int not null references clientes(clienteCod)
);

/* Vendas */
create table vendas(
    vendaCod int primary key,
    vendaValorTotal numeric(10,2) not null,
    vendaData date not null,
    vendaFuncionario int references funcionarios(funcionarioCod),
    vendaCliente int references clientes(clienteCod),
    vendaOrdemServico int references ordensServicos(ordensServicosNum)
);

/* Contas receber */
create table contasReceber(
    contasReceberCod int primary key,
    contasReceberDataLancamento date not null,
    contasReceberDataVencimento date not null,
    contasReceberValor numeric(10,2) not null,
    contasReceberDataPagamento date,
    contasReceberValorPagamento numeric(10,2),
    contasReceberVenda int not null references vendas(vendaCod)
);

/* Itens */
create table itens(
    itemCod int primary key,
    itemValor numeric(10,2) not null,
    itemCusto numeric(10,2) not null,
    itemDescricao varchar(100),
    itemDesconto numeric(4,2),
    itemTipo char(1) check(itemTipo in('P','S')),
    itemEstoque int
);

/* Venda itens */
create table vendaItens(
    vendaItensSequencial int,
    vendaItensVenda int references vendas(vendaCod),
    vendaItensItem int not null references itens(itemCod),
    vendaItensQuant real not null,
    vendaItensValor numeric(10,2) not null,
    primary key(vendaItensSequencial, vendaItensVenda)
);

/* Ordens itens */
create table ordensItens(
    ordensItensSequencial int primary key, 
    ordensItensOrdemServico int not null references ordensServicos(ordensServicosNum),
    ordensItensItem int not null references itens(itemCod),
    ordensItensDesconto numeric(4,2) not null
);