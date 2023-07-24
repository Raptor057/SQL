SELECT top 1000 
CONVERT(varchar,dbo.UfnToLocalTime(lp.UtcEffectiveTime),100) as [Inicio],
LP.PartNo,
--PU.PointOfUseCode,
RTRIM(CB.NOCTCODOPE) AS [Tunel],

RTRIM(CB.NOCTTYPOPE) AS [Capacidad],
P.ComponentNo,
CONVERT(varchar,dbo.UfnToLocalTime(P.UtcEffectiveTime),100) as [Carga],
CONVERT(varchar,dbo.UfnToLocalTime(P.UtcUsageTime),100) as [Uso],
CONVERT(varchar,dbo.UfnToLocalTime(P.UtcExpirationTime),100) as [Descarga]
From PointOfUseEtis P
RIGHT JOIN [gtt].[dbo].[LinePointsOfUse] PU ON PU.PointOfUseCode = P.PointOfUseCode
RIGHT JOIN [gtt].[dbo].[LineProductionSchedule] LP ON LP.LineCode = PU.LineCode
RIGHT JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB ON LP.LineCode COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOKTCOMPF) COLLATE SQL_Latin1_General_CP1_CI_AS AND LP.PartNo COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS
AND P.PointOfUseCode COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOCTCODOPE) COLLATE SQL_Latin1_General_CP1_CI_AS AND RTRIM(P.ComponentNo) COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOCTCODECP) COLLATE SQL_Latin1_General_CP1_CI_AS
WHERE P.IsDepleted != 1 AND P.UtcExpirationTime IS NULL --AND UtcUsageTime is not NULL
AND LP.UtcExpirationTime > GETUTCDATE()
AND LP.LineCode = 'LA'
ORDER BY CB.NOCTCODOPE ASC

--RTRIM()

--select dbo.UfnToLocalTime(GETUTCDATE())

-- select 
-- CONVERT(varchar,dbo.UfnToLocalTime(P.UtcEffectiveTime),9) as [MMM DD YYYY hh:mm:ss:mmm(AM/PM)]
-- CONVERT(varchar,dbo.UfnToLocalTime(P.UtcUsageTime),9) as [MMM DD YYYY hh:mm:ss:mmm(AM/PM)]
-- CONVERT(varchar,dbo.UfnToLocalTime(P.UtcExpirationTime),9) as [MMM DD YYYY hh:mm:ss:mmm(AM/PM)]