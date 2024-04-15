/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [UnitID]
      ,[UtcTimeStamp]
      ,[LineCode]
      ,[PointOfUseCode]
      ,[ComponentNo]
      ,[EtiNo]
      ,[LotNo]
      ,[CompRev]
      ,[CompDesc]
      ,[codew]
  FROM [gtt].[dbo].[ProductionTraceability]

  --TRUNCATE TABLE [ProductionTraceability];
