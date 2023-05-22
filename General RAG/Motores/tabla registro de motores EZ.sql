SELECT TOP (1000) [ID]
      ,[UnitID]
      ,[Website]
      ,[No_Load_Current]
      ,[No_Load_Speed]
      ,[Date]
      ,[Time]
      ,[Motor_number]
      ,[UtcTimeStamp]
  FROM [gtt].[dbo].[EZ2000Motors]

  --DELETE EZ2000Motors

-- delete EZ2000Motors
-- DBCC CHECKIDENT('EZ2000Motors', RESEED, 0);


--select COUNT(DISTINCT(UnitID)) FROM EZ2000Motors WHERE UnitID = '9583187'
--select COUNT(DISTINCT(Motor_number)) FROM EZ2000Motors WHERE UnitID = '9583187'


