/* Criar uma tabela chamada alunos.
Esta tabela terá matricula (chave primária), nome, curso, nota global e frequência global.
Obs: Nota de 0 a 10, frequência global de 0 a 100. */

/* Criar tabela alunos */
create table alunos(
    alunoMatricula serial primary key,
    alunoNome varchar(255),
    alunoCurso varchar(255),
    alunoNota real check(alunoNota >= 0 and alunoNota <= 10),
    alunoFrequencia real check(alunoFrequencia >= 0 and alunoFrequencia <= 100)
);

/* Popular o sistema */
insert into alunos(alunoNome, alunoCurso, alunoNota, alunoFrequencia) values ('Pedro', 'Refrigeração', 8, 82);
insert into alunos(alunoNome, alunoCurso, alunoNota, alunoFrequencia) values ('Marcos', 'Refrigeração', 5, 52);
insert into alunos(alunoNome, alunoCurso, alunoNota, alunoFrequencia) values ('Beatriz', 'Informática', 9, 93);
insert into alunos(alunoNome, alunoCurso, alunoNota, alunoFrequencia) values ('Julia', 'Automação', 10, 90);
insert into alunos(alunoNome, alunoCurso, alunoNota, alunoFrequencia) values ('Augusto', 'Geoprocessamento', 3, 7);
insert into alunos(alunoNome, alunoCurso, alunoNota, alunoFrequencia) values ('Jeosvaldo', 'Química', 10, 100);

/* Mostrar todos os alunos em ordem alfabética de nome */
select * from alunos order by alunoNome asc;

/* Mostrar alunos com frequência maior ou igual a 75 */ 
select * from alunos where alunoFrequencia >= 75;

/* Mostrar alunos com nota maior ou igual a 7 */
select * from alunos where alunoNota >= 7;

/* Mostrar alunos com nota menor que 7 */  
select * from alunos where alunoNota < 7; 

/* Mostrar alunos com nota maior ou igual a média das notas de todos os alunos */
select * from alunos where alunoNota >= (select avg(alunoNota) from alunos);

/* Mostrar matricula e nome do(s) aluno(s) com a maior nota */
select alunoMatricula, alunoNome from alunos where alunoNota = (select max(alunoNota) from alunos);

/* Atualizar para 7 a nota de todos os alunos com nota maior que 6.5 e menor que 7 */
update alunos set alunoNota = 7 where alunoNota > 6.5 and alunoNota < 7;

/* Remover da tabela alunos com frequencia menor que 10 */
delete from alunos where alunoFrequencia < 10; 
