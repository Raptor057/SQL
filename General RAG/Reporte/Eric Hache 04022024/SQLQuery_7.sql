SELECT TOP 5000 PH.[UtcTimeStamp]
      ,PH.[UnitID]
      ,CONCAT('''',PH.UnitID,''',')
      ,PH.[ProcessID]
      ,PH.[LineCode]
      ,LPOU.PointOfUseCode
      ,POUE.EtiNo
  FROM [gtt].[dbo].[ProcessHistory] PH
  INNER JOIN [gtt].[dbo].[LinePointsOfUse] LPOU ON LPOU.LineCode = PH.LineCode
  INNER JOIN [gtt].[dbo].PointOfUseEtis POUE  ON POUE.PointOfUseCode = LPOU.PointOfUseCode AND PH.UtcTimeStamp >= POUE.UtcUsageTime AND PH.UtcTimeStamp <= POUE.UtcExpirationTime AND POUE.UtcUsageTime IS NOT NULL AND POUE.EtiNo LIKE '%433269%'
  WHERE POUE.UtcUsageTime >= '2023-11-22 22:56:42.977' AND POUE.UtcExpirationTime <= '2023-12-20 16:56:22.603' AND POUE.ComponentNo = '12423' AND PH.ProcessID = 999
  
  ORDER BY UtcTimeStamp DESC

  --------------------------------------------------------  --------------------------------------------------------  --------------------------------------------------------  --------------------------------------------------------

  SELECT LPS.[LineCode]
,LPOU.PointOfUseCode
,POUE.EtiNo
,POUE.UtcUsageTime
,PH.UnitID
,CONCAT('''',PH.UnitID,''',')
,PH.UtcTimeStamp
      ,LPS.[WorkOrderCode]
      ,LPS.[PartNo]
      ,LPS.[HourlyRate]
      ,LPS.[UtcEffectiveTime]
      ,LPS.[UtcExpirationTime]
      ,LPS.[Revision]
  FROM [gtt].[dbo].[LineProductionSchedule] LPS
  INNER JOIN [gtt].[dbo].[LinePointsOfUse] LPOU ON LPS.LineCode = LPOU.LineCode
  INNER JOIN [gtt].[dbo].PointOfUseEtis POUE ON LPOU.PointOfUseCode = POUE.PointOfUseCode AND POUE.UtcEffectiveTime >= LPS.UtcEffectiveTime AND POUE.UtcExpirationTime <= LPS.UtcExpirationTime
  INNER JOIN [gtt].[dbo].ProcessHistory PH ON LPS.LineCode = PH.LineCode AND PH.ProcessID = 999 AND PH.UtcTimeStamp >= POUE.UtcUsageTime AND PH.UtcTimeStamp <= POUE.UtcExpirationTime
  WHERE
  POUE.UtcUsageTime IS NOT NULL 
  AND POUE.EtiNo LIKE '%433269%'
  order BY LPS.UtcEffectiveTime DESC

--2250
--ULTIMA MASTER