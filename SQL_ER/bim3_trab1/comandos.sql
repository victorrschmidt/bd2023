/* Primeiro trabalho do terceiro bimestre */

/* Tabelas */
CREATE TABLE tipoAssinante(
    tipoAssinanteID SERIAL PRIMARY KEY,
    tipoAssinanteDesc VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE assinante(
    assinanteID SERIAL PRIMARY KEY,
    assinanteNome VARCHAR(255) NOT NULL,
    tipoAssinanteID INT REFERENCES tipoAssinante(tipoAssinanteID)
);

CREATE TABLE ramo(
    ramoID SERIAL PRIMARY KEY,
    ramoDesc VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE assinante_ramo(
    assinante_ramoID SERIAL PRIMARY KEY,
    assinanteID INT REFERENCES assinante(assinanteID),
    ramoID INT REFERENCES ramo(ramoID)
);

CREATE TABLE municipio(
    municipioID SERIAL PRIMARY KEY,
    municipioDesc VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE endereco(
    enderecoID SERIAL PRIMARY KEY,
    enderecoCEP CHAR(9) NOT NULL,
    enderecoBairro VARCHAR(255) NOT NULL,
    enderecoDesc VARCHAR(255) NOT NULL,
    enderecoComplemento VARCHAR(255),
    assinanteID INT REFERENCES assinante(assinanteID),
    municipioID INT REFERENCES municipio(municipioID)
);

CREATE TABLE telefone(
    telefoneID SERIAL PRIMARY KEY,
    telefoneDDD CHAR(2) NOT NULL,
    telefoneNumero CHAR(9) NOT NULL UNIQUE,
    enderecoID INT REFERENCES endereco(enderecoID)
);

/* Popular as tabelas */
INSERT INTO tipoAssinante(tipoAssinanteDesc) VALUES
('Residencial'),('Publico'),('Empresarial'),('Compartilhado');

INSERT INTO assinante(assinanteNome,tipoAssinanteID) VALUES
('Augusto da Silva Prado',2),
('Marina Cardoso Mackensen',1),
('Professor Eduardo Briao',1),
('Lucas Takeda Campos',4),
('Jaqueline Freitas de Carvalho',3),
('Rafael Dias Costa',2),
('Beatriz Duarte Ferreira',3),
('Jeosvaldo Cunha dos Anjos',2);

INSERT INTO ramo(ramoDesc) VALUES
('Comercio'),('Industria'),('Servicos');

INSERT INTO assinante_ramo(assinanteID,ramoID) VALUES 
(1,2),(3,3),(4,3),(5,1),(6,2),(8,2);

INSERT INTO municipio(municipioDesc) VALUES
('Rio Grande'),('Pelotas'),('Porto Alegre'),('Santa Maria');

INSERT INTO endereco(enderecoCEP,enderecoBairro,enderecoDesc,enderecoComplemento,assinanteID,municipioID) VALUES
('96211-090','Cidade Nova','Rua Dom Bosco 64','Apartamento 8',1,1), 
('96201-170','Getulio Vargas','Rua Edgar Fontoura 32','Casa vermelha',3,1),
('96020-260','Tres Vendas','Avenida Dom Joaquim 128','Ao lado do armazém',2,2),
('96065-400','Tres Vendas','Rua Raul Pompeia 8','Apartamento 4',4,2),
('90430-130','Independencia','Rua Castro Alves 512','Apartamento 1024',5,3),
('90520-430','Passo dAreia','Rua Rio Pardo 16','Em frente ao parque',6,3),
('90450-190','Medianeira','Coronel Gastao Haslocher Mazeron 2048','Em frente ao estadio olimpico',7,3),
('97010-033','Centro','Rua dos Andradas 2','Apartamento 1',8,4);

INSERT INTO telefone(telefoneDDD,telefoneNumero,enderecoID) VALUES
('53','991753920',1), 
('53','914098561',1),
('53','912524149',2),
('53','849463762',3),
('53','816006707',3),
('53','817411890',5),
('53','999700364',6),
('53','819476971',7),
('53','842962858',8),
('53','842813231',8);

/* Consultas */
/* a) */
SELECT a.assinanteNome,t.telefoneDDD,t.telefoneNumero,e.enderecoBairro,e.enderecoDesc
FROM assinante AS a JOIN endereco AS e ON a.assinanteID = e.assinanteID
LEFT OUTER JOIN telefone AS t ON e.enderecoID = t.enderecoID
ORDER BY a.assinanteNome ASC;

/* b) */
SELECT a.assinanteNome,r.ramoDesc
FROM assinante AS a
LEFT OUTER JOIN assinante_ramo AS ar ON a.assinanteID = ar.assinanteID
LEFT OUTER JOIN ramo AS r ON ar.ramoID = r.ramoID
ORDER BY a.assinanteNome ASC;

SELECT a.assinanteNome,r.ramoDesc
FROM assinante AS a
LEFT OUTER JOIN assinante_ramo AS ar ON a.assinanteID = ar.assinanteID
LEFT OUTER JOIN ramo AS r ON ar.ramoID = r.ramoID
ORDER BY r.ramoDesc ASC;

/* c) */
SELECT a.assinanteNome
FROM tipoAssinante AS ta
JOIN assinante AS a ON ta.tipoAssinanteID = a.tipoAssinanteID
JOIN endereco AS e ON a.assinanteID = e.assinanteID
JOIN municipio AS m ON e.municipioID = m.municipioID
WHERE ta.tipoAssinanteDesc = 'Residencial'
AND m.municipioDesc = 'Pelotas'
ORDER BY a.assinanteNome ASC;

/* d) */
SELECT t.assinanteNome AS maisDeUmTelefone
FROM (
    SELECT a.assinanteNome,COUNT(*) AS vezes
    FROM assinante AS a
    JOIN endereco AS e ON a.assinanteID = e.assinanteID
    JOIN telefone AS t ON e.enderecoID = t.enderecoID
    GROUP BY assinanteNome
) AS t
WHERE vezes > 1
ORDER BY assinanteNome ASC;

/* e) */
SELECT a.assinanteNome,t.telefoneDDD,t.telefoneNumero
FROM assinante AS a
RIGHT JOIN tipoAssinante AS ta ON a.tipoAssinanteID = ta.tipoAssinanteID
JOIN endereco AS e ON a.assinanteID = e.assinanteID
JOIN municipio AS m ON e.municipioID = m.municipioID
JOIN telefone AS t ON e.enderecoID = t.enderecoID
WHERE ta.tipoAssinanteDesc = 'Empresarial' /* Comercial */
AND m.municipioDesc = 'Porto Alegre';
