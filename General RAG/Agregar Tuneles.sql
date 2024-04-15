--Registrar Tuneles 
SELECT TOP (1000) [LineCode]
      ,[PointOfUseCode]
      ,[IsDisabled]
      ,[CanBeLoadedByOperations]
  FROM [gtt].[dbo].[LinePointsOfUse]


  SELECT TOP (1000) [LineCode]
      ,[ProcessID]
      ,[PointOfUseCode]
      ,[UtcEffectiveTime]
      ,[UtcExpirationTime]
  FROM [gtt].[dbo].[LineProcessPointsOfUse]