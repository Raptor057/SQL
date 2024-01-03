SELECT TOP (1000) [LineCode]
      ,[WorkOrderCode]
      ,[PartNo]
      ,[HourlyRate]
      ,[UtcEffectiveTime]
      ,[UtcExpirationTime]
      ,[Revision]
  FROM [gtt].[dbo].[LineProductionSchedule] WHERE LineCode = 'Ln' AND UtcExpirationTime > GETUTCDATE()

--UPDATE [gtt].[dbo].[LineProductionSchedule] SET UtcExpirationTime = GETUTCDATE() WHERE LineCode = 'Ln' AND UtcExpirationTime > GETUTCDATE()