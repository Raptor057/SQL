WITH Settings AS (
    SELECT *, CAST(GETUTCDATE() AS DATE) [workday] FROM GlobalSettings
), ShiftIntervals AS (
    SELECT
        ROW_NUMBER() OVER(ORDER BY ssi.StartTime) SeqNo,
        lss.LineCode,
        ssi.StartTime + CAST(workday AS DATETIME) [StartTime],
        ssi.EndTime + CAST(workday AS DATETIME) [EndTime],
        ssi.ActivationTime + CAST(workday AS DATETIME) [ActivationTime],
        ssi.DeactivationTime + CAST(workday AS DATETIME) [DeactivationTime],
        DATEDIFF(MINUTE, ssi.ActivationTime + CAST(workday AS DATETIME), ssi.DeactivationTime + CAST(workday AS DATETIME)) [ActiveMinutes],
        hc.Headcount,
        pu.Prod_Hour [Requirement]
    FROM dbo.LineShiftSchedules lss
    CROSS JOIN Settings gs
    JOIN dbo.ShiftSchedules ss
        ON ss.ID = lss.ShiftScheduleID
    JOIN dbo.ShiftScheduleIntervals ssi
        ON ssi.ShiftScheduleID = lss.ShiftScheduleID
    JOIN MXSRVTRACA.APPS.dbo.pro_prod_units pu
        ON pu.letter = lss.LineCode COLLATE SQL_Latin1_General_CP1_CI_AS
    JOIN dbo.LineHeadcountHistory hc
        ON hc.LineCode = lss.LineCode
        AND hc.UtcExpirationTime = ss.EndTime + CAST(workday AS DATETIME) AT TIME ZONE gs.TimeZone AT TIME ZONE 'UTC'
    WHERE 
        lss.EffectiveDay <= workday AND
        workday < lss.ExpirationDay
), Production AS (
    SELECT
        si.SeqNo,
        SUM(pl.Quantity) [Quantity]
    FROM ShiftIntervals si
    CROSS JOIN GlobalSettings gs
    LEFT JOIN dbo.ProductionLogs pl
        ON pl.LineCode = si.LineCode
        AND si.StartTime AT TIME ZONE gs.TimeZone AT TIME ZONE 'UTC' <= pl.UtcTimeStamp
        AND pl.UtcTimeStamp < si.EndTime AT TIME ZONE gs.TimeZone AT TIME ZONE 'UTC'
    GROUP BY si.SeqNo
)
SELECT
    si.SeqNo,
    LineCode,
    gs.workday [Workday],
    FORMAT(si.StartTime, 'HH:mm') + ' - ' + FORMAT(si.EndTime, 'HH:mm') [Interval],
    ActiveMinutes [Minutes],
    CAST(ActiveMinutes*si.Requirement/60.0 AS INT) [Requirement],
    p.Quantity,
    p.Quantity - CAST(ActiveMinutes*si.Requirement/60.0 AS INT) [Delta],
    1.0*p.Quantity/si.Headcount [PPH],
    CASE WHEN p.Quantity < CAST(ActiveMinutes*si.Requirement/60.0 AS INT) THEN
        ABS(FLOOR((p.Quantity - CAST(ActiveMinutes*si.Requirement/60.0 AS INT))*si.Requirement/60.0))
        ELSE 0 END [LostMinutes]
FROM ShiftIntervals si
CROSS JOIN Settings gs
JOIN Production p
    ON p.SeqNo = si.SeqNo;