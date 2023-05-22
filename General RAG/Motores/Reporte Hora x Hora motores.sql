-- SELECT TOP (1000) [ID]
--       ,[SerialNumber]
--       ,[Volt]
--       ,[RPM]
--       ,[DateTimeMotor]
--       ,[UtcDateTimeSerial]
--       ,[Line]
--   FROM [gtt].[dbo].[MotorsData]

--   delete MotorsData
-- DBCC CHECKIDENT('MotorsData', RESEED, 0);

-- SELECT 
--     DATEPART(HOUR, UtcDateTimeSerial) AS Hora,
--     COUNT(DISTINCT SerialNumber) AS Unidades
-- FROM [gtt].[dbo].[MotorsData]
-- GROUP BY DATEPART(HOUR, UtcDateTimeSerial)
-- ORDER BY Hora;


--Query con opcion de poner parametro de fecha.
SELECT 
    CONVERT(DATE, dbo.UfnToLocalTime(UtcDateTimeSerial)) AS Fecha,
    DATEPART(HOUR, dbo.UfnToLocalTime(UtcDateTimeSerial)) AS Hora,
    COUNT(DISTINCT SerialNumber) AS Unidades
    FROM [gtt].[dbo].[MotorsData]
    WHERE dbo.UfnToLocalTime(UtcDateTimeSerial) BETWEEN getdate()-10 and getdate()
    GROUP BY CONVERT(DATE, dbo.UfnToLocalTime(UtcDateTimeSerial)), DATEPART(HOUR, dbo.UfnToLocalTime(UtcDateTimeSerial))
    ORDER BY Fecha, Hora;

--Query de reporte Normal.
SELECT 
    CONVERT(DATE, dbo.UfnToLocalTime(UtcDateTimeSerial)) AS Fecha,
    DATEPART(HOUR, dbo.UfnToLocalTime(UtcDateTimeSerial)) AS Hora,
    COUNT(DISTINCT SerialNumber) AS Unidades
FROM [gtt].[dbo].[MotorsData]
WHERE CONVERT(date,UtcDateTimeSerial) = (SELECT CONVERT(date,GETDATE()))
GROUP BY CONVERT(DATE, dbo.UfnToLocalTime(UtcDateTimeSerial)), DATEPART(HOUR, dbo.UfnToLocalTime(UtcDateTimeSerial))
ORDER BY Fecha, Hora;

--Converte la fecha utc a formato de utclocal
--SELECT DISTINCT(dbo.UfnToLocalTime(GETUTCDATE())) AS Fecha

--Truncar horas de fecha actual a 00:00:00.000
--SELECT CAST(CONVERT(VARCHAR(10), GETDATE(), 101) AS DATETIME) AS Fecha

--select GETDATE()-10

-- SELECT DISTINCT(CONVERT(DATE, dbo.UfnToLocalTime(UtcDateTimeSerial))) AS Fecha
-- FROM [gtt].[dbo].[MotorsData]

-- SELECT DISTINCT(CONVERT(DATE, dbo.UfnToLocalTime(GETUTCDATE()))) AS Fecha


--select dbo.UfnToLocalTime(GETUTCDATE())

--Reporte
-- SELECT 
--     CONVERT(DATE, dbo.UfnToLocalTime(UtcDateTimeSerial)) AS Fecha,
--     DATEPART(HOUR, dbo.UfnToLocalTime(UtcDateTimeSerial)) AS Hora,
--     COUNT(DISTINCT SerialNumber) AS Unidades
-- FROM [gtt].[dbo].[MotorsData]
-- WHERE CONVERT(date,UtcDateTimeSerial) = (SELECT CONVERT(date,GETDATE()))
-- GROUP BY CONVERT(DATE, dbo.UfnToLocalTime(UtcDateTimeSerial)), DATEPART(HOUR, dbo.UfnToLocalTime(UtcDateTimeSerial))
-- ORDER BY Fecha, Hora;