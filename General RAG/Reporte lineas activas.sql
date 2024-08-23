SELECT [LineCode]
  FROM [gtt].[dbo].[LineProductionSchedule] WHERE UtcExpirationTime > GETUTCDATE()
  ORDER BY LineCode ASC