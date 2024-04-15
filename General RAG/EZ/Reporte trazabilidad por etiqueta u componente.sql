-- SELECT 
-- LP.LineCode,
-- LP.PartNo,
-- PH.UnitID,
-- CB.NOCTCODOPE,
-- CB.NOCTCODECP
-- FROM LineProductionSchedule LP
-- JOIN ProcessHistory PH ON PH.LineCode = LP.LineCode
-- JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB ON CB.NOKTCODPF COLLATE SQL_Latin1_General_CP1_CI_AS = LP.PartNo AND CB.NOKTCOMPF COLLATE SQL_Latin1_General_CP1_CI_AS = PH.LineCode
-- JOIN PointOfUseEtis PO ON CB.NOCTCODOPE COLLATE SQL_Latin1_General_CP1_CI_AS = PO.PointOfUseCode
-- WHERE 
-- LP.UtcExpirationTime > GETUTCDATE()
-- AND PH.UtcTimeStamp >= LP.UtcEffectiveTime
-- AND LP.LineCode = 'LE'
--   --AND CB.NOCTCODOPE = ''
-- AND CB.NOCTCODECP ='41905'

SELECT
lp.LineCode,
LP.PartNo,
LP.Revision,
LP.Revision,
PH.UnitID,
PH.UtcTimeStamp
--PO.EtiNo
FROM LineProductionSchedule LP
LEFT JOIN ProcessHistory PH ON PH.UtcTimeStamp >= LP.UtcEffectiveTime AND PH.UtcTimeStamp <= LP.UtcExpirationTime AND PH.LineCode = LP.LineCode
--LEFT JOIN PointOfUseEtis PO ON PO.UtcUsageTime >= PH.UtcTimeStamp AND PO.UtcUsageTime <= PH.UtcTimeStamp
WHERE LP.UtcExpirationTime > GETUTCDATE()
AND LP.LineCode ='LE' 
AND PH.ProcessID = 999



