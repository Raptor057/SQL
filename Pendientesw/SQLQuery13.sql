DECLARE @lineCode varchar(20)

set @lineCode = 'LP'

SELECT * FROM [dbo].[UfnLineCurrentHourProduction] (@lineCode)

   SELECT * FROM [dbo].[UfnLinePerformanceReport] (@lineCode)

   SELECT * FROM [dbo].[UfnLineScheduledRequirement] (@lineCode,NULL,3640)

  SELECT * FROM [dbo].[UfnLineShift] (@lineCode,NULL)

  SELECT * FROM [dbo].[UfnLineShiftHeadcount] (@lineCode)

   SELECT * FROM [dbo].[UfnProductionReport] (@lineCode,GETDATE())

  SELECT * FROM [dbo].[UfnProductionTimeIntervals] (@lineCode,GETDATE(),3640)