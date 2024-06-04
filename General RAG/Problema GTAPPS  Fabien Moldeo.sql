DECLARE @Eti AS VARCHAR (20)
DECLARE @Tolva as INT
DECLARE @np AS VARCHAR (20)

DECLARE @ProdLine AS VARCHAR (20)
DECLARE @ProdRevCC AS VARCHAR (20)
DECLARE @ProdRev AS VARCHAR (20)

DECLARE @Orden AS VARCHAR (20)

--NO OK
-- set @Orden = '08490304' --No OK
-- SET @Tolva = 14 --No OK
-- SET @np = 'I36389'
-- set @ProdLine = '1C'

--OK
set @Orden = '08549201' 
SET @Tolva = 4
SET @np = '35270'
set @ProdLine = '1A' --ProdLine / ProdRevCC


--DATOS DE ORDEN APPS
EXECUTE MXSRVTRACA.APPS.[dbo].[sp_pro_GetOrderDetails] @Orden,''



--Busca el bom en cegid 
SELECT * FROM MXSRVCEGID.PMI.dbo.NOMENC 
WHERE NOKTSOC='300'
AND NOKTCODPF= @np
--AND NOCTCOMCPT = @ProdLine
AND NOKTCOMPF = @ProdLine
AND NOKNLIGNOM=10


--Info de la prensa
SELECT * FROM MXSRVCEGID.PMI.dbo.z_memoireplc_api WHERE tremie = @Tolva


SET @Eti = (SELECT top 1 CODE_ETI FROM MXSRVCEGID.PMI.dbo.z_memoireplc_api WHERE tremie = @Tolva)
SET @Eti = REPLACE(@Eti, 'E', '');

--Info de etiquetas APPS proetis001
SELECT TOP (1000) * FROM [MXSRVTRACA].[APPS].[dbo].[pro_eti001] 
WHERE id  = @Eti

