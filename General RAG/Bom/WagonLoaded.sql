SELECT LPS.LineCode, LPO.PointOfUseCode,LPS.PartNo, WL.ComponentNo, BM.ARCTLIB01,BM.NOCTCOMCPT--,BM.APKSTDPACK
FROM LineProductionSchedule LPS
INNER JOIN LinePointsOfUse LPO ON LPO.LineCode = LPS.LineCode
INNER JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] BM ON BM.NOKTCOMPF COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.LineCode AND BM.NOKTCODPF COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.PartNo AND BM.NOCTCODOPE COLLATE SQL_Latin1_General_CP1_CI_AS = LPO.PointOfUseCode
INNER JOIN WagonLoad WL ON WL.PointOfUseCode = LPO.PointOfUseCode AND BM.NOCTCODECP COLLATE SQL_Latin1_General_CP1_CI_AS = WL.ComponentNo
WHERE LPS.UtcExpirationTime >= GETUTCDATE()
AND LPS.LineCode = 'LO'
AND WL.InWagonLoaded = 0 AND WL.UtcTimeWagonLoaded IS NULL AND WL.UtcTimeStamp >= CAST(CAST(GETDATE() -1 AS date) AS datetime)
ORDER BY LPS.LineCode ASC,LPO.PointOfUseCode ASC, WL.ComponentNo ASC