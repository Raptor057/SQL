USE [gttDev]
GO

declare @UnitID bigint
set @UnitID = (SELECT CAST(RAND() * 9999999 AS BIGINT) AS RandomNumber)

INSERT INTO [dbo].[EZ2000Motors]
([UnitID]
,[Website]
,[Voltage]
,[RPM]
,[Date]
,[Time]
,[ProductionID])
VALUES
(@UnitID
,'www.example.com'
,'220V'
,'1200'
,'2023-04-20'
,'12:34:56'
,'PRD001'),
(@UnitID
,'www.anotherexample.com'
,'110V'
,'1800'
,'2023-04-20'
,'23:45:56'
,'PRD002');
GO


