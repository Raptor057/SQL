SELECT top 1
LP.LineCode,
LPS.PartNo
FROM PointOfUseEtis PO
LEFT JOIN LinePointsOfUse LP ON LP.PointOfUseCode = PO.PointOfUseCode
LEFT JOIN LineProductionSchedule LPS ON LPS.LineCode = LP.LineCode
WHERE PO.PointOfUseCode = 'A05'
AND PO.UtcExpirationTime IS NULL 
AND PO.UtcUsageTime IS NOT NULL
AND LPS.UtcExpirationTime > GETUTCDATE()

DECLARE @PointOfUse NVARCHAR(10)
set @PointOfUse = 'A05'

SELECT top 1 LP.LineCode,LPS.PartNo FROM PointOfUseEtis PO LEFT JOIN LinePointsOfUse LP ON LP.PointOfUseCode = PO.PointOfUseCode LEFT JOIN LineProductionSchedule LPS ON LPS.LineCode = LP.LineCode WHERE PO.PointOfUseCode = @PointOfUse AND PO.UtcExpirationTime IS NULL AND PO.UtcUsageTime IS NOT NULL AND LPS.UtcExpirationTime > GETUTCDATE()
