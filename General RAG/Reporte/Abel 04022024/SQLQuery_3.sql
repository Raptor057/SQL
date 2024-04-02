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
  FROM [gtt].[dbo].[PointOfUseEtis] WHERE EtiNo LIKE '%433269%'
  AND UtcUsageTime IS NOT NULL
  ORDER BY UtcUsageTime ASC