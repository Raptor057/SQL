    declare 
@componentNo NVARCHAR(50),
@unitID nvarchar (50)
set @componentNo = null
set @UnitID = '9504397'
    SELECT
        ROW_NUMBER() OVER(ORDER BY e.PointOfUseCode, e.ComponentNo) [SeqNo],
        t.LineCode, p.PartNo, e.PointOfUseCode, e.ComponentNo, g.CompRev, g.CompDesc, g.CompFamilyCode, e.EtiNo, e.LotNo,
        CAST(t.UtcTimeStamp AT TIME ZONE 'UTC' AT TIME ZONE gs.TimeZone AS DATETIME) [LocalTimeStamp],
        CAST(e.UtcUsageTime AT TIME ZONE 'UTC' AT TIME ZONE gs.TimeZone AS DATETIME) [UsageTime],
        CAST(e.UtcExpirationTime AT TIME ZONE 'UTC' AT TIME ZONE gs.TimeZone AS DATETIME) [ExpirationTime]
    FROM dbo.ProcessHistory t WITH(NOLOCK)
    CROSS JOIN GlobalSettings gs
    JOIN dbo.LineProcessPointsOfUse pou
        ON pou.LineCode = t.LineCode AND pou.ProcessID = t.ProcessID
        AND pou.UtcEffectiveTime <= t.UtcTimeStamp AND t.UtcTimeStamp < pou.UtcExpirationTime
    JOIN dbo.LineProductionSchedule p
        ON p.LineCode = t.LineCode
        AND p.UtcEffectiveTime <= t.UtcTimeStamp AND t.UtcTimeStamp < p.UtcExpirationTime
    JOIN dbo.PointOfUseEtis e
        ON e.PointOfUseCode = pou.PointOfUseCode AND (@componentNo IS NULL OR @componentNo = e.ComponentNo)
        AND e.UtcUsageTime <= t.UtcTimeStamp
        AND (e.UtcExpirationTime IS NULL OR t.UtcTimeStamp < e.UtcExpirationTime)
    JOIN dbo.LineProductionSchedule ps
        ON ps.LineCode = t.LineCode
        AND ps.UtcEffectiveTime <= t.UtcTimeStamp AND t.UtcTimeStamp < ps.UtcExpirationTime
    LEFT JOIN dbo.LineGamma g
        ON g.UtcEffectiveTime = ps.UtcEffectiveTime AND ps.LineCode = g.LineCode
        AND g.PartNo = ps.PartNo AND g.CompNo = e.ComponentNo AND g.PointOfUseCode = e.PointOfUseCode
    WHERE t.UnitID = @unitID;

-- declare 
-- @componentNo NVARCHAR(50),
-- @unitID nvarchar (50)
-- set @componentNo = null
-- set @UnitID = '9504397'


        SELECT top 100 
        ROW_NUMBER() OVER(ORDER BY e.PointOfUseCode, e.ComponentNo) [SeqNo],
        t.LineCode,
        p.PartNo,
        e.PointOfUseCode,
        e.ComponentNo,
        g.CompRev, 
        g.CompDesc,
        g.CompFamilyCode,
        e.EtiNo,
        e.LotNo,
        CAST(t.UtcTimeStamp AT TIME ZONE 'UTC' AT TIME ZONE gs.TimeZone AS DATETIME) [LocalTimeStamp],
        CAST(e.UtcUsageTime AT TIME ZONE 'UTC' AT TIME ZONE gs.TimeZone AS DATETIME) [UsageTime],
        CAST(e.UtcExpirationTime AT TIME ZONE 'UTC' AT TIME ZONE gs.TimeZone AS DATETIME) [ExpirationTime]
    FROM dbo.ProcessHistory t WITH(NOLOCK)
    CROSS JOIN GlobalSettings gs
    JOIN dbo.LineProcessPointsOfUse pou
        ON pou.LineCode = t.LineCode AND pou.ProcessID = t.ProcessID
        AND pou.UtcEffectiveTime <= t.UtcTimeStamp AND t.UtcTimeStamp < pou.UtcExpirationTime
        JOIN dbo.LineProductionSchedule p
        ON p.LineCode = t.LineCode
        AND p.UtcEffectiveTime <= t.UtcTimeStamp AND t.UtcTimeStamp < p.UtcExpirationTime
         JOIN dbo.PointOfUseEtis e
        ON e.PointOfUseCode = pou.PointOfUseCode AND (@componentNo IS NULL OR @componentNo = e.ComponentNo)
        AND e.UtcUsageTime <= t.UtcTimeStamp
        AND (e.UtcExpirationTime IS NULL OR t.UtcTimeStamp < e.UtcExpirationTime)
        JOIN dbo.LineProductionSchedule ps
        ON ps.LineCode = t.LineCode
        AND ps.UtcEffectiveTime <= t.UtcTimeStamp AND t.UtcTimeStamp < ps.UtcExpirationTime
        LEFT JOIN dbo.LineGamma g
        ON ps.LineCode = g.LineCode AND g.UtcEffectiveTime = ps.UtcEffectiveTime
        AND g.PartNo = ps.PartNo AND g.CompNo = e.ComponentNo AND g.PointOfUseCode = e.PointOfUseCode
        WHERE t.UnitID = @unitID;


select * from LineGamma g
JOIN LineProductionSchedule ps
ON g.UtcEffectiveTime = ps.UtcEffectiveTime
--select * from LineProductionSchedule 