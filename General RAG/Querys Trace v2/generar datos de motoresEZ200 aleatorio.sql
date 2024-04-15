USE [gtt]
GO

declare 
@UnitID bigint,
@MDate date,
@Mtime varchar (50),
@ProductionID varchar (50),
@MDate2 date,
@Mtime2 varchar (50),
@ProductionID2 varchar (50)

set @UnitID = (SELECT CAST(RAND() * 9999999 AS BIGINT) AS RandomNumber)
set @ProductionID = (SELECT CAST(RAND() * 999 AS BIGINT) AS ProductionID)
set @MDate = (SELECT CONVERT(DATE, DATEADD(day, -365 * RAND(), GETDATE()), 101))
set @Mtime = (SELECT CONVERT(VARCHAR(8), GETDATE(), 108))
set @ProductionID2 = (SELECT CAST(RAND() * 999 AS BIGINT) AS ProductionID)
set @MDate2 = (SELECT CONVERT(DATE, DATEADD(day, -365 * RAND(), GETDATE()), 101))
set @Mtime2 = (SELECT CONVERT(VARCHAR(8), GETDATE(), 108))

INSERT INTO [dbo].[EZ2000Motors]
           ([UnitID]
           ,[Website]
           ,[Voltage]
           ,[RPM]
           ,[Date]
           ,[Time]
           ,[ProductionID]
           ,[UtcTimeStamp])
     VALUES
           (@UnitID
			,'www.example.com'
			,'220V'
			,'1200'
			,@MDate
			,@Mtime
			,CONCAT('PRD',@ProductionID) 
           ,GETUTCDATE()),
		   (@UnitID
			,'www.example.com'
			,'220V'
			,'1200'
			,@MDate2
			,@Mtime2
			,CONCAT('PRD',@ProductionID2)
           ,GETUTCDATE())SELECT top 2 ProductionID FROM [dbo].[EZ2000Motors] order by UtcTimeStamp desc --WHERE ID = SCOPE_IDENTITY()--;SELECT SCOPE_IDENTITY();
GO


