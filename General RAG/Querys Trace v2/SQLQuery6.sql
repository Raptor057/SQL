/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ID]
      ,[UnitID]
      ,[Website]
      ,[Voltage]
      ,[RPM]
      ,[Date]
      ,[Time]
      ,[ProductionID]
      ,[UtcTimeStamp]
  FROM [gtt].[dbo].[EZ2000Motors]


  

--   delete [dbo].[EZ2000Motors]
--   DBCC CHECKIDENT ('[dbo].[EZ2000Motors]', RESEED, 0);
