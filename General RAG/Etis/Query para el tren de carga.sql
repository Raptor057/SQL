--Consulta que servira como reporte o visualizacion de la tabla en la app de Wagon Load ¯\_(ツ)_/¯ 

SELECT
    LP.LineCode,
    LPS.PartNo,
    WL.ComponentNo,
    RTRIM(CB.NOCTCOMCPT) AS [Rev],
    RTRIM(CB.ARCTLIB01) AS [Descripcion],
    WL.UtcTimeStamp
    --,WL.InWagonLoaded 
FROM [gtt].[dbo].[WagonLoad] WL
JOIN [gtt].[dbo].[LinePointsOfUse] LP 
    ON LP.PointOfUseCode = WL.PointOfUseCode
JOIN [mxsrvtraca].[trazab].[cegid].[bom] CB
    ON CB.NOCTCODECP COLLATE SQL_Latin1_General_CP1_CI_AS = WL.ComponentNo COLLATE SQL_Latin1_General_CP1_CI_AS AND CB.NOCTCODOPE  COLLATE SQL_Latin1_General_CP1_CI_AS = WL.PointOfUseCode COLLATE SQL_Latin1_General_CP1_CI_AS
JOIN [gtt].[dbo].[LineProductionSchedule] LPS
ON CB.NOKTCODPF COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.PartNo COLLATE SQL_Latin1_General_CP1_CI_AS
WHERE LPS.UtcExpirationTime > GETUTCDATE() AND (WL.InWagonLoaded <> 1)
--AND WL.UtcTimeStamp >= CAST(CAST(GETUTCDATE() AS date) AS datetime)
Order BY WL.UtcTimeStamp ASC


--Esto sirve para el dia de hoy ponerlo en formato de hora 0
--SELECT CAST(CAST(GETUTCDATE() AS date) AS datetime)


-- --Procedimiento almacenado de actualizacion de datos de vagon
-- ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ 
-- DECLARE @GetID bigint
-- DECLARE @ComponentNo NVARCHAR(20)
-- SET @ComponentNo = '44463'
-- SET @GetID = (SELECT top 1
--     WL.ID
-- FROM [gtt].[dbo].[WagonLoad] WL
-- JOIN [gtt].[dbo].[LinePointsOfUse] LP 
--     ON LP.PointOfUseCode = WL.PointOfUseCode
-- JOIN [mxsrvtraca].[trazab].[cegid].[bom] CB
--     ON CB.NOCTCODECP COLLATE SQL_Latin1_General_CP1_CI_AS = WL.ComponentNo COLLATE SQL_Latin1_General_CP1_CI_AS AND CB.NOCTCODOPE  COLLATE SQL_Latin1_General_CP1_CI_AS = WL.PointOfUseCode COLLATE SQL_Latin1_General_CP1_CI_AS
-- JOIN [gtt].[dbo].[LineProductionSchedule] LPS
-- ON CB.NOKTCODPF COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.PartNo COLLATE SQL_Latin1_General_CP1_CI_AS
-- WHERE LPS.UtcExpirationTime > GETUTCDATE() AND WL.InWagonLoaded != 1 AND WL.ComponentNo = @ComponentNo
-- Order BY WL.UtcTimeStamp ASC)

-- UPDATE WagonLoad SET InWagonLoaded = 1 WHERE ID = @GetID
-- ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ ¯\_(ツ)_/¯ 


--Ejecutar el procedimiento
--EXECUTE [dbo].[WagonLoadUpdateStatus] '44463'

--Actualizar los statues
--UPDATE WagonLoad set InWagonLoaded = 0

--Esto sirve para borrar toda la tabla y dejar el contador en 0
-- delete WagonLoad
-- DBCC CHECKIDENT('WagonLoad', RESEED, 0);