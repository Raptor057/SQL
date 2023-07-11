
declare @Line VARCHAR(2),
@date1 DATETIME,
@date2 DATETIME

SET @Line = 'A'
set @date1 = GETUTCDATE()-10
set @date2 = GETUTCDATE()


SELECT TOP (1000) [ID]
      ,[PointOfUseCode]
      ,[EtiNo]
      ,[ComponentNo]
      ,FORMAT ([dbo].[UfnToLocalTime] ([UtcEffectiveTime]), 'yyyy-MM-dd hh:mm:ss tt') AS UtcEffectiveTime
      ,FORMAT ([dbo].[UfnToLocalTime] ([UtcUsageTime]), 'yyyy-MM-dd hh:mm:ss tt') AS UtcUsageTime
      ,FORMAT ([dbo].[UfnToLocalTime] ([UtcExpirationTime]), 'yyyy-MM-dd hh:mm:ss tt') AS UtcExpirationTime
      ,[IsDepleted]
      ,[Comments]
      ,[LotNo]
  FROM [gtt].[dbo].[PointOfUseEtis] WHERE PointOfUseCode like (CONCAT('%',@Line,'%')) AND UtcEffectiveTime BETWEEN @date1 and @date2 order by UtcEffectiveTime desc

  --SELECT FORMAT (getdate(), 'yyyy-MM-dd hh:mm:ss tt') as date