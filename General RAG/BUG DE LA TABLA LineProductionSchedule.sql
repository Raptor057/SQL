SELECT TOP (1000) [LineCode]
      ,[WorkOrderCode]
      ,[PartNo]
      ,[HourlyRate]
      ,[UtcEffectiveTime]
      ,[UtcExpirationTime]
      ,[Revision]
  FROM [gtt].[dbo].[LineProductionSchedule] where UtcExpirationTime >= GETUTCDATE()

DECLARE @lineCode VARCHAR(20),
@WorkOrder VARCHAR(20),
@partNo VARCHAR(20),
@revision VARCHAR(20)

set @lineCode = 'LX'
SET @WorkOrder = 'XXXXXXXXXX'
SET @partNo = 'XXXXX'
SET @revision = 'XX'

  --INSERT INTO LineProductionSchedule (LineCode,WorkOrderCode,PartNo,HourlyRate,UtcEffectiveTime,Revision) values (@lineCode,@WorkOrder,@partNo,ISNULL((SELECT TOP 1 HourlyRate FROM LineProductionSchedule WHERE LineCode = @lineCode AND PartNo = @partNo ORDER BY UtcExpirationTime DESC),0),GETUTCDATE(),@revision)



--  DELETE LineProductionSchedule WHERE WorkOrderCode ='XXXXXXXXXX'