/*
Aqui solo hay que poner la linea ejemplo: LE y en automatico va a tomar el numero de orden activo en esa linea
se agrega en la variable @linecode
*/

declare @codew nvarchar (50),
@lineCode NVARCHAR (4)
SET @lineCode = 'LA' --<==== aqui cambiar la linea
SET @codew = (select codew AS [Numero de Orden]from [mxsrvtraca].[apps].[dbo].[pro_prod_units] WHERE comments LIKE (CONCAT('%',@lineCode,'%'))) -- aqui va el numero de orden de lo que se esta corriendo
--SET @codew = 'W07817236' -- aqui va el numero de orden de lo que se esta corriendo
--select (@codew + ' ' + @lineCode)
--select comments AS [LINEA], modelo AS [Modelo],codew AS [Numero de Orden]from mxsrvtraca.apps.dbo.pro_prod_units
--select codew AS [Numero de Orden]from mxsrvtraca.apps.dbo.pro_prod_units WHERE comments LIKE (@lineCode)
select * from [MXSRVTRACA].[APPS].[dbo].[pro_production]  where codew = @codew 
UPDATE pro_production SET dblid = 2 WHERE codew = @codew
