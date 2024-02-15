-- SELECT 
--       PH.[LineCode]
--       ,LPS.PartNo
--       ,LPS.Revision
--       ,LPS.WorkOrderCode
--       ,COUNT(DISTINCT PH.UnitID) AS [Production]
--   FROM [gtt].[dbo].[ProcessHistory] PH
--   INNER JOIN [gtt].[dbo].[LineProductionSchedule] LPS ON LPS.LineCode = PH.LineCode AND PH.UtcTimeStamp > LPS.UtcEffectiveTime AND PH.UtcTimeStamp <= LPS.UtcExpirationTime
--   WHERE PH.ProcessID = 999 AND PH.UtcTimeStamp BETWEEN DATEADD(HOUR, -12, GETUTCDATE()) and GETUTCDATE()
-- GROUP BY PH.[LineCode],LPS.PartNo,LPS.Revision,LPS.WorkOrderCode

--Original del de abajo
-- SELECT 
--       PH.[LineCode]
--       ,LPS.PartNo
--       ,LPS.Revision
--       --,LPS.WorkOrderCode
--       ,COUNT(DISTINCT PH.UnitID) AS [Production]
--   FROM [gtt].[dbo].[ProcessHistory] PH
--   INNER JOIN [gtt].[dbo].[LineProductionSchedule] LPS ON LPS.LineCode = PH.LineCode AND PH.UtcTimeStamp > LPS.UtcEffectiveTime AND PH.UtcTimeStamp <= LPS.UtcExpirationTime
--   WHERE PH.ProcessID = 999 AND PH.UtcTimeStamp BETWEEN DATEADD(HOUR, -12, GETUTCDATE()) and GETUTCDATE()
-- GROUP BY PH.[LineCode],LPS.PartNo,LPS.Revision--,LPS.WorkOrderCode

 DECLARE @Date1 AS DATETIME
 DECLARE @Date2 AS DATETIME

SET @Date1 = GETDATE()-1
-- SET @Date1 = dbo.UfnToUniversalTime(DATEADD(HOUR, 7, DATEADD(DAY, DATEDIFF(DAY, 0, @Date1), 0)))
-- --SET @Date2 =  DATEADD(HOUR, 12, @Date1)

-- set @Date2 = dbo.UfnToUniversalTime(DATEADD(HOUR, 19, DATEADD(DAY, DATEDIFF(DAY, 0, @Date1), 0)))

-- SELECT @Date1
-- SELECT @Date2

SELECT 
      PH.[LineCode]
      ,LPS.PartNo
      ,LPS.Revision
      --,LPS.WorkOrderCode
      ,COUNT(DISTINCT PH.UnitID) AS [Production]
  FROM [gtt].[dbo].[ProcessHistory] PH
  INNER JOIN [gtt].[dbo].[LineProductionSchedule] LPS ON LPS.LineCode = PH.LineCode AND PH.UtcTimeStamp > LPS.UtcEffectiveTime AND PH.UtcTimeStamp <= LPS.UtcExpirationTime
  WHERE PH.ProcessID = 999 AND PH.UtcTimeStamp  
BETWEEN dbo.UfnToUniversalTime(DATEADD(HOUR, 7, DATEADD(DAY, DATEDIFF(DAY, 0, @Date1), 0))) and dbo.UfnToUniversalTime(DATEADD(HOUR, 19, DATEADD(DAY, DATEDIFF(DAY, 0, @Date1), 0)))
  --BETWEEN DATEADD(HOUR, -12, GETUTCDATE()) and GETUTCDATE()
GROUP BY PH.[LineCode],LPS.PartNo,LPS.Revision--,LPS.WorkOrderCode+
Order BY LineCode ASC,PartNo ASC


-- SELECT 
--     PH.[LineCode],
--     LPS.PartNo,
--     LPS.Revision,
--     DATEPART(HOUR,dbo.UfnToLocalTime(PH.UtcTimeStamp)) AS [Hour],
--     COUNT(DISTINCT PH.UnitID) AS [Production]
-- FROM [gtt].[dbo].[ProcessHistory] PH
-- INNER JOIN [gtt].[dbo].[LineProductionSchedule] LPS ON LPS.LineCode = PH.LineCode AND PH.UtcTimeStamp > LPS.UtcEffectiveTime AND PH.UtcTimeStamp <= LPS.UtcExpirationTime
-- WHERE PH.ProcessID = 999 AND PH.UtcTimeStamp BETWEEN DATEADD(HOUR, -12, GETUTCDATE()) AND GETUTCDATE()
-- --AND PH.LineCode = 'LB' --AND LPS.partno = '85503'
-- GROUP BY PH.[LineCode], LPS.PartNo, LPS.Revision, DATEPART(HOUR, dbo.UfnToLocalTime(PH.UtcTimeStamp))
-- ORDER BY PH.[LineCode], LPS.PartNo, LPS.Revision, DATEPART(HOUR, dbo.UfnToLocalTime(PH.UtcTimeStamp));


--SELECT DATEADD(HOUR, -12, GETUTCDATE()) AS UTCMinus8Hours;
--SELECT GETUTCDATE()