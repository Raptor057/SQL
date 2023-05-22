--SELECT TOP (1000) * FROM [gtt].[dbo].[Gammas] WHERE PartNo IN(select DISTINCT(NOKTCODPF) from [MXSRVTRACA].[TRAZAB].[cegid].[bom] where NOKTCOMPF = 'LC')

--Esto muestra las lineas que existen en Gammas y en [MXSRVTRACA].[TRAZAB].[cegid].[bom] simultaneamente
-- SELECT TOP (1000) *
-- FROM [gtt].[dbo].[Gammas]
-- WHERE PartNo COLLATE SQL_Latin1_General_CP1_CI_AS IN (
--     SELECT DISTINCT NOKTCODPF COLLATE SQL_Latin1_General_CP1_CI_AS
--     FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom]
--     WHERE NOKTCOMPF = 'LC'
-- );

--Esto muestra los modelos que no existen en la tabla Gammas de la DB de GTT pero si en la tabla [cegid].[bom] de [MXSRVTRACA].[TRAZAB]
DECLARE @linecode VARCHAR(2),
@gtt INT,
@Trazab INT

set @linecode = 'LB'
set @gtt = (SELECT count(DISTINCT([PartNo])) FROM [gtt].[dbo].[LineGamma] where LineCode = @linecode)
set @Trazab = (select COUNT(DISTINCT(NOKTCODPF)) from [MXSRVTRACA].[TRAZAB].[cegid].[bom] where NOKTCOMPF = @linecode)
SELECT @gtt AS GTT, @Trazab AS Trazab

SELECT DISTINCT(NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS
FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom]
WHERE NOKTCOMPF = @linecode
    AND NOKTCODPF NOT IN (
        SELECT DISTINCT(PartNo) COLLATE SQL_Latin1_General_CP1_CI_AS
        FROM LineGamma 
        WHERE PartRev = @linecode And LineCode = @linecode
    );



--SELECT DISTINCT(PartNo) from Gammas WHERE PartRev = 'LC'



--select COUNT(Distinct(PartNo)) FROM LineGamma WHERE PartRev = 'LC' and LineCode = 'LC'
--select COUNT(DISTINCT(NOKTCODPF)) from [MXSRVTRACA].[TRAZAB].[cegid].[bom] where NOKTCOMPF = 'LB'

