SELECT TOP (1000) [ID]
      ,[PointOfUseCode]
      ,[EtiNo]
      ,[ComponentNo]
    --   ,dbo.[UfnToLocalTime]([UtcEffectiveTime]) AS [Carga]
    --   ,dbo.[UfnToLocalTime]([UtcUsageTime]) AS [ Uso]
    --   ,dbo.[UfnToLocalTime]([UtcExpirationTime]) AS [Termino]
        ,[UtcEffectiveTime]
      ,[UtcUsageTime]
      ,[UtcExpirationTime]
      ,[IsDepleted]
      ,[Comments]
      ,[LotNo]
  FROM [gtt].[dbo].[PointOfUseEtis] where EtiNo LIKE '%433269%'
  and UtcUsageTime is not null
  order by UtcUsageTime asc