  WITH CTE AS (
    SELECT [UtcTimeStamp], [UnitID], [ProcessID], [LineCode],
           ROW_NUMBER() OVER (PARTITION BY [LineCode] ORDER BY [UtcTimeStamp] DESC) AS RN
    FROM [gtt].[dbo].[ProcessHistory]
)
SELECT [UtcTimeStamp], [UnitID], [ProcessID], [LineCode]
FROM CTE
WHERE RN = 1
ORDER BY [UtcTimeStamp] DESC


SELECT top 100
--DISTINCT(LineCode) 
*
FROM ProcessHistory order by UtcTimeStamp DESC

SELECT top 20 UnitID FROM ProcessHistory where ProcessID = 999 and LineCode = @linecode order by UtcTimeStamp DESC