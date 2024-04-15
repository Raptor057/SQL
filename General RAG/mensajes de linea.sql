SELECT 
    UPPER([LineCode]) AS [Linea]
    ,[ClientMessage] AS [Mensaje de Api],
    CONCAT('E', LEFT(SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage)), 
    CHARINDEX(' ', SUBSTRING(ClientMessage, CHARINDEX(' ETI ', ClientMessage) + 6, LEN(ClientMessage))) - 1)) AS ETI,
    CONVERT(DATE, [dbo].[UfnToLocalTime](MAX([UtcTimeStamp]))) AS [Fecha],
    FORMAT(CONVERT(DATETIME, [dbo].[UfnToLocalTime](MAX([UtcTimeStamp]))), 'hh:mm tt') AS [Hora]
FROM [gtt].[dbo].[EventsHistory] 
--WHERE ClientMessage LIKE (CONCAT('%',@message,'%')) AND [UtcTimeStamp] BETWEEN @date1 AND @date2
GROUP BY [ClientMessage], [LineCode]
ORDER BY Fecha DESC,hora DESC