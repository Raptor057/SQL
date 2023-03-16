USE [gtt]
GO
/****** Object:  UserDefinedFunction [dbo].[UfnLineShiftScheduleByWorkDay]    Script Date: 6/21/2022 5:09:50 PM ******/
-- SET ANSI_NULLS ON
-- GO
-- SET QUOTED_IDENTIFIER ON
-- GO
-- ALTER FUNCTION [dbo].[UfnLineShiftScheduleByWorkDay] (
declare
    @line_code VARCHAR(2) = 'U2',
    @moment DATETIME = '2022-06-21 15:00'
;
-- )
-- RETURNS TABLE
-- AS RETURN (
    WITH PreParams (TimeZone, LineCode, Now) AS (
        SELECT
            TimeZone,
            @line_code,
            ISNULL(@moment, CAST(GETUTCDATE() AT TIME ZONE 'UTC' AT TIME ZONE TimeZone AS DATETIME))
        FROM GlobalSettings
    ), Params AS (
        SELECT
            *,
            CAST(CAST(Now AS DATE) AS DATETIME) [Date],
            CAST(CAST(Now AS TIME) AS DATETIME) [Time]
        FROM PreParams
    )
    SELECT
		-- p.LineCode              [LineCode],
        -- p.Now                   [Moment],
        -- ss.Name                 [ShiftName],
        -- p.Date + ss.StartTime   [ShiftStartTime],
        -- p.Date + ss.EndTime     [ShiftEndTime],
        ssi.Name                [IntervalName],
		ROW_NUMBER() OVER(ORDER BY ssi.Ordinal) [SequenceNo],
        p.Date + ssi.StartTime  [IntervalStartTime],
        p.Date + ssi.EndTime    [IntervalEndTime],
		CASE WHEN p.Date + ssi.StartTime < CAST(GETUTCDATE() AT TIME ZONE 'UTC' AT TIME ZONE TimeZone AS DATETIME) THEN 1 ELSE 0 END [IsPastDue],
        ISNULL(sc.PartNo, '')   [PartNo],
		DATEDIFF(MINUTE,
			CASE WHEN dbo.UfnToLocalTime(sc.UtcEffectiveTime) >= p.Date + ssi.StartTime THEN dbo.UfnToLocalTime(sc.UtcEffectiveTime) ELSE p.Date + ssi.StartTime END,
			CASE WHEN dbo.UfnToLocalTime(sc.UtcExpirationTime) < p.Date + ssi.EndTime THEN dbo.UfnToLocalTime(sc.UtcExpirationTime) ELSE p.Date + ssi.EndTime END) [EffectiveMinutes],
        -- sc.HourlyRate,
		-- ISNULL(sc.HourlyRate, 0)*DATEDIFF(MINUTE,
		-- 	CASE WHEN dbo.UfnToLocalTime(sc.UtcEffectiveTime) > p.Date + ssi.StartTime THEN dbo.UfnToLocalTime(sc.UtcEffectiveTime) ELSE p.Date + ssi.StartTime END,
		-- 	CASE WHEN dbo.UfnToLocalTime(sc.UtcExpirationTime) < p.Date + ssi.EndTime THEN dbo.UfnToLocalTime(sc.UtcExpirationTime) ELSE p.Date + ssi.EndTime END)/60.0 [EffectiveHourlyRequirement]
        dbo.UfnToLocalTime(sc.UtcEffectiveTime)
    FROM dbo.LineShiftSchedules lss
    CROSS JOIN Params p
    JOIN dbo.ShiftSchedules ss
        ON ss.ID = lss.ShiftScheduleID
    JOIN ShiftScheduleIntervals ssi
        ON ssi.ShiftScheduleID = ss.ID
        AND (ssi.ByteEncodedValidDaysOfWeek IS NULL OR POWER(2, DATEPART(WEEKDAY, p.Date) - 1) & ssi.ByteEncodedValidDaysOfWeek != 0)
	LEFT JOIN dbo.LineProductionSchedule sc
		ON (dbo.UfnToLocalTime(sc.UtcEffectiveTime) <= p.Date + ssi.StartTime AND p.Date + ssi.StartTime < dbo.UfnToLocalTime(sc.UtcExpirationTime))
		OR (dbo.UfnToLocalTime(sc.UtcEffectiveTime) <= p.Date + ssi.EndTime AND p.Date + ssi.EndTime < dbo.UfnToLocalTime(sc.UtcExpirationTime))
    WHERE lss.LineCode = p.LineCode AND ss.ID = lss.ShiftScheduleID AND POWER(2, DATEPART(WEEKDAY, p.Date) - 1) & ss.ByteEncodedValidDaysOfWeek != 0
    AND (p.Date + ss.StartTime) <= p.Now AND p.Now < (p.Date + ss.EndTime)
-- );