CREATE DATABASE biblioteca;

CREATE TABLE usuario(
    usuario_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    usuario_tipo CHAR(1) NOT NULL,
    usuario_email VARCHAR(128) UNIQUE NOT NULL,
    usuario_senha VARCHAR(128) NOT NULL,
    usuario_nome VARCHAR(128) NOT NULL
);

CREATE TABLE livro(
    livro_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    livro_titulo VARCHAR(128) UNIQUE NOT NULL,
    livro_quantidade INT UNSIGNED NOT NULL,
    livro_autor VARCHAR(128),
    livro_editora VARCHAR(128),
    livro_ano SMALLINT UNSIGNED,
);

CREATE TABLE aluguel(
    aluguel_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    aluguel_inicio DATETIME NOT NULL,
    usuario_id INT UNSIGNED,
    livro_id INT UNSIGNED,
    FOREIGN KEY (usuario_id) REFERENCES usuario(usuario_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (livro_id) REFERENCES livro(livro_id) ON DELETE CASCADE ON UPDATE CASCADE
);