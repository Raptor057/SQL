SELECT TOP (1000) [ID]
      ,[UnitID]
      ,[Website]
      ,[No_Load_Current]
      ,[No_Load_Speed]
      ,[Date]
      ,[Time]
      ,[Motor_number]
      ,[UtcTimeStamp]
  FROM [gtt].[dbo].[EZ2000Motors]

DECLARE @UnitID bigint,
@Motor_Number1 VARCHAR(50),
@Date1 VARCHAR(50),
@Time1 VARCHAR(50),
@Motor_Number2 VARCHAR(50),
@Date2 VARCHAR(50),
@Time2 VARCHAR(50)

SET @UnitID = 9720634
set @Motor_Number1 = '0038'
set @Date1 = '2023-2-17'
set @Time1 = '12:30'

set @Motor_Number2 = '0026'
set @Date2 = '2023-2-17'
set @Time2 = '10:36'

SELECT CASE WHEN (SELECT COUNT(UnitID) FROM EZ2000Motors WHERE UnitID = @UnitID OR [Date] = @Date1 AND [Time] = @Time1 AND Motor_number = @Motor_Number1 OR [Date] = @Date2 AND [Time] = @Time2 AND Motor_number = @Motor_Number2) > 0 THEN 1 ELSE 0 END AS Result