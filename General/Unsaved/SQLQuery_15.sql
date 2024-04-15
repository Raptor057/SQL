DECLARE @utcNow DATETIME = GETUTCDATE();
DECLARE @today DATE = @utcNow;
DECLARE @weekday INT = DATEPART(WEEKDAY, @today);

WITH a AS (
    SELECT
        ls.LineCode,
        CAST(CAST(@today AS DATETIME) + si.StartTime AT TIME ZONE gs.TimeZone AT TIME ZONE 'UTC' AS DATETIME) [UtcStartTime],
        CAST(CAST(@today AS DATETIME) + si.EndTime AT TIME ZONE gs.TimeZone AT TIME ZONE 'UTC' AS DATETIME) [UtcEndTime],
        CAST(CAST(@today AS DATETIME) + si.ActivationTime AT TIME ZONE gs.TimeZone AT TIME ZONE 'UTC' AS DATETIME) [UtcActivationTime],
        CAST(CAST(@today AS DATETIME) + si.DeactivationTime AT TIME ZONE gs.TimeZone AT TIME ZONE 'UTC' AS DATETIME) [UtcDeactivationTime],
        mc.HourlyRate
    FROM dbo.LineShiftSchedules ls
    CROSS JOIN dbo.GlobalSettings gs
    JOIN dbo.ShiftSchedules ss
        ON ss.ID = ls.ShiftScheduleID
        AND @weekday & ss.ByteEncodedValidDaysOfWeek = @weekday 
    JOIN dbo.ShiftScheduleIntervals si
        ON si.ShiftScheduleID = ls.ShiftScheduleID
        AND CAST(CAST(@today AS DATETIME) + si.StartTime AT TIME ZONE gs.TimeZone AT TIME ZONE 'UTC' AS DATETIME) <= @utcNow
        AND @utcNow < CAST(CAST(@today AS DATETIME) + si.EndTime AT TIME ZONE gs.TimeZone AT TIME ZONE 'UTC' AS DATETIME)
    JOIN dbo.LineProductionSchedule ps
        ON ps.LineCode = ls.LineCode
        AND ps.UtcEffectiveTime <= @utcNow AND @utcNow < ps.UtcExpirationTime
    JOIN dbo.LineModelCapabilities mc
        ON mc.LineCode = ps.LineCode AND mc.PartNo = ps.PartNo
    WHERE ls.EffectiveDay <= @utcNow AND CAST(@utcNow AS DATE) < ls.ExpirationDay
), b AS (
    SELECT ROW_NUMBER() OVER(PARTITION BY a.LineCode ORDER BY p.UtcTimeStamp) i, a.*, p.UtcTimeStamp, p.Quantity FROM a
    JOIN dbo.ProductionLogs p WITH(NOLOCK)
        ON p.LineCode = a.LineCode
        AND a.UtcStartTime <= p.UtcTimeStamp AND p.UtcTimeStamp < a.UtcEndTime
), c AS (
    SELECT --b.*,
        b.LineCode,
        b.Quantity,
        ISNULL(b2.UtcTimeStamp, b.UtcStartTime) a,
        b.UtcTimeStamp b,
        DATEDIFF(MILLISECOND, ISNULL(b2.UtcTimeStamp, b.UtcStartTime), b.UtcTimeStamp)/60000.0 [Delta]
    FROM b
    LEFT JOIN b b2
        ON b2.i = b.i - 1 AND b.LineCode = b2.LineCode
)
SELECT SUM(Quantity), AVG(Delta), SUM(Quantity)/AVG(Delta) FROM c WHERE LineCode='LB';

SELECT * FROM dbo.UfnLineCurrentHourProduction('LB');

return;

DECLARE @lineCode NVARCHAR(50) = 'LC';

WITH src AS (
    SELECT
        r.LineCode,
        r.EffectiveHourlyRequirement,
        r.EffectiveMinutes,
        r.IntervalActivationTime,
        r.IntervalDeactivationTime,
        r.IntervalStartTime,
        r.IntervalEndTime,
        p.PartNo,
        p.Quantity,
        p.Revision,
        p.UtcTimeStamp,
        p.WorkOrderCode
    FROM dbo.UfnLineScheduledRequirement(@lineCode, NULL, NULL) r
    LEFT JOIN dbo.ProductionLogs p
        ON p.LineCode = @lineCode
        AND dbo.UfnToUniversalTime(r.IntervalStartTime) <= p.UtcTimeStamp
        AND p.UtcTimeStamp < dbo.UfnToUniversalTime(r.IntervalEndTime)
    WHERE r.LineCode = @lineCode AND dbo.UfnToUniversalTime(IntervalStartTime) <= GETUTCDATE()
    AND GETUTCDATE() < dbo.UfnToUniversalTime(IntervalEndTime)

), totals AS (
    SELECT
        LineCode,
        IntervalActivationTime,
        IntervalDeactivationTime,
        --EffectiveHourlyRequirement,
        --EffectiveMinutes,
        ISNULL(SUM(Quantity), 0) [ActualQuantity],
        EffectiveHourlyRequirement [Requirement],
        DATEDIFF(SECOND, dbo.UfnToUniversalTime(IntervalActivationTime), GETUTCDATE())/60.0 [ElapsedMinutes],
        1.0*EffectiveHourlyRequirement/EffectiveMinutes [ExpectedRate],
        CASE WHEN DATEDIFF(SECOND, GETUTCDATE(), dbo.UfnToUniversalTime(IntervalDeactivationTime))/60.0 < 0
            THEN 0
            ELSE DATEDIFF(SECOND, GETUTCDATE(), dbo.UfnToUniversalTime(IntervalDeactivationTime))/60.0
        END [RemainingMinutes]
    FROM src
    GROUP BY LineCode, IntervalActivationTime, IntervalDeactivationTime, EffectiveHourlyRequirement, EffectiveMinutes
), results AS (
    SELECT
        LineCode,
        FORMAT(IntervalActivationTime, 'HH:mm') + ' - ' + FORMAT(IntervalDeactivationTime, 'HH:mm') [Interval],
        ActualQuantity,
        Requirement,
        ActualQuantity + CAST(RemainingMinutes*ActualQuantity/ElapsedMinutes AS INT) [Forecast],
        ExpectedRate,
        ActualQuantity/ElapsedMinutes [ActualRate],
        CAST(ElapsedMinutes*ExpectedRate AS INT) [ExpectedQuantity]
    FROM totals
    UNION ALL
    SELECT
        'X',
        '00:00 - 00:00',
        0,
        0,
        0,
        0,
        0,
        0
)
SELECT TOP 1
    *
FROM results ORDER BY LineCode;