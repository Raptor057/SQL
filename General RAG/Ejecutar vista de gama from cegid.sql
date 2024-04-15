USE [gtt]
GO

DECLARE @RC int
DECLARE @UnitID bigint
DECLARE @PartNo nvarchar(50)
DECLARE @lineCode nvarchar(2)
DECLARE @WorkOrderCode nvarchar(50)

SET @UnitID = 1
SET @PartNo = '85540'
SET @lineCode = 'LC' 
SET @WorkOrderCode = 'W07863552'

-- TODO: Set parameter values here.

EXECUTE @RC = [dbo].[UpsInsertProductionTraceability] 
   @UnitID
  ,@PartNo
  ,@lineCode
  ,@WorkOrderCode
GO


