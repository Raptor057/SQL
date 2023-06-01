SELECT TOP (1000) [UtcTimeStamp]
      ,[UnitID]
      ,[ProcessID]
      ,[LineCode]
  FROM [gtt].[dbo].[ProcessHistory] order by UtcTimeStamp DESC

  --DELETE ProcessHistory where UnitID IN ('9679964','9679965','9679966','9679967')
  