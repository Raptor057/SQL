SELECT PH.[UtcTimeStamp]
      ,PH.[UnitID]
      ,CONCAT('''',PH.UnitID,''',')
      ,PH.[ProcessID]
      ,PH.[LineCode]
      ,LPS.PartNo
  FROM [gtt].[dbo].[ProcessHistory] PH
--  INNER JOIN [gtt].[dbo].[LinePointsOfUse] LPOU ON LPOU.LineCode = PH.LineCode
  INNER JOIN [gtt].[dbo].LineProductionSchedule LPS ON PH.LineCode = LPS.LineCode AND PH.UtcTimeStamp >= LPS.UtcEffectiveTime AND PH.UtcTimeStamp <= LPS.UtcExpirationTime AND LPS.PartNo = '85540'
  WHERE PH.UtcTimeStamp BETWEEN dbo.UfnToUniversalTime('2023-11-22 00:00:00.000') and dbo.UfnToUniversalTime('2023-12-21 00:00:00.000')

--  SELECT dbo.UfnToUniversalTime('2023-11-22 00:00:00.000');

-- SELECT dbo.UfnToUniversalTime('2023-12-21 00:00:00.000');