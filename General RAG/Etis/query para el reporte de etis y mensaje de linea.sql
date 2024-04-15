-- SELECT TOP (1000) [ID]
--       ,[PointOfUseCode]
--       ,[EtiNo]
--       ,[ComponentNo]
--       ,[UtcEffectiveTime]
--       ,[UtcUsageTime]
--       ,[UtcExpirationTime]
--       ,[IsDepleted]
--       ,[Comments]
--       ,[LotNo]
--       ,[UtcSaveRemoveEtiTime]
--   FROM [gtt].[dbo].[SaveRemoveEti]

DECLARE @message VARCHAR(50),
@date1 DATETIME,
@date2 DATETIME

set @message = NULL
SET @date1 = GETUTCDATE()-20
SET @date2 = GETUTCDATE()

--   SELECT 
--     UPPER([LineCode]) AS [Linea]
--     ,[ClientMessage] AS [Mensaje de Api],
--     CONCAT('E', LEFT(SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage)), 
--     CHARINDEX(' ', SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage))) - 1)) AS EtiNo,
--     CONVERT(DATE, [dbo].[UfnToLocalTime](MAX([UtcTimeStamp]))) AS [Fecha],
--     FORMAT(CONVERT(DATETIME, [dbo].[UfnToLocalTime](MAX([UtcTimeStamp]))), 'hh:mm tt') AS [Hora]
-- FROM [gtt].[dbo].[EventsHistory] 
-- WHERE ClientMessage LIKE (CONCAT('%',@message,'%')) AND [UtcTimeStamp] BETWEEN @date1 AND @date2
-- GROUP BY [ClientMessage], [LineCode]
-- ORDER BY Fecha DESC,hora DESC

-- SELECT DISTINCT([EtiNo]) FROM [gtt].[dbo].[SaveRemoveEti]

SELECT 
    UPPER([LineCode]) AS [Linea],
    [ClientMessage] AS [Mensaje de Api],
    CONCAT('E', LEFT(SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage)), 
    CHARINDEX(' ', SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage))) - 1)) AS ETI,
    CONVERT(DATE, [dbo].[UfnToLocalTime](MAX([UtcTimeStamp]))) AS [Fecha],
    FORMAT(CONVERT(DATETIME, [dbo].[UfnToLocalTime](MAX([UtcTimeStamp]))), 'hh:mm tt') AS [Hora]
FROM [gtt].[dbo].[EventsHistory] 
WHERE ClientMessage LIKE (CONCAT('%',@message,'%')) 
AND [UtcTimeStamp] BETWEEN @date1 AND @date2 
AND CONCAT('E', LEFT(SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage)), 
    CHARINDEX(' ', SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage))) - 1)) NOT IN 
    (SELECT DISTINCT [EtiNo] FROM [gtt].[dbo].[SaveRemoveEti])
GROUP BY [ClientMessage], [LineCode]
ORDER BY Fecha DESC, hora DESC;
