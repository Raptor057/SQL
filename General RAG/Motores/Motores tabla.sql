SELECT TOP (1000) [ID]
      ,[SerialNumber]
      ,[Volt]
      ,[RPM]
      ,[DateTimeMotor]
      ,[UtcDateTimeSerial]
      ,[Line]
  FROM [gtt].[dbo].[MotorsData]

  --INSERT INTO dbo.MotorsData([SerialNumber],[Volt],[RPM],[DateTimeMotor],[Line])VALUES('700U0006609','00.77A','16620',GETDATE(),'LA');

-- DELETE MotorsData
-- DBCC CHECKIDENT('MotorsData', RESEED, 0);