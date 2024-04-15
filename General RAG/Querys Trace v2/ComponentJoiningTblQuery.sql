SELECT TOP (1000) [ID]
      ,[UnitID]
      ,[ComponentID]
      ,[LineCode]
      ,[PartNo]
      ,[UtcTimeStamp]
      ,[isEnable]
  FROM [gtt].[dbo].[ComponentJoining]


  
--  delete ComponentJoining
--  DBCC CHECKIDENT('ComponentJoining', RESEED, 0);
--update ComponentJoining set isEnable = 1