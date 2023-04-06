SELECT TOP (1000) [UtcTimeStamp]
      ,[UnitID]
      ,[ProcessID]
      ,[LineCode]
  FROM [gtt].[dbo].[ProcessHistory] order by UtcTimeStamp DESC



--   SELECT [LineCode], [UnitID], [UtcTimeStamp]
-- FROM (
--   SELECT [LineCode], [UnitID], [UtcTimeStamp],
--          ROW_NUMBER() OVER (PARTITION BY [LineCode] ORDER BY [UtcTimeStamp] DESC) as rn
--   FROM [gtt].[dbo].[ProcessHistory]
-- ) as ph
-- WHERE rn = 1



SELECT [LineCode], [UnitID], [dbo].[UfnToLocalTime]([UtcTimeStamp]) AS LocalTimeStamp
FROM (
  SELECT [LineCode], [UnitID], [UtcTimeStamp],
         ROW_NUMBER() OVER (PARTITION BY [LineCode] ORDER BY [UtcTimeStamp] DESC) as rn
  FROM [gtt].[dbo].[ProcessHistory]
) as ph
WHERE rn = 1
