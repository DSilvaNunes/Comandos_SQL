--https://www.youtube.com/watch?v=rX2I7OjLqWE
--pasta C:\Users\dougs\OneDrive\Documentos\SQL Server Management Studio

SELECT Name
FROM Production.Product
WHERE Weight >500 and Weight <700

SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus= 'M' and SalariedFlag = '1'

SELECT *
FROM Person.Person
WHERE LastName = 'krebs' and FirstName= 'peter'

SELECT *
FROM Person.EmailAddress	
WHERE BusinessEntityID = '26'
---------------------------------------------------------------------------------------------------------------------------------------
--COUNT RETONA O NUMERO DE LINHAS ATRAVES DE UMA CONDIÇÃO

SELECT COUNT(*)
FROM Person.Person

SELECT COUNT (*)
FROM Production.Product

SELECT COUNT(Size)
FROM Production.Product

---------------------------------------------------------------------------------------------------------------------------------------

--TOP FILTRA A QUANTIDADE DE DADOS QUE RETORNA DE SELECT

SELECT TOP 10*
FROM Production.Product

---------------------------------------------------------------------------------------------------------------------------------------


--ORDER BY PERMITE QUE VC ORDENE UMA COLUNA EM ORDEM CRESCENTE OU DESCRESCENTE

SELECT *
FROM Person.Person
ORDER BY FirstName desc

SELECT *
FROM Person.Person
ORDER BY FirstName asc

SELECT FirstName, LastName, MiddleName
FROM Person.Person
ORDER BY FirstName asc, LastName desc

SELECT TOP 10*
FROM Production.Product
ORDER BY ListPrice DESC

SELECT TOP 4 name, productNumber
FROM Production.Product
ORDER BY ProductID

---------------------------------------------------------------------------------------------------------------------------------------

--BETWEEN (ENTRE) É USADO PARA ENCONTRAR UM VALOR MINIMO AO MAXIMO

SELECT *
FROM Production.Product
WHERE ListPrice BETWEEN 1000 AND 1500;

SELECT *
FROM Production.Product
WHERE ListPrice NOT BETWEEN 1000 AND 1500; -- SE USAR O NOT BETWEEN ELE VAI EXCLUIR OS VALORES QUE ESTÃO ENTRE 1000 AND 1500

SELECT *
FROM HumanResources.Employee
WHERE HireDate BETWEEN '2009-01-01' AND '2010-01-01'--BETWEEN E NOT BETWEEN É USADO TAMBÉM COM DATAS NO FORMATO ANO/MES/DIA
ORDER BY HireDate

---------------------------------------------------------------------------------------------------------------------------------------

-- IN É USADO JUNTO COM O WHERE PARA VERIFICAR SE UM VALOR CORRESPONDE COM QUALQUER VALOR PASSADO NA LISTA DE VALORES

SELECT *
FROM Person.Person			
WHERE BusinessEntityID IN (2,7,13)

SELECT *
FROM Person.Person			
WHERE BusinessEntityID NOT IN (2,7,13) -- NOT IN SERVE PARA EXCLUIR OS VALORES SELECIONADOS

---------------------------------------------------------------------------------------------------------------------------------------

--LIKE (NÃO É CASE SENSITIVE - PODE SER MAIUSCULO E MINUSCULO) SERVE PARA ENCONTRAR ALGUM DADO BASEADO EM PARAMETRO QUE VC COLOCAR

SELECT *
FROM Person.Person
WHERE FirstName LIKE 'DOU%'--SINTAXE: WHERE + ''TABELA DE ONDE VAI PESQUISAR'' + LIKE + 'VALOR BUSCADO' + % 

SELECT *
FROM Person.Person
WHERE FirstName LIKE '%SON'--% PODE SER USADO NO INICIO OU NO FINAL

SELECT *
FROM Person.Person
WHERE FirstName LIKE '%ILL%'--% PODE SER USADO PARA BUSCAR NO INICIO E NO FIM

SELECT *
FROM Person.Person
WHERE FirstName LIKE '%RO_%'--% SE USAR O _(UNDERLINE) VAI SE LIMITAR AO CARACTERE SELECIONADO

---------------------------------------------------------------------------------------------------------------------------------------

--DESAFIO
-- 1 QNTOS PRODUTOS TEMOS CADASTRADOS NO SISTEMA QUE CUSTAM MAIS DE 1500 DOLARES?

SELECT COUNT(*) -- OU SELECT COUNT(ListPrice)
FROM Production.Product
WHERE ListPrice > 1500

--2 QNTAS PESSOAS TEMOS COM O SOBRENOME QUE INICIA COM A LETRA P ?

SELECT COUNT(*) -- OU SELECT COUNT(LastName)
FROM Person.Person
WHERE LastName LIKE 'P%'

--3 EM QNTAS CIDADES UNICAS ESTAO CADASTRADOS NOSSOS CLIENTES?

SELECT COUNT ( DISTINCT (CITY) ) -- DISTINCT Trata-se de uma cláusula para eliminar repetições em consultas
FROM Person.Address


-- 4 QUAIS SAO AS CIDADES UNICAS QUE TEMOS CADASTRADAS EM NOSSO SISTEMA EM ORDEM DECRESCENTE?

SELECT DISTINCT (CITY) 
FROM Person.Address
ORDER BY City DESC

--5 QNTOS PRODUTOS VERMELHOS TEM ENTRE O PREÇO DE 500 A 1000 DOLARES ?

SELECT COUNT (*)
FROM Production.Product
WHERE Color ='RED' AND ListPrice BETWEEN 500 AND 1000

--6 QNTOS PRODUTOS CADASTRADOS TEM A PALAVRA --ROAD-- NO NOME DELES (SEJA NO INICIO OU NO FIM) ?

SELECT COUNT(*)
FROM Production.Product
WHERE Name LIKE '%ROAD%'

---------------------------------------------------------------------------------------------------------------------------------------

--FUNCÇÕES DE AGREGAÇÃO COM COMBINACAO OU AGREGAM DADOS DE TABELAS - MIN MAX SUM AVG 

SELECT TOP 10 SUM(linetotal) AS "soma"
FROM Sales.SalesOrderDetail

---------------------------------------------------------------------------------------------------------------------------------------

--GROUP BY DIVIDE O RESULTADO DA PESQUISA EM GRUPOS
--PARA CADA GRUPO VOCE PODE APLICAR UMA FUNCAO DE AGREGACAO 

--SINTAXE SELECT coluna1, funcaoAgregacao (coluna2)
--FROM nomeTabela
--GRUPY BY coluna1

SELECT *
FROM Sales.SalesOrderDetail

SELECT SpecialOfferID, SUM (UnitPrice) as "SOMA"
FROM Sales.SalesOrderDetail
GROUP BY SpecialOfferID 

SELECT SpecialOfferID, UnitPrice
FROM Sales.SalesOrderDetail
WHERE SpecialOfferID =9 		

--EXEMPLO SE QUERO SABER DE QNTOS DE CADA PRODUTO FOI VENDIDO ATE HOJE USANDO O ORDER BY

SELECT * FROM Sales.SalesOrderDetail

SELECT ProductID, COUNT(ProductID) as "CONTAGEM"
FROM Sales.SalesOrderDetail
GROUP BY ProductID

--EXEMPLO QUERO SABER QNTOS NOMES DE CADA NOME TEMOS NO NOSSO BANCO DE DADOS

SELECT * FROM Person.Person

SELECT FirstName ,COUNT(FirstName) AS "CONTAGEM_NOME"
FROM Person.Person
GROUP BY FirstName

--NA TABELA Production.Product VERIFICAR A MEDIA DE PREÇO PARA PRODUTOS QUE SAO PRATA (SILVER)

SELECT * FROM Production.Product

SELECT COLOR,  AVG (LISTPRICE) "PREÇO"
FROM Production.Product
WHERE COLOR = 'SILVER'
GROUP BY Color

---------------------------------------------------------------------------------------------------------------------------------------

--DESAFIOS INTERMEDIARIOS 

--1 QNTAS PESSOAS TEM O MESMO MIDDLE NAME AGRUPADAS POR MIDDLE NAME
SELECT * FROM Person.Person

SELECT MiddleName ,COUNT(MiddleName) AS "CONTAGEM_MIDDLENAME"
FROM Person.Person
GROUP BY MiddleName

--2 VERIFICAR EM MEDIA A QNTE (QUANTITY) DE CADA PRODUTO É VENDIDO NA LOJA

SELECT * FROM Sales.SalesOrderDetail

SELECT ProductID , AVG (OrderQty) AS "MEDIA"
FROM Sales.SalesOrderDetail
GROUP BY ProductID

--3 VERIFICAR AS 10 VENDAS QUE TIVERAM	OS MAIORES VALORES DE VENDAS (LINETOTAL)	POR PRODUTO  DO MAIOR VALOR PARA O MENOR

SELECT * FROM Sales.SalesOrderDetail

SELECT TOP 10 ProductID, SUM(linetotal) AS "QUANTIDADE_VENDAS"
FROM Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY SUM(linetotal) DESC

--4 QNTOS PRODUTOS E QUAL A QNTE MEDIA DE PRODUTOS TEMOS CADASTRADOS NAS NOSSAS ORDEM DE SERVIÇO (WORK ORDER), AGRUPADAS POR PRODUCTID

SELECT  ProductID, COUNT(ProductID) "CONTAGEM",
AVG (OrderQty) as "MEDIA"
FROM Production.WorkOrder
GROUP BY ProductID

---------------------------------------------------------------------------------------------------------------------------------------
/*
HAVING É USADO  EM JUNÇÃO COM O GROUP BY PARA FILTRAR RESULTADOS DE UM AGRUPAMENTO -- USAR O HAVING DEPOIS DO GROUP BY
SERIA TIPO UM "WHERE" PARA AGRUPAR DADOS - DIFERENÇA ENTRE WHERE E HAVING: GROUP BY É APLICADO __DEPOIS__ QUE OS DADOS FORAM AGRUPADOS,
ENQUANTO O WHERE É APLICADO ANTES DOS DADOS SEREM AGRUPADOS.

SINTAXE -- SELECT coluna1, FuncaoAgregacao(coluna2)
FROM nomeTabela
GROUP BY coluna1
HAVING condicao;
*/

--QUAIS NOMES NO SISTEMA TEM OCORRENCIA MAIOR QUE 10 VEZES

SELECT FirstName, COUNT(FirstName) as "Quantidade"
FROM person.person
GROUP BY FirstName
HAVING COUNT (FirstName)>10;

--QUAIS OS PRODUTOS QUE NO TOTAL DE VENDAS ESTAO ENTRE 162K E 500K

SELECT TOP 10 *
FROM Sales.SalesOrderDetail

SELECT ProductID, SUM (LineTotal) as "total"
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM (LineTotal) BETWEEN 162000 and 500000

--VERIFICAR QUAIS NOMES NO SISTEMA TEM OCORRENCIA MAIOR QUE 10 VEZES SOMENTE ONDE O TITULO É "MR"

SELECT FirstName, COUNT(FirstName) as "Quantidade"
FROM Person.Person
WHERE Title = 'mr.'
GROUP BY FirstName
HAVING COUNT (FirstName)>10;

--VERIFICAR A QUANTIDADE DE PROVINCIOAS (stateProvinceID) com cadastro maior que 1000 vezes 
SELECT *
FROM Person.Address

SELECT StateProvinceID, count (StateProvinceID) AS  "QUANTIDADE"
FROM Person.Address
GROUP BY StateProvinceID
HAVING COUNT (StateProvinceID) > 1000

--VERIFICAR QUAIS PRODUTOS (PRODUCTID) NÃO TEM MEDIA DE NO MINIMO 1 MILHAO DE TOTAL DE VENDAS (LINETOTAL)

SELECT *
FROM Sales.SalesOrderDetail

SELECT ProductID , AVG(LineTotal) AS "QUANTIDADE"
FROM Sales.SalesOrderDetail
GROUP BY (ProductID)
HAVING AVG(LineTotal) <1000000

--------------------------------------------------------------------------------------------------------------------------------------
/*
FUNCAO "AS" SERVE PARA RENOMEAR AS TABELAS,COLUNAS, AGREGACAO OU SELECT
*/
SELECT TOP  10*
FROM Production.Product

SELECT TOP  10 ListPrice AS "LISTA DE PRECO" -- RENOMEOU O LISTPRICE PARA LISTA DE PREÇO
FROM Production.Product 

SELECT TOP  10 avg (ListPrice) AS "PRECO MEDIO" -- RENOMEOU O LISTPRICE PARA PREÇO MEDIO
FROM Production.Product 

--DESAFIO 1 - RENOMEAR AS COLUNAS FISTNAME E LASTNAME DA TABELA DA PERSON.PERSON PARA O PORTUGUES

SELECT*
FROM Person.Person

SELECT FIRSTNAME AS "PRIMEIRO NOME"
FROM Person.Person

SELECT LastName AS "ULTIMO NOME"
FROM Person.Person

SELECT FIRSTNAME AS "PRIMEIRO NOME", LastName AS "ULTIMO NOME"
FROM Person.Person

--DESAFIO 2 - MUDAR O PRODUCTNUMBER DA TABELA PRODUCT.PRODUCT PARA "NUMERO DO PRODUTO"

SELECT PRODUCTNUMBER AS "NUMERO DO PRODUTO"
FROM Production.Product

--DESAFIO 3 MUDAR O NOME DE UNITPRICE PARA "PREÇO UNITARIO" DA TABELA SALES.SALESORDERDETAIL

SELECT unitPrice as "PREÇO UNICO"
FROM Sales.SalesOrderDetail

----------------------------------------------------------------------------------------------------------------------------------------
/*
3 PRINCIPAIS TIPOS DE JOIN

INNER JOIN, OUTER JOIN, SELF-JOIN

CLIENTE               ENDERECO
CLIENTEID             ENDERECOID   
NOME                  RUA
ENDERECOID            CIDADE

SELECT C.CLIENTEID, C.NOME, E.RUA, E.CIDADE
FROM CLIENTE C
INNER JOIN ENDERECO E ON E.ENDERECOID = C.ENDERECOID
--RESULTADO EXEMPLO:  BRUNO | RUA NORTE | SAO PAULO |
*/

--VERIFICAR AS INFORMACOES DE BUSINESSENTITYID, FIRSTNAME, EMAILADRESS

SELECT*
FROM Person.Person

SELECT*
FROM Person.EmailAddress

SELECT P.BusinessEntityID, P.FirstName, P.LastName, PE.EmailAddress -- P e PE foram usados para dar nome, pois existiam colunas em nome iguais
FROM Person.Person AS P
INNER JOIN PERSON.EmailAddress PE ON P.BusinessEntityID = PE.BusinessEntityID 
                               -- ON P.BusinessEntityID = PE.BusinessEntityID junta as infos das tabelas em comum

--JUNTAR O NOME DOS PRODUTOS E AS INFOS DAS SUAS SUBCATEGORIAS (LISTPRICE(PRECO), (NAME) NOME DO PRODUTO, NOME SUBCATEGORIA (ProductSubcategory)

SELECT TOP 10*
FROM Production.Product

SELECT TOP 10*
FROM Production.ProductSubcategory

SELECT PR.LISTPRICE, PR.NAME ,                     PC.Name 
--ESTAO SAINDO DA TABELA Production.Product PR     --PC.NAME ESTA SAINDO DA Production.ProductSubcategory - NO COMANDO JOIN
FROM Production.Product PR
INNER JOIN Production.ProductSubcategory PC ON PC.ProductSubcategoryID = PR.ProductSubcategoryID
--TABELA EM COMUM ENTRE AS DUAS "ProductSubcategory" - DAÍ QUE A JOIN É FEITA

--JUNTAR AS TABELAS SEM FILTRO - "PRODUTO CARTESIANO"

SELECT TOP 10*
FROM PERSON.BusinessEntityAddress

SELECT TOP 10*
FROM Person.Address

SELECT TOP 10*
FROM Person.BusinessEntityAddress BA
INNER JOIN Person.Address PA ON PA.AddressID = BA.AddressID
                                --A TABELA EM COMUM É AddressID
								
--DESAFIO - JUNTAR BUSINESSENTITYID, NAME, PHONENUMBERTYPEID, PHONENUMBER
SELECT TOP 10*
FROM Person.PhoneNumberType

SELECT TOP 10*
FROM PERSON.PersonPhone

SELECT PP.BusinessEntityID, PT.Name, PP.PhoneNumberTypeID, PP.PhoneNumber
FROM Person.PersonPhone PP
INNER JOIN Person.PhoneNumberType PT ON PT.PhoneNumberTypeID = PP.PhoneNumberTypeID
                                        --PhoneNumberTypeID TABELAS EM COMUM

--DESAFIO - MOSTRAR O AdressID, City, StateProvinceID, Name(Nome do estado)

SELECT TOP 10*
FROM Person.StateProvince

SELECT TOP 10*
FROM Person.Address

SELECT TOP 10 Tab2.AddressID, Tab2.City, Tab1.StateProvinceID, Tab1.Name
FROM Person.Address TAB2
INNER JOIN Person.StateProvince TAB1 ON TAB2.StateProvinceID = TAB1.StateProvinceID

/*FULL OUTER JOIN RETORNA TODOS OS REGISTROS DAS DUAS TABELAS QNDO SAO IGUAIS - OS QUE NAO FOREM ELE COLOCA NULL
SINTAXE   SELECT*FROM TABELA_A
          FULL OUTER JOIN TABELA_B
		  ON TABELA_A.(EX.NOME) = TABELA_B.(EX.NOME)

LEFT(RIGHT) OUTER JOIN - RETORNA TODOS OS DADOS CORRESPONDENTES DA TABELA DA ESQUERDA(LEFT) OU DIREITA(RIGHT) -OS QUE NAO FOREM COLOCA NULL
SINTAXE   SELECT*FROM TABELA_A
          LEFT(RIGHT) JOIN TABELA_B
		  ON TABELA_A.(EX.NOME) = TABELA_B.(EX.NOME)
*/

--VERIFICAR QUAIS PESSOAS TEM CARTAO DE CREDITO REGISTRADO 
SELECT*
FROM Person.Person PP
LEFT JOIN Sales.PersonCreditCard PC
ON PP.BusinessEntityID = PC.BusinessEntityID -- ATE AQUI VERIFICA TODAS QUE TEM CARTAO + AS NULL (QUE N TEM)
WHERE PC.BusinessEntityID IS NULL -- ESSE COMANDO VERIFICA TODAS QUE NAO TEM CARTAO (NULL)

----------------------------------------------------------------------------------------------------------------------------------------
/* UNION:
AJUDA COMBINAR DOIS OU MAIS RESULTADOS DE SELECT EM UM RESULTADO APENAS (E AINDA REMOVE AS DUPLICADAS A NAO SER QUE USE O UNION ALL)

SINTAXE  SELECT COLUNA1, COLUNA2
         FROM TABELA1
		 UNION
		 SELECT COLUNA1, COLUNA2
		 FROM TABELA2
*/

SELECT ProductID,Name, ProductNumber
FROM Production.Product
WHERE Name LIKE '%CHAIN%'
UNION
SELECT ProductID,Name, ProductNumber
FROM Production.Product
WHERE Name LIKE '%DECAL%'
ORDER BY Name DESC -- AQUI ORDENARIA POR NOME EM ORDEM DECRESCENTE


SELECT FirstName, Title, MiddleName
FROM Person.Person
WHERE Title = 'MR.'
UNION
SELECT FirstName, Title, MiddleName
FROM Person.Person
WHERE MiddleName = 'A'

----------------------------------------------------------------------------------------------------------------------------------------
--DATEPART https://docs.microsoft.com/pt-br/sql/t-sql/functions/datepart-transact-sql?view=sql-server-ver16

SELECT *
FROM Sales.SalesOrderHeader

SELECT SalesOrderID, DATEPART(MONTH, OrderDate) AS 'MES'
FROM Sales.SalesOrderHeader

SELECT AVG(TotalDue) AS MEDIA, DATEPART(MONTH, OrderDate) AS MES
FROM SALES.SalesOrderHeader
GROUP BY  DATEPART(MONTH, OrderDate)
ORDER BY MES

--------------------------------------------------------------------------------------------------------------------------------------
/* MANIPULACAO DE STRING - https://docs.microsoft.com/pt-br/sql/t-sql/functions/string-functions-transact-sql?view=sql-server-ver16
*/
SELECT CONCAT(FirstName,'    ' ,LastName) -- É POSSIVEL FAZER CONCATENAR, umas das funções de texto, para unir duas ou mais cadeias de texto em uma única cadeia
FROM Person.Person

SELECT UPPER(FirstName), LOWER (LastName)
FROM Person.Person


SELECT FirstName, LEN (FirstName) AS 'QNTE DE CARACTERES' -- LEN CONTA A QNTE DE CARACTERES
FROM Person.Person

SELECT FirstName, SUBSTRING (FirstName, 1, 3) -- SUBSTRING	SERVE PARA EXTRAIR UM "PEDAÇO" E INFORMACOES DE UMA STRING
FROM Person.Person

SELECT *
FROM Production.Product

SELECT ProductNumber, REPLACE (ProductNumber,'-', '#') -- REPLACE SUSTITUI DADOS
                    --SUBSTITUI(COLUNA,OQ VAI MUDAR, MODIFICADO)
FROM Production.Product

--EXEMPLO CONCAT
SELECT CONCAT(CardType,'    ' ,CardNumber)
FROM Sales.CreditCard

--EXEMPLO LEN

SELECT Name, LEN (Name) AS 'QNTE DE CARACTERES' -- LEN CONTA A QNTE DE CARACTERES
FROM Purchasing.Vendor

--EXEMPLO LOWER E UPPER

SELECT UPPER(FirstName), LOWER (LastName), UPPER (MiddleName), LOWER (Title), UPPER (PersonType)
FROM Person.Person

--EXEMPLO SUBSTRING

SELECT Name, SUBSTRING (Name, 1, 4) as 'nome abreviado'
FROM Person.StateProvince

--EXEMPLO DE REPLACE

SELECT EmailAddress, REPLACE (EmailAddress,'@', '#') as 'sai @ entra #'-- REPLACE SUSTITUI DADOS
                    --SUBSTITUI(COLUNA,OQ VAI MUDAR, MODIFICADO)
FROM Person.EmailAddress

-----------------------------------------------------------------------------------------------------------------------------

--FUNCOES MATEMATICAS +, -, /, *, AVG(MEDIA) , SUM(SOMA), MIN(VAL MAXIMO), MAX(VALOR MINIMO)-- 
--https://docs.microsoft.com/pt-br/sql/t-sql/functions/mathematical-functions-transact-sql?view=sql-server-ver16

SELECT UnitPrice - LineTotal as 'resultado' --(+,-,/-*)
FROM sales.SalesOrderDetail

SELECT AVG (UnitPrice)  as 'resultado' --(SUM(SOMA), MIN(VAL MAXIMO), MAX(VALOR MINIMO))
FROM sales.SalesOrderDetail

SELECT LineTotal,  ROUND (LineTotal, 2) as 'VALOR ARREDONDADO' -- ROUND ARREDONDAMENTO(COLUNA, PRECISAO DECIMAL)
FROM Sales.SalesOrderDetail

SELECT LineTotal,  SQRT (LineTotal) as 'RAIZ QUADRADA' -- SQRT RAIZ QUADRADA
FROM Sales.SalesOrderDetail

----------------------------------------------------------------------------------------------------------------------------

--SUBQUERY (SUBSELECT) - SELECT DENTRO DE OUTRO SELECT

--EX.: MONTAR RELATORIO COM TODOS OS PRODUTOS CADASTRADOS QUE TEM PREÇO DE VENDA ACIMA DA MEDIA

--jeito "complicado"
SELECT AVG (ListPrice)
FROM Production.Product
SELECT *
FROM  Production.Product
WHERE ListPrice > 438.6662

--jeito simplificado
SELECT *
FROM Production.Product
WHERE ListPrice > (SELECT AVG (ListPrice) FROM Production.Product)

--EX.: NOME DOS FUNCIONARIOS COM CARGO DE "DESIGN ENGINEER" -- COLUNA EM COMUM: BusinessEntityID

--jeito nao recomendado - pq (5,6,15) sao variaveis pq podem nao ser fixas
SELECT *
FROM Person.Person
WHERE BusinessEntityID in (5,6,15)
SELECT *
FROM HumanResources.Employee
WHERE JobTitle = 'DESIGN ENGINEER'

--recomendado 1
SELECT FirstName
FROM Person.Person
WHERE BusinessEntityID IN (
SELECT BusinessEntityID FROM HumanResources.Employee
WHERE JobTitle = 'DESIGN ENGINEER')

--recomendado 2
SELECT P.FirstName
FROM Person.Person P
INNER JOIN HumanResources.Employee E ON P.BusinessEntityID = E.BusinessEntityID
AND JobTitle = 'DESIGN ENGINEER'

--DESAFIO - ENCONTRAR TODOS OS ENDEREÇOS DO ESTADO DE 'ALBERTA' - PODE TRAZER TODAS AS INFORMACOES

SELECT*
FROM Person.Address
SELECT*
FROM Person.StateProvince
--ACHAR A COLUNA EM COMUM: StateProvinceID

SELECT *
FROM Person.Address
WHERE StateProvinceID IN (
SELECT StateProvinceID FROM Person.StateProvince
WHERE Name = 'ALBERTA'
)
-----------------------------------------------------------------------------------------------------------------------------
--SELF JOIN
--AGRUPA (FILTRA) DADOS DENTRO DE UMA MESMA TABELA - TEM Q USAR O ''AS''
-- USAR ESSE BANCO DE DADOS: https://raw.githubusercontent.com/Microsoft/sql-server-samples/master/samples/databases/northwind-pubs/instnwnd.sql

















































 





























 








 









