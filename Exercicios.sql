-- Liste o nome de todos os livros cadastrados em ordem alfabética crescente.
SELECT NomeLivro FROM Livro
ORDER BY NomeLivro;


-- Liste o nome dos autores e seus respectivos sobrenomes em ordem alfabética pelo sobrenome.
SELECT NomeAutor, SobrenomeAutor FROM Autor
ORDER BY SobrenomeAutor;


-- Mostre todos os livros cujo valor seja maior que R$ 50,00.
SELECT NomeLivro, PrecoLivro FROM Livro
WHERE PrecoLivro > 50.00
ORDER BY PrecoLivro;


-- Liste os livros publicados entre os anos de 2015 e 2020.
SELECT NomeLivro, DataPub FROM Livro
WHERE DataPub BETWEEN '20150101' AND '20200101';


-- Mostre os 5 livros mais caros cadastrados.
SELECT TOP (5) NomeLivro, PrecoLivro FROM Livro
ORDER BY PrecoLivro DESC;


-- Liste o nome do livro e o nome da editora responsável por ele.
SELECT NomeLivro , NomeEditora
FROM Livro
	INNER JOIN Editora
	ON Livro.IdEditora = Editora.IdEditora;


-- Liste o nome do livro e o assunto ao qual ele pertence.
SELECT NomeLivro, NomeAssunto
FROM Livro
	INNER JOIN Assunto
	ON Livro.IdAssunto = Assunto.IdAssunto;


-- Mostre os livros que custam entre R$ 40,00 e R$ 100,00 e que foram publicados após 2015.
SELECT NomeLivro, PrecoLivro, DataPub
FROM LIVRO
WHERE PrecoLivro BETWEEN 40.00 AND 100.00
AND DataPub > '20151231'


-- Liste os autores que possuem sobrenome diferente de "Silva".
SELECT SobrenomeAutor
FROM Autor
WHERE NOT SobrenomeAutor = 'Silva'
/* nesse caso eu iria fazer assim WHERE SobrenomeAutor NOT = 'Silva'.
mas o sql server acusa que uma condição do tipo não booleano...
não tinha pensado dessa forma, agora com o not antes dey certo*/


-- Mostre os livros que pertencem à editora "Aleph".
SELECT NomeLivro, NomeEditora
FROM Livro
	INNER JOIN Editora
	ON Livro.IdEditora = Editora.IdEditora
WHERE NomeEditora = 'Aleph'
ORDER BY NomeLivro


-- Liste o nome do livro juntamente com o nome completo do autor.
SELECT NomeLivro AS Livro, NomeAutor + ' ' + SobrenomeAutor
FROM Livro
	INNER JOIN LivroAutor
	ON Livro.IdLivro = LivroAutor.IdLivro
	INNER JOIN Autor
	ON Autor.IdAutor = LivroAutor.IdAutor
ORDER BY NomeAutor
/* esse aqui eu  só não consegui colocar o espaço
só faltava as aspas com espaço*/


-- Exercício 12
SELECT NomeLivro, PrecoLivro, NomeEditora
FROM Livro
	INNER JOIN Editora
	ON Livro.IdEditora = Editora.IdEditora
WHERE PrecoLivro BETWEEN 30.00 AND 120.00
AND (NomeEditora = 'Aleph' OR NomeEditora = 'Saraiva')
ORDER BY PrecoLivro DESC
/* feito uma alteração no AND, colocado as editoras entre parenteses, antes estava
AND NomeEditora = 'Aleph' 
OR NomeEditora = 'Saraiva
*/


-- BÔNUS
SELECT NomeLivro, PrecoLivro
FROM Livro
WHERE PrecoLivro > (
	SELECT PrecoLivro
	FROM Livro
	WHERE NomeLivro = 'Dom Casmurro'
)
/* esse aqui eu não entendi muito bem
o erro que estava fazendo era de lógica, comparando número com texto
SELECT NomeLivro, PrecoLivro FROM Livro
WHERE PrecoLivro > (SELECT PrecoLivro FROM Livro WHERE NomeLivro = 'Dom Casmurro'
)
*/


-- 24/06/26
-- Liste o nome dos livros e a quantidade de páginas, ordenando do livro com mais páginas para o com menos páginas.

SELECT L.NomeLivro 'Nome do Livro', L.NumeroPaginas 'Quantidade de páginas'
FROM Livro L
ORDER BY [Quantidade de páginas] DESC; 

-- Mostre quantas editoras existem cadastradas.

SELECT COUNT(NomeEditora) FROM Editora

-- Liste todos os autores cujo nome começa com a letra "A".

SELECT A.NomeAutor 'Nome do autor'
FROM Autor A
WHERE NomeAutor LIKE 'A%'

-- Mostre o livro mais antigo cadastrado.

/*SELECT L.NomeLivro Nome
FROM Livro L
WHERE NomeLivro = (
	SELECT MIN (NomeLivro)
	FROM Livro);
foi feito desse jeito*/

SELECT L.NomeLivro Nome, L.DataPub Data 
FROM Livro L 
WHERE DataPub = (
	SELECT MIN(DataPub)
	FROM Livro
);
/*o jeito correto é conforme a cima*/

-- Liste os livros publicados após o ano 2000 e que custam menos de R$ 60,00.

SELECT  L.NomeLivro 'Nome do Livro', L.DataPub 'Data de Publicação', L.PrecoLivro 'Preço do Livro'
FROM Livro L
WHERE L.DataPub > '20001231' AND L.PrecoLivro < 60.00
ORDER BY [Nome do Livro];
/*corrigido o order by que estava errado*/

-- Mostre: Nome do livro E Nome da editora somente para livros cuja editora começa com a letra "M" ou "P".

SELECT L.NomeLivro 'Nome do Livro', E.NomeEditora Editora
FROM Livro L
	INNER JOIN Editora E
	ON L.IdEditora = E.IdEditora
WHERE E.NomeEditora LIKE '[MP]%'
ORDER BY 'Nome do Livro';

-- Liste: Nome completo do autor e Nome do livro somente para autores cujo sobrenome começa com a letra "B".

SELECT AU.NomeAutor + ' ' + AU.SobrenomeAutor [Nome Completo], L.NomeLivro
FROM LivroAutor LA
	INNER JOIN Livro L
	ON LA.IdLivro = L.IdLivro
	INNER JOIN Autor AU
	ON LA.IdAutor = AU.IdAutor
WHERE AU.SobrenomeAutor LIKE 'B%'
ORDER BY [Nome Completo];

-- Mostre: Nome do livro, Assunto, Preço somente para livros do assunto "Ficção Científica".

SELECT L.NomeLivro 'Nome do Livro', L.PrecoLivro Preço, A.NomeAssunto Assunto
FROM Livro L
	JOIN Assunto A ON L.IdAssunto = A.IdAssunto
WHERE A.NomeAssunto = 'Ficção Científica'
ORDER BY [Nome do Livro];

-- Calcule o valor total de todos os livros da editora "Aleph".

SELECT SUM (PrecoLivro)
FROM Livro L
	JOIN Editora E ON L.IdEditora = E.IdEditora
WHERE E.NomeEditora = 'Aleph';

-- Liste os livros que possuem mais de 400 páginas e cujo nome começa com uma vogal.

SELECT L.NomeLivro 'Nome do Livro', L.NumeroPaginas 'Quantidade de Páginas'
FROM Livro L
WHERE L.NumeroPaginas > 400 AND L.NomeLivro LIKE '[aeiou]%'
ORDER BY [Nome do Livro]

/*Monte uma consulta retornando: Nome do livro, Nome completo do autor, Nome da editora, Nome do assunto, Preço do livro
Regras: preço maior que R$ 40,00; editora começando com A, M ou P; ordenar pelo preço do mais caro para o mais barato
*/

SELECT L.NomeLivro 'Nome do Livro', L.PrecoLivro Preço, AU.NomeAutor + ' ' + AU.SobrenomeAutor [Nome Completo], A.NomeAssunto 'Assunto do Livro',
E.NomeEditora 'Nome da Editora'
FROM LivroAutor LA
	JOIN Livro L ON LA.IdLivro = L.IdLivro
	JOIN Autor AU ON LA.IdAutor = AU.IdAutor
	JOIN Assunto A ON A.IdAssunto = L.IdAssunto
	JOIN Editora E ON L.IdEditora = E.IdEditora
WHERE L.PrecoLivro > 40 AND E.NomeEditora LIKE '[AMP]%'
ORDER BY L.PrecoLivro DESC

-- Utilizando UNION, crie uma lista única contendo:nomes dos autores e nomes das editoras, ordenado pelo nome dos autores

SELECT A.NomeAutor Nome, 'Autor' AS Origem
FROM Autor A
UNION
SELECT E.NomeEditora Nome, 'Editora' AS Origem
FROM Editora E
ORDER BY Nome
/* corrigido o order by colocado estava como NomeAutor*/

-- Desafio: Sem usar TOP. Retorne: Nome do livro e Preço apenas dos livros que possuem preço acima da média de todos os livros cadastrados.

SELECT AVG(PrecoLivro) 'Média'
FROM Livro
WHERE PrecoLivro > (
	SELECT NomeLivro, PrecoLivro
	WHERE PrecoLivro > 91.7505
);
/* Pensei de algumas formas mas nenhuma delas deu certo */

SELECT NomeLivro, PrecoLivro
FROM Livro
WHERE PrecoLivro > (
    SELECT AVG(PrecoLivro)
    FROM Livro
);
/* a forma correta é como a cima*/


-- 25/06/2026
/*
Liste: Nome do livro, Preço, Nome da editora. Somente para livros publicados após 2010 
e pertencentes às editoras: Aleph, Novatec, Record
*/

SELECT NomeLivro 'Nome do Livro', PrecoLivro 'Valor do Livro'
FROM Livro
WHERE IdEditora IN (
	SELECT IdEditora
	FROM Livro
	WHERE IdEditora IN (
		SELECT IdEditora
		FROM Editora
		WHERE NomeEditora IN ('Aleph', 'Novatec', 'Record') AND DataPub > '20101231'
		)		
);
/* a versão a cima foi até onde consegui chegar*/

SELECT 
    L.NomeLivro AS 'Nome do Livro', 
    L.PrecoLivro AS 'Valor do Livro',
    (SELECT E.NomeEditora FROM Editora E WHERE E.IdEditora = L.IdEditora) AS 'Nome da Editora'
FROM 
    Livro L
WHERE 
    L.DataPub > '2010-12-31'
    AND L.IdEditora IN (
        SELECT E.IdEditora 
        FROM Editora E 
        WHERE E.NomeEditora IN ('Aleph', 'Novatec', 'Record')
);
/* essa versão foi com auxilio do GEMINI e o GPT disse estar correta*/

-- Mostre: Nome completo do autor e nome do livro. Somente para autores cujo sobrenome contenha a letra: r em qualquer posição.

SELECT AU.NomeAutor + ' ' + AU.SobrenomeAutor [Nome completo], L.NomeLivro 'Nome do Livro'
FROM LivroAutor LA
	JOIN Livro L ON LA.IdLivro = L.IdLivro
	JOIN AUTOR AU ON LA.IdAutor = AU.IdAutor
WHERE AU.SobrenomeAutor LIKE '%r%'
ORDER BY AU.NomeAutor;

-- Retorne todos os livros cujo preço seja maior que o menor preço cadastrado.

SELECT NomeLivro, PrecoLivro
FROM Livro
WHERE PrecoLivro > (
    SELECT MIN(PrecoLivro)
    FROM Livro
)
ORDER BY NomeLivro;

-- Mostre: Nome do livro e número de páginas. Dos livros que possuem mais páginas que a média de páginas cadastradas.

SELECT NomeLivro 'Nome do Livro', NumeroPaginas 'Quantidade de páginas'
FROM Livro
WHERE NumeroPaginas > (
	SELECT AVG(NumeroPaginas)
	FROM Livro
)
ORDER BY [Nome do Livro];

-- Mostre os nomes das editoras que possuem pelo menos um livro cadastrado.

SELECT NomeLivro
FROM Livro
WHERE IdEditora IN (
	SELECT IdEditora
	FROM Livro
	WHERE NomeLivro NOT LIKE ''
	);
/* com subconsulta chego até aqui, agora com INNER JOIN facilmente eu colocaria o nome da editora para aparecer*/
/* versão a cima foi o que conseguir chegar, abaixo com a correção*/

SELECT NomeEditora
FROM Editora
WHERE IdEditora IN
(
    SELECT IdEditora
    FROM Livro
);

--Liste: Nome do livro, nome da editora, nome do assunto. Somente para livros cujo assunto seja: Informática, eletrônica, matemática

SELECT L.NomeLivro 'Nome do Livro', E.NomeEditora Editora, A.NomeAssunto 'Qual assunto'
FROM Livro L
	JOIN Editora E ON L.IdEditora = E.IdEditora
	JOIN ASSUNTO A ON L.IdAssunto = A.IdAssunto
	WHERE A.NomeAssunto IN ('Informática', 'Eletrônica', 'Matemática');

-- Mostre: Nome completo do autor, nome do livro, preço. Somente para livros com preço acima da média.

SELECT AU.NomeAutor + ' ' + AU.SobrenomeAutor 'Nome Completo', L.NomeLivro 'Nome do Livro', L.PrecoLivro Preço
FROM LivroAutor LA
	JOIN Livro L ON LA.IdLivro = L.IdLivro
	JOIN Autor AU ON  LA.IdAutor = AU.IdAutor
WHERE PrecoLivro > (
	SELECT AVG(PrecoLivro) FROM Livro
);

-- Mostre todas as editoras cadastradas, mesmo aquelas que não possuem livros. Exiba: Nome da editora, nome do livro, utilizando LEFT JOIN

SELECT E.NomeEditora 'Nome da Editora', L.NomeLivro 'Nome do Livro'
FROM Editora E
	LEFT JOIN Livro L 
	ON E.IdEditora = L.IdEditora

-- Mostre todos os livros e suas editoras. Exiba: Nome do livro, nome da editora, utilizando RIGHT JOIN

SELECT L.NomeLivro 'Nome do Livro', E.NomeEditora 'Nome da Editora'
FROM Editora E 
	RIGHT JOIN Livro L
	ON E.IdEditora = L.IdEditora
/* apenas erro de lógica do right, onde eu coloquei from livro righ editora, sendo que era como está agora*/

-- Mostre Nome da editora, nome do livro incluindo registros sem correspondência dos dois lados, utilizando FULL JOIN

SELECT NomeEditora 'Nome da Editora', NomeLivro 'Nome do Livro'
FROM Editora E
	FULL JOIN Livro L
	ON E.IdEditora = L.IdEditora

/* Monte uma consulta retornando: Nome do livro, nome completo do autor, nome da editora, preço.
Regras: preço acima da média dos livros, editora em (Aleph, Novatec, Microsoft Press, Record), sobrenome do autor contendo a letra a e
ordenar do mais caro para o mais barato.
*/

SELECT L.NomeLivro 'Nome do Livro', 
(SELECT PrecoLivro FROM Livro L WHERE PrecoLivro > (SELECT AVG(L.PrecoLivro) FROM Livro)) AS 'Preço do Livro', 
AU.NomeAutor + ' ' + AU.SobrenomeAutor [Nome Completo], E.NomeEditora 'Nome da Editora'
FROM LivroAutor LA
	JOIN Livro L ON LA.IdLivro = L.IdLivro
	JOIN Autor AU ON LA.IdAutor = AU.IdAutor
	JOIN Editora E ON L.IdEditora = E.IdEditora
	WHERE E.NomeEditora IN (
		SELECT E.NomeEditora
		FROM Editora
		WHERE E.NomeEditora IN ('Aleph', 'Novatec', 'Microsoft Press', 'Record')
		AND AU.SobrenomeAutor IN (
			SELECT AU.SobrenomeAutor
			FROM Autor
			WHERE AU.SobrenomeAutor LIKE '%a%')
		)
ORDER BY [Preço do Livro] DESC
/*eu consegui mostrar tudo com as cláusulas, porem hora que fui implantar a média de erro, mas sem implantar ela eu consegui fazer normalmente
(SELECT PrecoLivro FROM Livro L WHERE PrecoLivro > (SELECT AVG(L.PrecoLivro) FROM Livro)) AS 'Preço do Livro',
essa linha a cima foi implantada na tentativa de achar a média, mas antes mesmo com subconsultas desnecessárias aparecia tudo o que foi pedido
exceto a média, o exercício de forma correta consta abaixo
*/

SELECT L.NomeLivro AS [Nome do Livro],
    AU.NomeAutor + ' ' + AU.SobrenomeAutor AS [Nome Completo],
    E.NomeEditora AS [Nome da Editora],
    L.PrecoLivro AS [Preço do Livro]
FROM LivroAutor LA
    INNER JOIN Livro L
        ON LA.IdLivro = L.IdLivro
    INNER JOIN Autor AU
        ON LA.IdAutor = AU.IdAutor
    INNER JOIN Editora E
        ON L.IdEditora = E.IdEditora
WHERE L.PrecoLivro > (
        SELECT AVG(PrecoLivro)
        FROM Livro
)
AND E.NomeEditora IN ('Aleph', 'Novatec', 'Microsoft Press', 'Record')
AND AU.SobrenomeAutor LIKE '%a%'
ORDER BY L.PrecoLivro DESC;