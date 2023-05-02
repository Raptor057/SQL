declare @date1 DATETIME,
@date2 DATETIME,
@message varchar(50),
@lineCode varchar (2)

set @date1 = (GETDATE()-1)
set @date2 = (GETDATE()+1)
-- set @message = 'se encuentra en uso en el túnel'
-- set @message = 'no se encuentra cargada'
-- set @message = 'no corresponde con ningún punto de uso para la gama'
set @message = null
--set @lineCode = ''
-- SELECT
--     CONVERT(DATE, [dbo].[UfnToLocalTime]([UtcTimeStamp])) AS [Fecha]
--     ,FORMAT(CONVERT(DATETIME, [dbo].[UfnToLocalTime]([UtcTimeStamp])), 'hh:mm tt') AS [Hora]
--     ,[ClientMessage] AS [Mensaje de Api]
--     ,UPPER([LineCode]) AS [Linea]
-- FROM [gtt].[dbo].[EventsHistory]
-- WHERE [UtcTimeStamp] BETWEEN @date1 AND @date2

-- SELECT
--     CONVERT(DATE, [dbo].[UfnToLocalTime]([UtcTimeStamp])) AS [Fecha]
--     ,FORMAT(CONVERT(DATETIME, [dbo].[UfnToLocalTime]([UtcTimeStamp])), 'hh:mm tt') AS [Hora]
--     ,[ClientMessage] AS [Mensaje de Api]
--     ,UPPER([LineCode]) AS [Linea]
-- FROM [gtt].[dbo].[EventsHistory] WHERE ClientMessage LIKE ('%se encuentra en uso en el túnel%') and [UtcTimeStamp] BETWEEN @date1 AND @date2

-- SELECT
--     CONVERT(DATE, [dbo].[UfnToLocalTime]([UtcTimeStamp])) AS [Fecha]
--     ,FORMAT(CONVERT(DATETIME, [dbo].[UfnToLocalTime]([UtcTimeStamp])), 'hh:mm tt') AS [Hora]
--     ,[ClientMessage] AS [Mensaje de Api]
--     ,UPPER([LineCode]) AS [Linea]
-- FROM [gtt].[dbo].[EventsHistory] WHERE ClientMessage LIKE ('%no se encuentra cargada%') and [UtcTimeStamp] BETWEEN @date1 AND @date2

-- SELECT
--     CONVERT(DATE, [dbo].[UfnToLocalTime]([UtcTimeStamp])) AS [Fecha]
--     ,FORMAT(CONVERT(DATETIME, [dbo].[UfnToLocalTime]([UtcTimeStamp])), 'hh:mm tt') AS [Hora]
--     ,[ClientMessage] AS [Mensaje de Api]
--     ,UPPER([LineCode]) AS [Linea]
-- FROM [gtt].[dbo].[EventsHistory] WHERE ClientMessage LIKE (CONCAT('%',@message,'%')) and [UtcTimeStamp] BETWEEN @date1 AND @date2

-- SELECT
--     UPPER([LineCode]) AS [Linea]
--     ,COUNT(*) AS [Cantidad de Mensajes]
-- FROM [gtt].[dbo].[EventsHistory]
-- WHERE ClientMessage LIKE (CONCAT('%',@message,'%')) and [UtcTimeStamp] BETWEEN @date1 AND @date2
-- GROUP BY UPPER([LineCode])

-- SELECT 
--     LEFT(SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage)), 
--          CHARINDEX(' ', SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage))) - 1) AS ETI
-- FROM [gtt].[dbo].[EventsHistory]
-- WHERE ClientMessage LIKE (CONCAT('%',@message,'%')) AND [UtcTimeStamp] BETWEEN @date1 AND @date2
-- GROUP BY LEFT(SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage)), 
--               CHARINDEX(' ', SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage))) - 1)

--               SELECT 
--     CONCAT('E', LEFT(SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage)), 
--          CHARINDEX(' ', SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage))) - 1)) AS ETI
-- FROM [gtt].[dbo].[EventsHistory]
-- WHERE ClientMessage LIKE (CONCAT('%',@message,'%')) AND [UtcTimeStamp] BETWEEN @date1 AND @date2
-- GROUP BY LEFT(SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage)), 
--               CHARINDEX(' ', SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage))) - 1)

-- SELECT 
--     CONVERT(DATE, [dbo].[UfnToLocalTime]([UtcTimeStamp])) AS [Fecha],
--     FORMAT(CONVERT(DATETIME, [dbo].[UfnToLocalTime]([UtcTimeStamp])), 'hh:mm tt') AS [Hora],
--     [ClientMessage] AS [Mensaje de Api],
--     UPPER([LineCode]) AS [Linea],
--     CONCAT('E', LEFT(SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage)), 
--          CHARINDEX(' ', SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage))) - 1)) AS ETI
-- FROM [gtt].[dbo].[EventsHistory]
-- WHERE ClientMessage LIKE (CONCAT('%',@message,'%')) AND [UtcTimeStamp] BETWEEN @date1 AND @date2
-- GROUP BY LEFT(SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage)), 
--               CHARINDEX(' ', SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage))) - 1)

-- SELECT
--     CONVERT(DATE, [dbo].[UfnToLocalTime]([UtcTimeStamp])) AS [Fecha]
--     ,FORMAT(CONVERT(DATETIME, [dbo].[UfnToLocalTime]([UtcTimeStamp])), 'hh:mm tt') AS [Hora]
--     ,[ClientMessage] AS [Mensaje de Api]
--     ,UPPER([LineCode]) AS [Linea]
-- FROM [gtt].[dbo].[EventsHistory] WHERE ClientMessage LIKE (CONCAT('%',@message,'%')) and [UtcTimeStamp] BETWEEN @date1 AND @date2

SELECT 
    UPPER([LineCode]) AS [Linea]
    ,[ClientMessage] AS [Mensaje de Api],
    CONCAT('E', LEFT(SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage)), 
    CHARINDEX(' ', SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage))) - 1)) AS ETI,
    CONVERT(DATE, [dbo].[UfnToLocalTime](MAX([UtcTimeStamp]))) AS [Fecha],
    FORMAT(CONVERT(DATETIME, [dbo].[UfnToLocalTime](MAX([UtcTimeStamp]))), 'hh:mm tt') AS [Hora]
FROM [gtt].[dbo].[EventsHistory] 
WHERE ClientMessage LIKE (CONCAT('%',@message,'%')) AND [UtcTimeStamp] BETWEEN @date1 AND @date2 --AND LineCode LIKE (@lineCode) 
GROUP BY [ClientMessage], [LineCode]