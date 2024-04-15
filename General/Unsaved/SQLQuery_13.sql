DECLARE
    @lineCode NVARCHAR(50) = 'LC',
    @workOrderCode NVARCHAR(50) = 'W07617205',
    @partNo NVARCHAR(50) = '85397',
    @revision NVARCHAR(50) = 'A';

UPDATE lps SET lps.UtcExpirationTime = GETUTCDATE()
FROM dbo.LineProductionSchedule lps
CROSS JOIN GlobalSettings gs
WHERE lps.LineCode = @lineCode AND lps.UtcExpirationTime = gs.DefaultExpirationTime;
INSERT INTO dbo.LineProductionSchedule(LineCode, WorkOrderCode, PartNo, Revision, UtcEffectiveTime, UtcExpirationTime, HourlyRate)
SELECT @lineCode, @workOrderCode, @partNo, @revision, GETUTCDATE(), gs.DefaultExpirationTime, lmc.HourlyRate FROM dbo.GlobalSettings gs
JOIN dbo.LineModelCapabilities lmc
    ON lmc.LineCode = @lineCode AND lmc.PartNo = @partNo;