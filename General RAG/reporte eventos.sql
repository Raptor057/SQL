SELECT
    CONVERT(DATE, [dbo].[UfnToLocalTime]([UtcTimeStamp])) AS [Fecha]
    ,FORMAT(CONVERT(DATETIME, [dbo].[UfnToLocalTime]([UtcTimeStamp])), 'hh:mm tt') AS [Hora]
    ,[ClientMessage] AS [Mensaje de Api]
    ,UPPER([LineCode]) AS [Linea]
FROM [gtt].[dbo].[EventsHistory]
WHERE [UtcTimeStamp] BETWEEN '2022-01-01' AND '2023-12-31'
