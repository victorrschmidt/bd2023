/* Segundo Trabalho do 2º bimestre */

/* Tabelas */
CREATE TABLE departamentos(
    departamentoID SERIAL PRIMARY KEY,
    departamentoSetor VARCHAR(255) NOT NULL
);

CREATE TABLE funcionarios(
    funcionarioID SERIAL PRIMARY KEY,
    funcionarioNome VARCHAR(255) NOT NULL,
    funcionarioSalario REAL NOT NULL CHECK(funcionarioSalario > 0),
    funcionarioTelefone VARCHAR(18),
    departamentoID INT REFERENCES departamentos(departamentoID)
);

CREATE TABLE projetos(
    projetoID SERIAL PRIMARY KEY,
    projetoDescricao VARCHAR(255) NOT NULL,
    projetoOrcamento REAL CHECK(projetoOrcamento > 0)
);

CREATE TABLE participacoes(
    participacaoID SERIAL PRIMARY KEY,
    funcionarioID INT REFERENCES funcionarios(funcionarioID),
    projetoID INT REFERENCES projetos(projetoID)
);

CREATE TABLE fornecedores(
    fornecedorID SERIAL PRIMARY KEY,
    fornecedorNome VARCHAR(255) NOT NULL,
    fornecedorEndereco VARCHAR(255) 
);

CREATE TABLE contratos(
    contratoID SERIAL PRIMARY KEY,
    projetoID INT REFERENCES projetos(projetoID),
    fornecedorID INT REFERENCES fornecedores(fornecedorID)
);

CREATE TABLE depositos(
    depositoID SERIAL PRIMARY KEY,
    depositoEndereco VARCHAR(255) NOT NULL,
    depositoDescricao VARCHAR(255) 
);

CREATE TABLE pecas(
    pecaID SERIAL PRIMARY KEY,
    pecaNome VARCHAR(255) NOT NULL,
    pecaCor VARCHAR(255),
    pecaPeso REAL NOT NULL CHECK(pecaPeso > 0),
    depositoID INT REFERENCES depositos(depositoID)
);

CREATE TABLE fornecimentos(
    fornecimentoID SERIAL PRIMARY KEY,
    fornecedorID INT REFERENCES fornecedores(fornecedorID),
    pecaID INT REFERENCES pecas(pecaID)
);

/* Popular o sistema */
INSERT INTO departamentos(departamentoSetor) VALUES ('Recursos Humanos');
INSERT INTO departamentos(departamentoSetor) VALUES ('Finanças');
INSERT INTO departamentos(departamentoSetor) VALUES ('Logística');
INSERT INTO departamentos(departamentoSetor) VALUES ('Marketing');

INSERT INTO funcionarios(funcionarioNome,funcionarioSalario,funcionarioTelefone,departamentoID) VALUES ('Igor Alekseyevich Dyatlov',2127.40,'(74) 8423-1208',1);
INSERT INTO funcionarios(funcionarioNome,funcionarioSalario,funcionarioTelefone,departamentoID) VALUES ('Lyudmila Alexandrovna Dubinina',2348.00,'(23) 6731-1984',1);
INSERT INTO funcionarios(funcionarioNome,funcionarioSalario,funcionarioTelefone,departamentoID) VALUES ('Yuri Nikolayevich Doroshenko',2452.80,'(56) 7966-3525',2);
INSERT INTO funcionarios(funcionarioNome,funcionarioSalario,funcionarioTelefone,departamentoID) VALUES ('Yuri Alexeyevich Krivonischenko',2452.90,'(56) 7484-4637',2);
INSERT INTO funcionarios(funcionarioNome,funcionarioSalario,funcionarioTelefone,departamentoID) VALUES ('Alexander Sergeyevich Kolevatov',2500.00,'(13) 7177-9744',2);
INSERT INTO funcionarios(funcionarioNome,funcionarioSalario,funcionarioTelefone,departamentoID) VALUES ('Zinaida Alekseevna Kolmogorova',2241.55,'(25) 8577-7814',3);
INSERT INTO funcionarios(funcionarioNome,funcionarioSalario,funcionarioTelefone,departamentoID) VALUES ('Rustem Vladimirovich Slobodin',2250.49,'(26) 4943-5218',3);
INSERT INTO funcionarios(funcionarioNome,funcionarioSalario,funcionarioTelefone,departamentoID) VALUES ('Nikolai Vladimirovich Thibeaux-Brignolles',2130.00,'(99) 9889-4959',3);
INSERT INTO funcionarios(funcionarioNome,funcionarioSalario,funcionarioTelefone,departamentoID) VALUES ('Semyon Alekseevich Zolotaryov',3290.20,'(01) 7181-7138',4);
INSERT INTO funcionarios(funcionarioNome,funcionarioSalario,funcionarioTelefone,departamentoID) VALUES ('Yuri Yefimovich Yudin',3182.35,'(62) 9254-4711',4);

INSERT INTO projetos(projetoDescricao,projetoOrcamento) VALUES ('Conserto da ponte principal do Rio Kama',12800.00);
INSERT INTO projetos(projetoDescricao,projetoOrcamento) VALUES ('Construção do porto de Solikamsk',127800.00);
INSERT INTO projetos(projetoDescricao,projetoOrcamento) VALUES ('Construção da Estação de Polícia de Solikamsk',97500.00);
INSERT INTO projetos(projetoDescricao,projetoOrcamento) VALUES ('Revitalização do observatório de Ushma',25000.00);

INSERT INTO participacoes(funcionarioID,projetoID) VALUES (1,2);
INSERT INTO participacoes(funcionarioID,projetoID) VALUES (1,3);
INSERT INTO participacoes(funcionarioID,projetoID) VALUES (3,1);
INSERT INTO participacoes(funcionarioID,projetoID) VALUES (3,2);
INSERT INTO participacoes(funcionarioID,projetoID) VALUES (5,4);
INSERT INTO participacoes(funcionarioID,projetoID) VALUES (6,4);
INSERT INTO participacoes(funcionarioID,projetoID) VALUES (7,2);
INSERT INTO participacoes(funcionarioID,projetoID) VALUES (8,3);
INSERT INTO participacoes(funcionarioID,projetoID) VALUES (8,4);
INSERT INTO participacoes(funcionarioID,projetoID) VALUES (10,2);

INSERT INTO fornecedores(fornecedorNome,fornecedorEndereco) VALUES ('Pavlovski Possad','Pavlovo-Posadsky, Oblast de Moscou, Rússia');
INSERT INTO fornecedores(fornecedorNome,fornecedorEndereco) VALUES ('Tula','Tula, Oblast de Tula, Rússia');
INSERT INTO fornecedores(fornecedorNome,fornecedorEndereco) VALUES ('Kalashnikov','Ijevsk, Oblast de Udmurtia, Rússia');
INSERT INTO fornecedores(fornecedorNome,fornecedorEndereco) VALUES ('United Heavy Machinery','Moscou, Rússia');
INSERT INTO fornecedores(fornecedorNome,fornecedorEndereco) VALUES ('Novolipetsk Steel','Lipetsk, Oblast de Lipetsk, Rússia');

INSERT INTO contratos(projetoID,fornecedorID) VALUES (1,5);
INSERT INTO contratos(projetoID,fornecedorID) VALUES (2,4);
INSERT INTO contratos(projetoID,fornecedorID) VALUES (2,5);
INSERT INTO contratos(projetoID,fornecedorID) VALUES (3,2);
INSERT INTO contratos(projetoID,fornecedorID) VALUES (3,3);
INSERT INTO contratos(projetoID,fornecedorID) VALUES (4,1);

INSERT INTO depositos(depositoEndereco,depositoDescricao) VALUES ('Edifício Ulitsa Gogolya, 7A, Moscou, Rússia','Armazém médio de 225mXm');
INSERT INTO depositos(depositoEndereco,depositoDescricao) VALUES ('Edifício Very Voloshinoy Ulitsa, 20, Moscou Rússia','Armazém médio de 200mXm');
INSERT INTO depositos(depositoEndereco,depositoDescricao) VALUES ('Kustarnaya Ulitsa, 4-18, Serguiev Possad, Rússia','Armazém pequeno de 132mXm');
INSERT INTO depositos(depositoEndereco,depositoDescricao) VALUES ('Edifício Fevralskaya Ulitsa, 48-H, Znamya Oktyabrya, Rússia','Armazém grande de 800mXm');
INSERT INTO depositos(depositoEndereco,depositoDescricao) VALUES ('Tomilino, Liubertsi, Rússia','Armazém grande de 740mXm');

INSERT INTO pecas(pecaNome,pecaCor,pecaPeso,depositoID) VALUES ('Compactor GBZ-40','Preta',5,1);
INSERT INTO pecas(pecaNome,pecaCor,pecaPeso,depositoID) VALUES ('Drum Roller 2017','Azul e cinza',12,1);
INSERT INTO pecas(pecaNome,pecaCor,pecaPeso,depositoID) VALUES ('Skidder 800-V3','Amarela e laranja',8,2);
INSERT INTO pecas(pecaNome,pecaCor,pecaPeso,depositoID) VALUES ('Boom Lift 32x40','Preta',510,2);
INSERT INTO pecas(pecaNome,pecaCor,pecaPeso,depositoID) VALUES ('Scissor Lift V32','Preta e cinza',1200,2);
INSERT INTO pecas(pecaNome,pecaCor,pecaPeso,depositoID) VALUES ('Forklift X11000','Laranja e azul',630,3);
INSERT INTO pecas(pecaNome,pecaCor,pecaPeso,depositoID) VALUES ('Motor Grader U-22','Azul e roxa',42,3);
INSERT INTO pecas(pecaNome,pecaCor,pecaPeso,depositoID) VALUES ('Concrete Mixer 2240','Branca e preta',28,4);
INSERT INTO pecas(pecaNome,pecaCor,pecaPeso,depositoID) VALUES ('Telehandler HM-35','Cinza e azul',1900,4);
INSERT INTO pecas(pecaNome,pecaCor,pecaPeso,depositoID) VALUES ('Forward plate compactor Z1200','Laranja e verde',3200,5);
INSERT INTO pecas(pecaNome,pecaCor,pecaPeso,depositoID) VALUES ('Articulated Hauler KX2','Preta',7500,5);
INSERT INTO pecas(pecaNome,pecaCor,pecaPeso,depositoID) VALUES ('Off-Highway Truck G3000','Preta e cinza',2000,5);

INSERT INTO fornecimentos(fornecedorID,pecaID) VALUES (1,1);
INSERT INTO fornecimentos(fornecedorID,pecaID) VALUES (1,2);
INSERT INTO fornecimentos(fornecedorID,pecaID) VALUES (1,4);
INSERT INTO fornecimentos(fornecedorID,pecaID) VALUES (2,3);
INSERT INTO fornecimentos(fornecedorID,pecaID) VALUES (2,4);
INSERT INTO fornecimentos(fornecedorID,pecaID) VALUES (2,7);
INSERT INTO fornecimentos(fornecedorID,pecaID) VALUES (3,5);
INSERT INTO fornecimentos(fornecedorID,pecaID) VALUES (3,8);
INSERT INTO fornecimentos(fornecedorID,pecaID) VALUES (4,10);
INSERT INTO fornecimentos(fornecedorID,pecaID) VALUES (4,11);
INSERT INTO fornecimentos(fornecedorID,pecaID) VALUES (4,12);
INSERT INTO fornecimentos(fornecedorID,pecaID) VALUES (5,6);
INSERT INTO fornecimentos(fornecedorID,pecaID) VALUES (5,9);

/* Pesquisas */
/* Apresente os telefones de um dado funcionário, pelo nome do funcionário. */
SELECT f.funcionarioTelefone FROM funcionarios AS f
WHERE f.funcionarioNome = 'Alexander Sergeyevich Kolevatov';

/* Apresente os nomes dos funcionários que estão vinculados a um projeto, pelo nome do projeto. */
SELECT f.funcionarioNome FROM projetos AS pr
JOIN participacoes AS pa ON pr.projetoID = pa.projetoID
JOIN funcionarios AS f ON pa.funcionarioID = f.funcionarioID
WHERE pr.projetoDescricao = 'Construção do porto de Solikamsk';

/* Quantos funcionários estão vinculados a este projeto? */
SELECT COUNT(pr.projetoDescricao) FROM projetos AS pr
JOIN participacoes AS pa ON pr.projetoID = pa.projetoID
JOIN funcionarios AS f ON pa.funcionarioID = f.funcionarioID
WHERE pr.projetoDescricao = 'Construção do porto de Solikamsk';

/* Quais são as peças utilizadas no projeto XXX do funcionário YYY? */
SELECT pe.pecaNome FROM pecas AS pe
JOIN fornecimentos AS fm ON pe.pecaID = fm.pecaID
JOIN fornecedores AS fd ON fm.fornecedorID = fd.fornecedorID
JOIN contratos AS co ON fd.fornecedorID = co.fornecedorID
JOIN projetos AS pr ON co.projetoID = pr.projetoID
JOIN participacoes AS pa ON pr.projetoID = pa.projetoID
JOIN funcionarios AS fu ON pa.funcionarioID = fu.funcionarioID
WHERE pr.projetoDescricao = 'Conserto da ponte principal do Rio Kama' AND fu.funcionarioNome = 'Yuri Nikolayevich Doroshenko';

/* Quais são os fornecedores deste mesmo projeto do item IV? */
SELECT pe.pecaNome, fd.fornecedorNome FROM pecas AS pe
JOIN fornecimentos AS fm ON pe.pecaID = fm.pecaID
JOIN fornecedores AS fd ON fm.fornecedorID = fd.fornecedorID
JOIN contratos AS co ON fd.fornecedorID = co.fornecedorID
JOIN projetos AS pr ON co.projetoID = pr.projetoID
JOIN participacoes AS pa ON pr.projetoID = pa.projetoID
JOIN funcionarios AS fu ON pa.funcionarioID = fu.funcionarioID
WHERE pr.projetoDescricao = 'Conserto da ponte principal do Rio Kama';

/* No departamento Y, apresentar quem é o funcionário de maior salário, apresentar o nome do projeto e qual departamento. */
SELECT fu.funcionarioNome, pr.projetoDescricao, de.departamentoSetor FROM projetos AS pr
JOIN participacoes AS pa ON pr.projetoID = pa.projetoID
JOIN funcionarios AS fu ON pa.funcionarioID = fu.funcionarioID
JOIN departamentos AS de ON fu.departamentoID = de.departamentoID
WHERE de.departamentoSetor = 'Logística'
AND fu.funcionarioSalario = (SELECT max(funcionarioSalario) 
FROM funcionarios AS fu 
JOIN departamentos AS de ON fu.departamentoID = de.departamentoID
WHERE de.departamentoSetor = 'Logística');

/* Apresentar os funcionários que tem salário acima de média. */
SELECT fu.funcionarioNome FROM funcionarios AS fu
WHERE fu.funcionarioSalario > (SELECT AVG(fu.funcionarioSalario) FROM funcionarios AS fu);

/* Apresentar os projetos dos funcionários e peças vinculadas dos funcionários que tem salário acima da média. */
SELECT fu.funcionarioNome, pr.projetoDescricao, pe.pecaNome FROM funcionarios AS fu
JOIN participacoes AS pa ON fu.funcionarioID = pa.funcionarioID
JOIN projetos AS pr ON pa.projetoID = pr.projetoID
JOIN contratos AS co ON pr.projetoID = co.projetoID
JOIN fornecedores AS fd ON co.fornecedorID = fd.fornecedorID
JOIN fornecimentos AS fm ON fd.fornecedorID = fm.fornecedorID
JOIN pecas AS pe ON fm.pecaID = pe.pecaID
WHERE fu.funcionarioSalario > (SELECT AVG(fu.funcionarioSalario) FROM funcionarios AS fu);
/* OBS: O Funcionário Semyon aparece na pesquisa anterior, mas não nessa, porque ele não está vinculado a nenhum projeto

/* CRIE VOCÊ MESMO UM ENUNCIADO DE PESQUISA COM JOIN DE TRÊS TABELAS */
/* Apresentar todos os funcionários e o(s) projeto(s) ao qual estão vinculdaos, ordenando por ordem crescente de salário */
SELECT fu.funcionarioNome, pr.projetoDescricao FROM funcionarios AS fu
JOIN participacoes AS pa ON fu.funcionarioID = pa.funcionarioID
JOIN projetos AS pr ON pa.projetoID = pr.projetoID
ORDER BY fu.funcionarioSalario ASC; 
