--Create FUNCTION [dbo].[UfnGenerateRandomPassword] 
(
-- =============================================
--Function To generate random character strings
--https://sql-listo.com/t-sql/funciones-por-rango-para-fechas-numeros-y-cadenas/
-- Author:		Rogelio Arriaga
-- Create date: February 27, 2023
-- Description:	This Function was created to generate random passwords 
--for a future function of adding Supervisor or changing password.
-- Parameters:
--   @size  - Size of Password.
--   @op     C - Characters / N --Numbers / CH --Both (Letters and Numbers
-- Returns:  Generated random password of the specified size and with the specified options
--If you do not enter an option, a default password will be sent, which will be RO042916
-- Change History:
--   27/02/23 RA:	Function created.
-- =============================================

@size AS INT, --Tamaño de la cadena aleatoria
@op AS VARCHAR(2) --Opción C,N,CN
)
RETURNS VARCHAR(62)
AS
BEGIN

DECLARE @chars AS VARCHAR(52),
@numbers AS VARCHAR(10),
@strChars AS VARCHAR(62), 
@strPass AS VARCHAR(62),
@index AS INT,
@cont AS INT

SET @strPass = ''
SET @strChars = '' 
SET @chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
SET @numbers = '0123456789'

SET @strChars = CASE @op WHEN 'C' THEN @chars --Characters
WHEN 'N' THEN @numbers --Numbers
WHEN 'CN' THEN @chars + @numbers --(Characters y Numbers)
ELSE 'RO042916'
END

SET @cont = 0
WHILE @cont < @size
BEGIN
SET @index = ceiling( ( SELECT rnd FROM dbo.vwRandom ) * (len(@strChars)))--Uso de la vista para el Rand() y no generar error.
SET @strPass = @strPass + substring(@strChars, @index, 1)
SET @cont = @cont + 1
END 

RETURN @strPass

END
