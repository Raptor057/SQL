--     DECLARE @unitID NVARCHAR(15),
--     @componentNo NVARCHAR (15)

--     set @unitID = '700U0011562'
--     set @componentNo = NULL

--     SELECT
        --ROW_NUMBER() OVER(ORDER BY e.PointOfUseCode, e.ComponentNo) [SeqNo],
        --t.Line, p.PartNo, e.PointOfUseCode, e.ComponentNo, g.CompRev, g.CompDesc, g.CompFamilyCode, e.EtiNo, e.LotNo,
        --CAST(t.UtcDateTimeSerial AT TIME ZONE 'UTC' AT TIME ZONE gs.TimeZone AS DATETIME) [LocalTimeStamp],
        --CAST(e.UtcUsageTime AT TIME ZONE 'UTC' AT TIME ZONE gs.TimeZone AS DATETIME) [UsageTime],
        --CAST(e.UtcExpirationTime AT TIME ZONE 'UTC' AT TIME ZONE gs.TimeZone AS DATETIME) [ExpirationTime]

--     FROM dbo.MotorsData t WITH(NOLOCK)

    

--     CROSS JOIN GlobalSettings gs

--     JOIN dbo.LineProcessPointsOfUse pou
--         ON pou.LineCode = t.Line --AND pou.ProcessID = t.ProcessID
--         AND pou.UtcEffectiveTime <= t.UtcDateTimeSerial AND t.UtcDateTimeSerial < pou.UtcExpirationTime

--     JOIN dbo.LineProductionSchedule p
--         ON p.LineCode = t.Line
--         AND p.UtcEffectiveTime <= t.UtcDateTimeSerial AND t.UtcDateTimeSerial < p.UtcExpirationTime

--     JOIN dbo.PointOfUseEtis e
--         ON e.PointOfUseCode = pou.PointOfUseCode AND (@componentNo IS NULL OR @componentNo = e.ComponentNo)
--         AND e.UtcUsageTime <= t.UtcDateTimeSerial
--         AND (e.UtcExpirationTime IS NULL OR t.UtcDateTimeSerial < e.UtcExpirationTime)

--     JOIN dbo.LineProductionSchedule ps
--         ON ps.LineCode = t.Line
--         AND ps.UtcEffectiveTime <= t.UtcDateTimeSerial AND t.UtcDateTimeSerial < ps.UtcExpirationTime

--  JOIN dbo.LineGamma g
-- 	--JOIN dbo.LineGamma g
--         ON g.UtcEffectiveTime = ps.UtcEffectiveTime AND ps.LineCode = g.LineCode
--         AND g.PartNo = ps.PartNo AND g.CompNo = e.ComponentNo AND g.PointOfUseCode = e.PointOfUseCode
--     WHERE t.SerialNumber = @unitID --AND t.ProcessID=0;


----------

    DECLARE @SerialNumber AS NVARCHAR(25)
    SET @SerialNumber = '700U0023611'

    SELECT
        ROW_NUMBER() OVER(ORDER BY e.PointOfUseCode, e.ComponentNo) [SeqNo],
        t.Line, p.PartNo, e.PointOfUseCode, e.ComponentNo, g.CompRev, g.CompDesc, g.CompFamilyCode, e.EtiNo, e.LotNo,
        CAST(t.UtcDateTimeSerial AT TIME ZONE 'UTC' AT TIME ZONE gs.TimeZone AS DATETIME) [LocalTimeStamp],
        CAST(e.UtcUsageTime AT TIME ZONE 'UTC' AT TIME ZONE gs.TimeZone AS DATETIME) [UsageTime],
        CAST(e.UtcExpirationTime AT TIME ZONE 'UTC' AT TIME ZONE gs.TimeZone AS DATETIME) [ExpirationTime]
        FROM dbo.MotorsData t WITH(NOLOCK)

        CROSS JOIN GlobalSettings gs

        JOIN dbo.LineProcessPointsOfUse pou
        ON pou.LineCode = t.Line --AND pou.ProcessID = t.ProcessID
        AND pou.UtcEffectiveTime <= t.UtcDateTimeSerial AND t.UtcDateTimeSerial < pou.UtcExpirationTime

        JOIN dbo.LineProductionSchedule p
        ON p.LineCode = t.Line
        AND p.UtcEffectiveTime <= t.UtcDateTimeSerial AND t.UtcDateTimeSerial < p.UtcExpirationTime

        JOIN dbo.PointOfUseEtis e
        ON e.PointOfUseCode = pou.PointOfUseCode-- AND (@componentNo IS NULL OR @componentNo = e.ComponentNo)
        AND e.UtcUsageTime <= t.UtcDateTimeSerial
        AND (e.UtcExpirationTime IS NULL OR t.UtcDateTimeSerial < e.UtcExpirationTime)

        JOIN dbo.LineProductionSchedule ps
        ON ps.LineCode = t.Line
        AND ps.UtcEffectiveTime <= t.UtcDateTimeSerial AND t.UtcDateTimeSerial < ps.UtcExpirationTime

         JOIN dbo.LineGamma g
        ON g.UtcEffectiveTime = ps.UtcEffectiveTime AND ps.LineCode = g.LineCode
        AND g.PartNo = ps.PartNo AND g.CompNo = e.ComponentNo AND g.PointOfUseCode = e.PointOfUseCode
         WHERE t.SerialNumber = @SerialNumber


