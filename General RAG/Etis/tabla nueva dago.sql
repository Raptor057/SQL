SELECT TOP (1000) [ID]
      ,[PointOfUseCode]
      ,[EtiNo]
      ,[ComponentNo]
      ,[UtcEffectiveTime]
      ,[UtcUsageTime]
      ,[UtcExpirationTime]
      ,[IsDepleted]
      ,[Comments]
      ,[LotNo]
      ,[UtcSaveRemoveEtiTime]
  FROM [gtt].[dbo].[SaveRemoveEti]

-- delete SaveRemoveEti
-- DBCC CHECKIDENT('SaveRemoveEti', RESEED, 0);
