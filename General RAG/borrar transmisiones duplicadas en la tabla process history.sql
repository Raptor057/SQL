-- SELECT TOP (1000) [UtcTimeStamp]
--       ,[UnitID]
--       ,[ProcessID]
--       ,[LineCode]
--   FROM [gtt].[dbo].[ProcessHistory]
--   WHERE ProcessID = 0 AND LineCode = 'LE'
--   AND UnitID = '11091576'

WITH CTE_Duplicates AS (
    SELECT
        UtcTimeStamp,
        UnitID,
        ProcessID,
        LineCode,
        ROW_NUMBER() OVER (PARTITION BY UnitID ORDER BY UtcTimeStamp DESC) AS rn
    FROM [gtt].[dbo].[ProcessHistory]
    WHERE ProcessID = 0 AND LineCode = 'LE' --AND UnitID = '11091576'
)
DELETE FROM CTE_Duplicates
WHERE rn > 1;