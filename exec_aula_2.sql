CREATE DATABASE exec_aula_2
USE exec_aula_2
-- 1) Fazer em SQL Server os seguintes algoritmos:
--a) Fazer um algoritmo que leia 1 número e mostre se são múltiplos de 2,3,5 ou nenhum deles
	DECLARE @A	INT
	SET @A = 10
	IF (@A %2 = 0)
		BEGIN
			PRINT CONCAT(@A,' é multiplo de 2')		
		END
	IF (@A % 3 = 0)
		BEGIN
			PRINT CONCAT(@A,' é multiplo de 3')		
		END
	IF (@A % 5 = 0)
		BEGIN
			PRINT CONCAT(@A,' é multiplo de 5')
		END
	IF (@A %2 != 0 AND @A %3 != 0 AND @A %5 != 0 )
		BEGIN
			PRINT CONCAT(@A,' não é multiplo de 2,3 e 5')
	END
			
--b) Fazer um algoritmo que leia 3 números e mostre o maior e o menor
CREATE TABLE valor (
	num	INT		NOT NULL
)
INSERT INTO valor
VALUES (13),(3),(4)
SELECT MAX(v.num) as maior, MIN (v.num) as menor
FROM valor v
--c) Fazer um algoritmo que calcule os 15 primeiros termos da série
--1,1,2,3,5,8,13,21,...
--E calcule a soma dos 15 termos
DECLARE @P1 INT,
		@P2 INT,
		@C INT
SET @P1 = 1
SET @P2 = 1
SET @C = 1
WHILE (@C < 10)
BEGIN
	PRINT @P1
	PRINT @P2
	SET @P1 = @P1 + @P2
	SET @P2 = @P1 + @P2
	SET @C = @C + 1
END
--d) Fazer um algoritmo que separa uma frase, colocando todas as letras em maiúsculo e em
--minúsculo (Usar funções UPPER e LOWER)
DECLARE @palavra VARCHAR(50),
		@tam	 INT,
		@letra	 VARCHAR(50),
		@cont	 INT

SET @palavra = 'Damasco'
SET @tam  = LEN(@palavra)
SET @cont = 1
WHILE (@cont < @tam+1)
BEGIN
	IF (@cont % 2 != 0) 
	BEGIN
		SET @letra = CONCAT(@letra,UPPER(SUBSTRING(@palavra,@cont,1)))
	END
	ELSE
	BEGIN
		SET @letra = CONCAT(@letra,LOWER(SUBSTRING(@palavra,@cont,1)))
	END
	SET @cont = @cont + 1
END
PRINT @letra
--e) Fazer um algoritmo que inverta uma palavra (Usar a função SUBSTRING)
DECLARE @p VARCHAR(50),
		@t	 INT,
		@let	 VARCHAR(50),
		@con	 INT

SET @p = 'Damasco'
SET @t  = LEN(@p)
SET @con = 1
WHILE (@con < @t+1)
BEGIN

	SET @let = CONCAT(@let,SUBSTRING(@p,@t-@con+1,1))
	SET @con = @con + 1
END
PRINT @let

--f) Considerando a tabela abaixo, gere uma massa de dados, com 100 registros, para fins de teste
--com as regras estabelecidas (Não usar constraints na criação da tabela)
--• ID incremental a iniciar de 10001
--• Marca segue o padrão simples, Marca 1, Marca 2, Marca 3, etc.
--• QtdRAM é um número aleatório* dentre os valores permitidos (2, 4, 8, 16)
--• TipoHD segue o padrão:
---o Se o ID dividido por 3 der resto 0, é HDD
---o Se o ID dividido por 3 der resto 1, é SSD
---o Se o ID dividido por 3 der resto 2, é M2 NVME
--• QtdHD segue o padrão:
---o Se o TipoHD for HDD, um valor aleatório* dentre os valores permitidos (500, 1000 ou 2000)
---o Se o TipoHD for SSD, um valor aleatório* dentre os valores permitidos (128, 256, 512)
--• FreqHD é um número aleatório* entre 1.70 e 3.

CREATE TABLE computador (
ID			INT				NOT NULL,
Marca		VARCHAR(40)		NOT NULL,
QtdRAM		INT				NOT NULL,
TipoHD		VARCHAR(10)		NOT NULL,
QtdHD		INT				NOT NULL,
FreqCPU		DECIMAL(7,2)	NOT NULL
PRIMARY KEY (ID)
)

DECLARE @id			INT, 
		@Marca		VARCHAR(40),
		@QtdRAM		INT,
		@TipoHD		VARCHAR(10),
		@QtdHD		INT,
		@FreqCPU	DECIMAL(7,2)

SET @id = 10001
SET @Marca = 'Marca'

WHILE (@id < 10101)
BEGIN
	SET @Marca = 'Marca'
	SET @Marca = CONCAT(@Marca,' ',@id-10000)

	SET	@QtdRAM = CASE CAST((RAND() *4+1) AS INT)
		WHEN 1 THEN 2
		WHEN 2 THEN 4
		WHEN 3 THEN 8
		ELSE 16
	END

	SET @TipoHD = CASE
		WHEN @id % 3 = 0 THEN 'HDD'
		WHEN @id % 3 = 1 THEN 'SSD'
		ELSE 'M2 NVME'
	END

	SET @QtdHD = CASE @TipoHD
		WHEN 'HDD' THEN 
			CASE CAST((RAND() *3+1) AS INT)
				WHEN 1 THEN 500
				WHEN 2 THEN 1000
				ELSE 2000
			END
		WHEN 'SSD' THEN
			CASE CAST((RAND() *3+1) AS INT)
				WHEN 1 THEN 128
				WHEN 2 THEN 256
				ELSE 512
			END
		ELSE 0
	END

	SET @FreqCPU = (RAND()*1.5+1.7)

	INSERT INTO computador VALUES
	(@id, @Marca, @QtdRAM,@TipoHD, @QtdHD,@FreqCPU)
	SET @id = @id +1
END

SELECT * FROM computador
DROP TABLE computador