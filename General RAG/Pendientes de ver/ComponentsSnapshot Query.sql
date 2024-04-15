SELECT TOP (1000) [ID]
      ,[SnapShotID]
      ,[LineCode]
      ,[PointOfUseCode]
      ,[EtiNo]
      ,[MasterEtiNo]
      ,[ComponentNo]
      ,[ComponentRev]
      ,[ComponentDescription]
      ,[LotNo]
      ,[UtcTimeStamp]
  FROM [gtt].[dbo].[ComponentsSnapShot]

  INSERT INTO ComponentsSnapshot (SnapShotID,LineCode,PointOfUseCode,EtiNo,MasterEtiNo,ComponentNo,ComponentRev,ComponentDescription,LotNo)
SELECT CAST(FORMAT(GETUTCDATE(), 'yyyyMMddHHmmssfff') AS BIGINT) AS [ID],LPU.LineCode, PUE.PointOfUseCode,PUE.EtiNo,
CASE 
        WHEN CHARINDEX('-', PUE.EtiNo) > 0 THEN
            LEFT(PUE.EtiNo, CHARINDEX('-', PUE.EtiNo) - 1)
        ELSE
            PUE.EtiNo
    END AS MasterEtiNo
,PUE.ComponentNo,RTRIM(CB.NOCTCOMCPT) AS [ComponentRev],RTRIM(CB.ARCTLIB01) AS [Description],PUE.LotNo
  FROM [gtt].[dbo].[PointOfUseEtis] PUE
  FULL JOIN LinePointsOfUse LPU ON PUE.PointOfUseCode = LPU.PointOfUseCode
  FULL JOIN LineProductionSchedule LPS ON LPS.LineCode = LPU.LineCode AND  LPS.UtcExpirationTime > GETUTCDATE()
  RIGHT JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB ON RTRIM(CB.NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.PartNo 
  AND RTRIM(NOKTCOMPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.LineCode 
  AND RTRIM(CB.NOCTCODECP) COLLATE SQL_Latin1_General_CP1_CI_AS = PUE.ComponentNo
  AND TRIM(CB.NOCTCODOPE) COLLATE SQL_Latin1_General_CP1_CI_AS = LPU.PointOfUseCode
  WHERE LPU.LineCode = @LineCode AND PUE.UtcExpirationTime IS NULL AND PUE.UtcUsageTime IS NOT NULL AND PUE.UtcUsageTime <GETUTCDATE()
