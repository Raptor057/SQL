INSERT INTO [dbo].[ActiveEtisTemp]
           ([PointOfUseCode]
           ,[EtiNo]
           ,[ComponentNo]
           ,[UtcEffectiveTime]
           ,[UtcUsageTime]
           ,[UtcExpirationTime]
           ,[IsDepleted]
           ,[Comments]
           ,[LotNo])
SELECT [PointOfUseCode]
           ,[EtiNo]
           ,[ComponentNo]
           ,[UtcEffectiveTime]
           ,[UtcUsageTime]
           ,[UtcExpirationTime]
           ,[IsDepleted]
           ,[Comments]
           ,[LotNo]  
	  FROM PointOfUseEtis where UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL order by PointOfUseCode asc;

--select * from ActiveEtisTemp

	  --delete ActiveEtisTemp