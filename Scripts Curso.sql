CREATE DATABASE teste01 ON PRIMARY
(NAME = teste01,
FILENAME = 'C:\SQL\teste01.mdf',
SIZE = 6MB,
MAXSIZE = 15MB,
FILEGROWTH = 10%)
LOG ON (
NAME = teste01_log,
FILENAME = 'C:\SQL\teste01.ldf',
SIZE = 1MB,
FILEGROWTH = 1MB)
GO

-- PRIMEIRA PARTE - CRIAR BANCO DE DADOS
-- Consultar bancos existentes
SELECT name
FROM master.sys.databases
ORDER BY name;

EXEC sp_databases;

-- Selecionar banco a usar
/*USE teste01;*/

-- Obter informações sobre um banco específico
EXEC sp_helpdb teste01;

-- Excluir banco de dados
DROP DATABASE IF EXISTS teste01;

-- Excluir banco em uso
/*USE MASTER
GO
ALTER DATABASE teste01 
SET SINGLE_USER WITH ROLLBACK IMMEDIATE
DROP DATABASE teste01;*/

-- SEGUNDA PARTE - CONSTRAINTS 
-- foi somente teoria, sem nada prático, explicando o que significa cada CONSTRAINT

-- TERCEIRA PARTE - CRIAR TABELA
CREATE DATABASE Biblioteca;

CREATE TABLE Autor1 (
IdAutor SMALLINT IDENTITY,
NomeAutor VARCHAR(50) NOT NULL,
SobrenomeAutor VARCHAR (60) NOT NULL,
CONSTRAINT pk_id_autor PRIMARY KEY (IdAutor)
);

/*sp_help Autor;*/

CREATE TABLE Editora1(
IdEditora SMALLINT PRIMARY KEY IDENTITY,
NomeEditora VARCHAR (50) NOT NULL
);

CREATE TABLE Assunto1(
IdAssunto TINYINT PRIMARY KEY IDENTITY,
NomeAssunto VARCHAR (25) NOT NULL
);

CREATE TABLE Livro1(
IdLivro SMALLINT PRIMARY KEY IDENTITY (100,1),
NomeLivro VARCHAR (70) NOT NULL,
ISBN13 CHAR(13) UNIQUE NOT NULL,
DataPub DATE,
PrecoLivro MONEY NOT NULL,
NumeroPaginas SMALLINT NOT NULL,
IdEditora SMALLINT NOT NULL,
IdAssunto TINYINT NOT NULL,
CONSTRAINT fk_id_editora FOREIGN KEY (IdEditora)
	REFERENCES Editora(IdEditora) ON DELETE CASCADE,
CONSTRAINT fk_id_assunto FOREIGN KEY(IdAssunto)
	REFERENCES Assunto(IdAssunto) ON DELETE CASCADE,
CONSTRAINT verifica_preco CHECK(PrecoLivro >=0)
);

CREATE TABLE LivroAutor1(
IdLivro SMALLINT NOT NULL,
IdAutor SMALLINT NOT NULL,
CONSTRAINT fk_id_livros FOREIGN KEY(IdLivro) REFERENCES Livro(IdLivro),
CONSTRAINT fk_id_autores FOREIGN KEY(IdAutor) REFERENCES Autor(IdAutor),
CONSTRAINT pk_livro_autor PRIMARY KEY (IdLivro, IdAutor)
);

SELECT name FROM Biblioteca.sys.tables

-- QUARTA PARTE - ALTERAR E EXCLUIR TABELAS

-- adicionando uma nova coluna a uma tabela existente
ALTER TABLE Livro
ADD Edição SMALLINT

-- alterar o tipo de dados de uma coluna
ALTER TABLE Livro
ALTER COLUMN Edição TINYINT

-- adicionar chave primária
/*ALTER TABLE NomeTabela
ADD PRIMARY KEY (Coluna)*/

-- excluir uma constraint de uma coluna
/*ALTER TABLE Livro
DROP CONSTRAINT NomeConstraint*/

-- verificar nomes das constraints
/*sp_help Livro*/

-- excluir uma coluna de uma tabela
ALTER TABLE Livro
DROP COLUMN Edição;

-- excluir uma tabela: DROP TABLE
/*DROP TABLE Autor*/

-- renomear uma tabela: sp_rename
/*sp_rename 'tbl_Livros' , 'Livro';*/

-- QUINTA PARTE - INSERIR REGISTROS

-- inserção dos dados nas suas respectivas tabelas

INSERT INTO Assunto (NomeAssunto)
VALUES
(' Ficção Científica'), ('Botânica'),
('Eletrônica'), ('Matemática'),
('Aventura'), ('Romance'),
('Finanças'), ('Gastronomia'),
('Terror'), ('Administração'),
('Informática'), ('Suspense');

INSERT INTO Editora (NomeEditora)
VALUES
('Prentice Hall'),('O´Reilly');

INSERT INTO Editora (NomeEditora)
VALUES
('Aleph'), ('Microsoft Press'), ('Wiley'), ('HarperCollins'),
('Érica'), ('Novatec'), ('McGraw-Hill'), ('Apress'), 
('Franscisco Alves'), ('Sybex'), ('Globo'), ('Companhia das Letras'),
('Morro Branco'), ('Penguin Book'), ('Martin Claret'), ('Record'),
('Springer'), ('Melhoramentos'), ('Oxford'), ('Taschen'),
('Ediouro'), ('Bookman');

INSERT INTO Autor (NomeAutor, SobrenomeAutor)
VALUES 
('Umberto', 'Eco'), ('Daniel', 'Barret'), ('Gerald', 'Carter'), ('Mark', 'Sobel'),
('William', 'Stanek'), ('Christine', 'Bresnahan'), ('Wlliam', 'Gibson'), 
('James', 'Joyce'), ('Jhon', 'Emsley'), ('José', 'Saramargo'),
('Richard', 'Silverman'), ('Robert', 'Byrnes'), ('Jay', 'Ts'), 
('Robert', 'Eckstein'), ('Paul', 'Horowitz'), ('Winfield', 'Hill'),
('Joel', 'Murach'), ('Paul', 'Scherz'), ('Simon', 'Monk'),
('George', 'Orwell'), ('Ítalo', 'Calvino'), ('Machado', 'de Assis'),
('Oliver', 'Sacks'), ('Ray', 'Bradbury'), ('Walter', 'Isaacson'),
('Benjamin', 'Graham'), ('Júlio', 'Verne'), ('Marcelo', 'Gleiser'),
('Harri', 'Lorenzi'), ('Humphrey', 'Carpenter'), ('Isaac', 'Asimov'),
('Aldous', 'Huxley'), ('Arthur', 'Conan Doyle'), ('Blaise', 'Pascal'), 
('Jostein', 'Gaarder'), ('Stephen', 'Hawking'), ('Stephen', 'Jay Gould'), 
('Neil', 'De Grasse Tyson'), ('Charles', 'Darwin'), ('Alan', 'Turing'), 
('Arthur', 'C. Clarke');

INSERT INTO Livro (NomeLivro, ISBN13, DataPub, PrecoLivro, NumeroPaginas, IdEditora, IdAssunto) VALUES
('A Arte da Eletrônica', '9788582604342', '2017-03-08', 300.74, 1160, 24, 3),
('Vinte Mil Léguas Submarinas', '9788582850022', '2014-09-16', 24.50, 448, 16, 1),
('O Investidor Inteligente', '9788595080805', '2016-01-25', 79.90, 450, 6, 7),
('2001 - Um Odisséia no Espaço', '9788576571551', '2020-09-30', 55.86, 336, 3, 1),
('Fahrenheit 451', '9788525052247', '2012-06-01', 43.56, 216, 3, 1),
('Admirável mundo novo', '9788525056009', '2014-01-01', 50.32, 312, 3, 1),
('1984', '9788535914849', '2009-07-21', 29.67, 416, 14, 1),
('A volta ao mundo em 80 dias', '9788537816134', '1873-01-01', 59.41, 256, 11, 5),
('O Nome da Rosa', '9788501115829', '2019-12-16', 51.99, 592, 18, 5),
('Memórias Póstumas de Brás Cubas', '9788525433131', '1881-01-01', 34.90, 240, 14, 6),
('O Evangelho Segundo Jesus Cristo', '9788535905595', '1991-01-01', 49.90, 512, 14, 6),
('Cidades Invisíveis', '9788535907445', '1972-01-01', 42.80, 176, 14, 6),
('Windows Server 2016: Installation and Configuration', '9781535074094', '2016-07-12', 432.00, 436, 4, 11),
('Ensaio Sobre a Cegueira', '9788571645118', '1995-01-01', 39.90, 312, 14, 6),
('Ulisses', '9780141184432', '1922-02-02', 78.90, 450, 16, 6),
('Practical Electronics for Inventors', '9781259587542', '2016-07-11', 212.58, 1056, 9, 3),
('Eu Robô', '9788576571667', '1950-12-02', 35.00, 300, 3, 1),
('Dom Casmurro', '9788525404186', '1900-01-01', 19.90, 256, 14, 6);

INSERT INTO LivroAutor (IdLivro, IdAutor)
VALUES
(100, 15), (100, 16), (101, 27), (102, 26), (103, 41), (104, 24), (105, 32), (106, 20), (107, 27),
(108, 1), (109, 22), (110, 10), (111, 21), (112, 5), (113, 10), (114, 8), (115, 18), (115, 19), 
(116, 31), (117, 22);

-- verificando com INNER JOIN
SELECT NomeLivro, NomeAutor, SobrenomeAutor
FROM Livro
INNER JOIN LivroAutor
	ON Livro.IdLivro = LivroAutor.IdLivro
INNER JOIN Autor
	ON Autor.IdAutor = LivroAutor.IdAutor
ORDER BY NomeLivro;


-- SEXTA PARTE - CONSULTAS SIMPLES (SELECT FROM)

-- foram feitos selects simples, sem muita complexidade e que eu já sabia

-- selecionando os Ids de editora sem repetição
SELECT DISTINCT IdEditora
FROM Livro

-- vou criar a tabela nova com os campos livro e isbn13
SELECT NomeLivro, ISBN13
INTO LivroISBN
FROM Livro;


SELECT NomeLivro, PrecoLivro, DataPub
FROM Livro;

SELECT SobrenomeAutor
FROM Autor;

SELECT NomeAssunto
FROM Assunto;

SELECT NomeEditora, IdEditora
FROM Editora;

SELECT DISTINCT IdAssunto
FROM Livro;

SELECT *
INTO LivrosFiccao
FROM Livro WHERE IdAssunto = 1;

-- SÉTIMA PARTE - ORDENAÇÃO DE RESULTADOS

SELECT * FROM Livro
ORDER BY NomeLivro;

SELECT NomeLivro, IdEditora
FROM Livro
ORDER BY IdEditora;

SELECT NomeLivro, PrecoLivro
FROM Livro
ORDER BY PrecoLivro DESC;

SELECT NomeLivro, PrecoLivro, IdEditora
FROM Livro
ORDER BY IdEditora ASC, PrecoLivro DESC;

-- OITAVA PARTE - SELECT TOP

SELECT TOP (2) NomeLivro
FROM Livro
ORDER BY NomeLivro;

SELECT TOP (15) PERCENT NomeLivro
FROM Livro
ORDER BY NomeLivro;

SELECT TOP (3) NomeLivro
FROM Livro
ORDER BY NomeLivro DESC;

SELECT TOP (4) NomeLivro, PrecoLivro
FROM Livro
ORDER BY PrecoLivro DESC;

-- with ties
SELECT TOP (3) WITH TIES NomeLivro, IdAssunto
FROM Livro
ORDER BY IdAssunto DESC;

-- NONA PARTE - FILTROS COM WHERE

SELECT NomeLivro, DataPub
FROM Livro
WHERE IdEditora = 3;

SELECT IdAutor, NomeAutor
FROM Autor
WHERE SobrenomeAutor = 'Verne';

SELECT NomeLivro, PrecoLivro
FROM Livro
WHERE PrecoLivro > 100.00
ORDER BY PrecoLivro;

SELECT NomeLivro, DataPub
FROM Livro
WHERE IdEditora = (
	SELECT IdEditora 
	FROM Editora
	WHERE NomeEditora = 'Aleph'
)
ORDER BY NomeLivro;

-- DÉCIMA PARTE - EXCLUIR REGISTROS (DELETE)

SELECT * FROM Assunto;

DELETE FROM Assunto
WHERE IdAssunto = 8;

INSERT INTO Assunto (NomeAssunto)
VALUES ('Policial');

DELETE FROM Assunto
WHERE NomeAssunto = 'Policial';

-- DÉCIMA PRIMEIRA PARTE - LIMPAR TABELAS (TRUNCATE)

-- Rotina para inserir dados na tabela
/*DECLARE @Contador INT = 1

WHILE @Contador <= 100
BEGIN 
	INSERT INTO TESTE (VALORTESTE) VALUES (@Contador *3)
	SET @Contador = @Contador + 1
END

SELECT * FROM TESTE; 
*/

-- limpando os dados da tabela
TRUNCATE TABLE TESTE;

-- verificar o valor atual de identity
SELECT IDENT_CURRENT('TESTE');

-- DÉCIMA SEGUNDA PARTE - ATUALIZAR TABELAS (UPDATE)

UPDATE Livro
SET NomeLivro = 'Eu, Robô'
WHERE IdLivro = 116;

SELECT IdLivro, NomeLivro FROM Livro WHERE IdLivro = 116

UPDATE Livro
SET NomeLivro = '2001 - Uma Odisséia no Espaço'
WHERE IdLivro = 103

SELECT IdLivro, NomeLivro FROM Livro WHERE IdLivro = 103

UPDATE Livro
SET PrecoLivro = 60.00
WHERE IdLivro = 105;

SELECT NomeLivro, PrecoLivro FROM Livro WHERE IdLivro = 105

-- subindo o valor em 10%
UPDATE Livro
SET PrecoLivro = PrecoLivro * 1.1
WHERE IdLivro = 105;

-- descendo o preço em 20%
UPDATE Livro
SET PrecoLivro = PrecoLivro * 0.8
WHERE IdLivro = 105;

-- altereando duas colunas de uma vez, preço e número de páginas
UPDATE Livro
SET PrecoLivro = 60.00, NumeroPaginas = 320
WHERE IdLivro = 105;

SELECT NomeLivro, PrecoLivro, NumeroPaginas FROM Livro WHERE IdLivro = 105; 

-- DÉCIMA TERCEIRA PARTE - ALIASES COM AS

SELECT NomeLivro AS Livros FROM Livro

SELECT A.NomeAutor AS Nome, A.SobrenomeAutor AS Sobrenome FROM Autor AS A;

SELECT TOP (3) NomeLivro AS 'Livros mais caros', PrecoLivro AS 'Preço do Livro'
FROM Livro AS L
ORDER BY 'Preço do Livro' DESC;

-- se caso eu quiser tirar todos os ALIAS (AS) a consulta vai funcionar e nomear da mesma forma

-- DÉCIMA QUARTE PARTE - OPERADPRES LÓGICOS

SELECT * FROM LIVRO
WHERE IdLivro > 102 AND IdEditora < 4;

SELECT * FROM Livro
WHERE IdLivro > 110 OR IdEditora < 4;

SELECT * FROM Livro
WHERE IdLivro > 110 OR NOT IdEditora < 4;

SELECT * FROM Livro
WHERE DataPub BETWEEN '2004-05-07' AND '20140507';

SELECT NomeLivro AS Livro, PrecoLivro as Preço FROM Livro
WHERE PrecoLivro BETWEEN 50.00 AND 100.00;

SELECT NomeLivro, DataPub, PrecoLivro
FROM LIVRO
WHERE PrecoLivro >= 20.00
AND DataPub BETWEEN '20050620' AND '20100620'
OR DataPub BETWEEN '20160101' AND '20200101'
ORDER BY DataPub DESC;

-- DÉCIMA SEXTA PARTE - OPERADOR UNION

SELECT NomeAutor Nome, 'Autor' AS Tipo 
FROM AUTOR
UNION
SELECT NomeEditora Nome, 'Editora' AS Tipo
FROM Editora

-- nomes dos livros e seus assuntos
SELECT NomeLivro AS Nome, 'Livro' AS Tipo
FROM Livro
UNION
SELECT NomeAssunto AS Nome, 'Assunto' AS Tipo
FROM Assunto

-- indicando o nome de tudo no banco em uma única linha
SELECT NomeAutor AS Nome, 'Autor' AS Tipo
FROM Autor
UNION
SELECT NomeEditora AS Nome, 'Editora' AS Tipo
FROM Editora
UNION
SELECT NomeAssunto AS Nome, 'Assunto' AS Tipo
FROM Assunto
UNION
SELECT NomeLivro AS Nome, 'Livro' AS Tipo
FROM Livro

-- DÉCIMA SÉTIMA PARTE - FUNÇÕES DE AGREGAÇÃO

-- quantos
SELECT COUNT(*) Total 
FROM Autor;

-- maior valor
SELECT MAX(PrecoLivro) 'Mais Caro'
FROM Livro;

-- menor valor
SELECT MIN(NumeroPaginas)
FROM Livro;

-- média dos valores
SELECT AVG(PrecoLivro) 'Preço Médio'
FROM Livro

-- soma
SELECT SUM(PrecoLivro) 'Valor Total'
FROM Livro

SELECT COUNT(*) Total 
FROM Livro
WHERE IdAssunto = 1;

SELECT SUM(PrecoLivro) / COUNT (*) AS 'Preço Médio'
FROM Livro

-- sub consulta que mostra o nome e valor do livro mais caro
SELECT NomeLivro, PrecoLivro
FROM Livro
WHERE PrecoLivro = (
	SELECT MAX(PrecoLivro)
FROM Livro);

-- DÉCIMA OITAVA PARTE - OPERADOR LIKE

/*
METACARACTERES
% - qualquer cadeia de 0 ou mais caracteres
_ qualquer caractere único
[] caracteres únicos no intervalo ou conjunto especificado
[^] caracteres únicos NÃO no intervalo ou conjunto especificado
*/

-- livros com o nome iniciado com a letra f
SELECT *
FROM Livro
WHERE NomeLivro LIKE 'F%';

SELECT NomeAutor
FROM Autor
WHERE NomeAutor NOT LIKE 'S%'

-- livros que começam ou com a letra F ou D
SELECT *
FROM Livro
WHERE NomeLivro LIKE '[FD]%';

-- livros que começam com vogais e sem ascento
SELECT *
FROM Livro
WHERE NomeLivro LIKE '%[aeiou]'

-- livros que terminam com vogais e sem ascento
SELECT *
FROM Livro
WHERE NomeLivro LIKE '[aeiou]%'

-- livros que começam com números
SELECT *
FROM Livro
WHERE NomeLivro LIKE '[0-9]%'

-- livros que começam com a letra a e terminam com o
SELECT *
FROM Livro
WHERE NomeLivro LIKE 'A%o'

-- nome que começa com R e sobrenome que começa com B
SELECT NomeAutor, SobrenomeAutor
FROM Autor
WHERE NomeAutor LIKE 'R%' AND SobrenomeAutor LIKE 'B%'

-- penultimo caractere seja uma vogal
SELECT *
FROM Livro
WHERE NomeLivro LIKE '%[aeiou]_'

-- nome das editoram que inicam entre O e T
SELECT NomeEditora
FROM Editora
WHERE NomeEditora LIKE '[o-t]%'

-- nome do autor que tenha 4 letras e comece com a letra J
SELECT NomeAutor, SobrenomeAutor
FROM Autor
WHERE NomeAutor LIKE 'J___';

-- começam com uma consoante, sem números
SELECT *
FROM Livro
WHERE NomeLivro NOT LIKE '[aeiou0-9]%'

-- DÉCIMA NONA PARTE - BACKUP E RESTAURAÇÃO DE BD

/*
BACKUP DATABASE NOME_BANCO
TO DISK = 'X:\CAMINHO\NOME_BANCO.bak'
[WITH FORMAT]
GO

RESTORE DATABASE NOME_BANCO
FROM DISK = 'X:\CAMINHO\NOME_BANCO.bak'
[WITH FORMAT] 
GO

USE master;
GO
ALTER DATABASE NOME_BANCO
SET single_user WITCH ROLLBACK immediate;
GO
DROP DATABASE NOME_BANCO;
GO

RESTORE DATABASE NOME_BANCO
FROM DISK = 'X:\CAMINHO\NOME_BANCO.BAK';
GO
*/

-- VIGÉSIMA PARTE - CLÁUSULA INNER JOIN

SELECT * 
FROM Livro
	INNER JOIN Assunto
	ON Livro.IdAssunto = Assunto.IdAssunto;

SELECT L.NomeLivro Livros, E.NomeEditora Editoras
FROM Livro L
	INNER JOIN Editora E
	ON L.IdEditora = E.IdEditora
WHERE E.NomeEditora LIKE '[MH]%'
ORDER BY L.NomeLivro;


-- NOME DO LIVRO, NOME E SOBRENOME DOS AUTORES
SELECT L.NomeLivro Livro, E.NomeEditora Editora, A.NomeAutor Nome, A.SobrenomeAutor Sobrenome
FROM Livro L
	INNER JOIN LivroAutor LA
	ON L.IdLivro = LA.IdLivro
	INNER JOIN Autor A
	ON LA.IdAutor = A.IdAutor
	INNER JOIN Editora E
	ON L.IdEditora = E.IdEditora
ORDER BY Livro;

-- EXERCÍCIOS INNER JOIN

-- 01 nome do livro e seus assuntos
SELECT L.NomeLivro Livro, A.NomeAssunto Assunto
FROM Livro L
	INNER JOIN Assunto A
	ON L.IdAssunto = A.IdAssunto
ORDER BY Livro;

-- 02 nome e sobrenome do autor, livro escrito por cada um e assunto dos livros
SELECT AU.NomeAutor + ' ' + AU.SobrenomeAutor [Nome Completo], L.NomeLivro Livro, A.NomeAssunto Assunto
FROM LivroAutor LA
	INNER JOIN Autor AU
	ON LA.IdAutor = AU.IdAutor
	INNER JOIN Livro L
	ON LA.IdLivro = L.IdLivro
	INNER JOIN Assunto A
	ON L.IdAssunto = A.IdAssunto
ORDER BY [Nome Completo];

-- 03 nome dos livros, preco, editora e assunto, ordenado pelo nome dos livros
SELECT L.NomeLivro 'Nome do Livro', L.PrecoLivro Preço, E.NomeEditora 'Editora Responsável', A.NomeAssunto 'Assunto do Livro'
FROM Livro L
	INNER JOIN Editora E
	ON L.IdEditora = E.IdEditora
	INNER JOIN Assunto A
	ON L.IdAssunto = A.IdAssunto
ORDER BY [Nome do Livro];

-- 04 nome dos livros e data de publicação, quando o sobrenome do autor começar com a letra b
SELECT L.NomeLivro 'Nome do Livro', L.DataPub 'Data de publicação', A.NomeAutor + ' ' + A.SobrenomeAutor [Nome completo]
FROM Livro L
	INNER JOIN LivroAutor LA
	ON L.IdLivro = LA.IdLivro
	INNER JOIN Autor A
	ON LA.IdAutor = A.IdAutor
WHERE A.SobrenomeAutor LIKE '[B]%'
ORDER BY A.NomeAutor;

-- 05 assuntos do livro e sobrenomes dos autores dos livros que custam mais que 80 reais
SELECT A.NomeAssunto Assunto, AU.SobrenomeAutor Sobrenome, L.PrecoLivro Preço
FROM Livro L
	INNER JOIN LivroAutor LA
	ON L.IdLivro = LA.IdLivro
	INNER JOIN Autor AU
	ON LA.IdAutor = AU.IdAutor
	INNER JOIN Assunto A
	ON L.IdAssunto = A.IdAssunto
WHERE L.PrecoLivro > 80.00;

-- 06 preço, assunto e nome dos livros que custam entre 70 e 170, ordenado do mais caro para o mais barato
SELECT L.NomeLivro 'Nome do Livro', L.PrecoLivro Preço, A.NomeAssunto Assunto
FROM Livro L
	INNER JOIN Assunto A
	ON L.IdAssunto = A.IdAssunto
WHERE PrecoLivro BETWEEN 70.00 AND 170
ORDER BY PrecoLivro DESC;


-- VIGÉSIMA PRIMEIRA PARTE - OUTER JOINS

SELECT *
FROM Editora E
LEFT JOIN Livro L
ON L.IdEditora = E.IdEditora

SELECT *
FROM Livro L 
LEFT JOIN Editora E
ON L.IdEditora = E.IdEditora;

SELECT *
FROM Editora E
RIGHT JOIN Livro L
ON L.IdEditora = E.IdEditora;

SELECT *
FROM Livro L 
RIGHT JOIN Editora E
ON L.IdEditora = E.IdEditora;

SELECT *
FROM Livro L 
FULL JOIN Editora E
ON L.IdEditora = E.IdEditora;

SELECT *
FROM Livro
CROSS JOIN Assunto;

-- VIGÉSIMA SEGUNDA PARTE - EXIBIÇÕES, VIEWS

/*CREATE OR ALTER VIEW vwLivroPreco AS
	SELECT TOP 5 NomeLivro, PrecoLivro
	FROM Livro
	ORDER BY PrecoLivro;
*/

EXEC sp_helptext vwLivroPReco

IF OBJECT_ID('vwLivroAssunto', 'view') IS NOT NULL
	DROP VIEW vwLivroAssunto;
GO
CREATE VIEW vwLivroAssunto AS
	SELECT L.NomeLivro Livro, A.NomeAssunto Assunto
	FROM Livro L
	JOIN Assunto A
	ON L.IdAssunto = A.IdAssunto
GO

SELECT * FROM vwLivroAssunto;

--ALTER VIEW vwLivroAssunto AS
	SELECT L.NomeLivro Livro, L.ISBN13, A.NomeAssunto Assunto
	FROM Livro L
	JOIN Assunto A
	ON L.IdAssunto = A.IdAssunto;

-- VIGÉSIMA TERCEIRA PARTE - SUCONSULTAS (SUBQUERIES)

SELECT NomeLivro, IdEditora
FROM Livro
WHERE IdEditora = (
	SELECT IdEditora
	FROM Editora
	WHERE NomeEditora = 'Aleph'
)
ORDER BY NomeLivro;

SELECT NomeEditora
FROM Editora
WHERE IdEditora IN (
	SELECT IdEditora
	FROM Livro
	WHERE IdAssunto IN(1,3,7)
)
ORDER BY NomeEditora;

SELECT L.NomeLivro, L.PrecoLivro
FROM Livro L,
	(SELECT AVG(PrecoLivro) AS MediaPreco FROM Livro) AS Subconsulta
WHERE L.PrecoLivro > Subconsulta.MediaPreco

SELECT NomeEditora
FROM Editora
WHERE IdEditora IN (
	SELECT IdEditora
	FROM Livro
	WHERE IdAssunto = (
		SELECT IdAssunto
		FROM Assunto
		WHERE NomeAssunto = 'Ficção Científica'
		)
)
ORDER BY NomeEditora;