SELECT top 10000 
*,
LP.LineCode,
RTRIM(CB.NOKTCODPF)

FROM [gtt].[dbo].[LineProductionSchedule] LP
RIGHT JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB ON LP.LineCode COLLATE French_CI_AS = RTRIM(CB.NOKTCOMPF) COLLATE French_CI_AS AND PartNo COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS
RIGHT JOIN [gtt].[dbo].[LinePointsOfUse] PU ON LP.LineCode = PU.LineCode
RIGHT JOIN [gtt].[dbo].[PointOfUseEtis] UC ON PU.PointOfUseCode = UC.PointOfUseCode
WHERE LP.UtcExpirationTime > GETUTCDATE()
AND UC.IsDepleted != 1 AND UC.UtcExpirationTime IS NULL 
AND LP.PartNo = '85564-10' AND LP.LineCode = 'LA'
ORDER BY LP.LineCode, RTRIM(CB.NOCTCODOPE) ASC


  --select top 100 * from [MXSRVTRACA].[TRAZAB].[cegid].[bom]