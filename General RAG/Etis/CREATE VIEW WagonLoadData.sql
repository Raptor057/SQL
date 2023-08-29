--CREATE VIEW WagonLoadData AS
SELECT
    LP.LineCode,
    LPS.PartNo,
    WL.ComponentNo,
    CB.NOCTCOMCPT,
    CB.ARCTLIB01,
    WL.UtcTimeStamp
    --WL.InWagonLoaded 
FROM [gtt].[dbo].[WagonLoad] WL
JOIN [gtt].[dbo].[LinePointsOfUse] LP 
    ON LP.PointOfUseCode = WL.PointOfUseCode
JOIN [mxsrvtraca].[trazab].[cegid].[bom] CB
    ON CB.NOCTCODECP COLLATE SQL_Latin1_General_CP1_CI_AS = WL.ComponentNo COLLATE SQL_Latin1_General_CP1_CI_AS AND CB.NOCTCODOPE  COLLATE SQL_Latin1_General_CP1_CI_AS = WL.PointOfUseCode COLLATE SQL_Latin1_General_CP1_CI_AS
JOIN [gtt].[dbo].[LineProductionSchedule] LPS
ON CB.NOKTCODPF COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.PartNo COLLATE SQL_Latin1_General_CP1_CI_AS
WHERE LPS.UtcExpirationTime > GETUTCDATE() AND (WL.InWagonLoaded <> 1) --AND WL.UtcTimeStamp >= (SELECT CAST(CAST(GETUTCDATE() AS date) AS datetime))
