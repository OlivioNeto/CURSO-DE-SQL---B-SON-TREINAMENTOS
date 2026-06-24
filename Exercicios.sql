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

