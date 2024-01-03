SELECT TOP (1000) [ID]
      ,[UnitID]
      ,[Website]
      ,[No_Load_Current]
      ,[No_Load_Speed]
      ,[Date]
      ,[Time]
      ,[Motor_number]
      ,[PN]
      ,[AEM]
      ,[Rev]
      ,[Pallet]
      ,[isEnable]
      ,[UtcTimeStamp]
  FROM [gtt].[dbo].[EZ2000Motors] WHERE UtcTimeStamp BETWEEN '2023-06-13 17:00:40.163' and '2023-06-13 19:00:40.163'
  --Motor_number = '0051'