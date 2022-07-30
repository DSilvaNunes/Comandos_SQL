CREATE TABLE TABELA_PRODUTO
(
Codigo_Produto int primary key,
Descricao varchar(200) NOT NULL,
NomeImportado_ou_Nacional varchar(200 ) NOT NULL,
ValorReal int NOT NULL,
ValorDolar int NOT NULL,
AnoFabricacao INT NOT NULL
);

DROP TABLE TABELA_PRODUTO;

SELECT * FROM TABELA_PRODUTO;

INSERT INTO TABELA_PRODUTO (Codigo_Produto, Descricao, NomeImportado_ou_Nacional, ValorReal, ValorDolar,AnoFabricacao)
VALUES (1,'Videogame', 'PS5', 5000, 900, 2020),
       (2,'Videogame', 'Xbox', 4500, 850, 2019),
	   (3,'Videogame', 'Nintendo', 3500, 750, 2018),
	   (4,'Videogame', 'Saturn', 300, 50, 2000),
	   (5,'Videogame', 'Dynavision', 200, 40, 1997) 

	   UPDATE TABELA_PRODUTO
	   SET Descricao = 'MICROSOFT'
	   WHERE Codigo_Produto = 2


	   UPDATE TABELA_PRODUTO
	   SET ValorReal = 10/10 * ValorReal + ValorReal
	   WHERE ValorReal =(select min (valorreal) from tabela_produto)

	   DELETE FROM TABELA_PRODUTO WHERE Codigo_Produto = 4


CREATE TABLE TABELA_PRODUTO_BACKUP
(
Codigo_Produto int primary key,
Descricao varchar(200) NOT NULL,
NomeImportado_ou_Nacional varchar(200 ) NOT NULL,
ValorReal int NOT NULL,
ValorDolar int NOT NULL,
AnoFabricacao INT NOT NULL
);

SELECT * FROM TABELA_PRODUTO_BACKUP

INSERT INTO TABELA_PRODUTO_BACKUP (Codigo_Produto, Descricao, NomeImportado_ou_Nacional, ValorReal, ValorDolar,AnoFabricacao)
SELECT Codigo_Produto, Descricao, NomeImportado_ou_Nacional, ValorReal, ValorDolar,AnoFabricacao
FROM TABELA_PRODUTO
WHERE Codigo_Produto = 1

UPDATE TABELA_PRODUTO_BACKUP SET Descricao = 'PLAYSTATION5'
WHERE Codigo_Produto = 1








