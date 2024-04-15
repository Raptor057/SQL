-- SELECT TOP (1000) [ID]
--       ,[PointOfUseCode]
--       ,[EtiNo]
--       ,[ComponentNo]
--       ,[UtcEffectiveTime]
--       ,[UtcUsageTime]
--       ,[UtcExpirationTime]
--       ,[IsDepleted]
--       ,[Comments]
--       ,[LotNo]
--   FROM [gtt].[dbo].[PointOfUseEtis] 
--WHERE 
--   UtcExpirationTime is NULL
--   --AND UtcUsageTime IS NULL 
--   AND PointOfUseCode LIKE ('%F02%') 
--   AND IsDepleted != 1
--   ORDER BY PointOfUseCode,UtcEffectiveTime ASC


--   SELECT PointOfUseCode,ComponentNo,COUNT(EtiNo) FROM [gtt].[dbo].[PointOfUseEtis] 
--   WHERE 
--   UtcExpirationTime is NULL
--   AND PointOfUseCode LIKE ('%A%') AND IsDepleted != 1
--   GROUP BY PointOfUseCode,ComponentNo,EtiNo
--   ORDER BY PointOfUseCode,UtcEffectiveTime asc

--   SELECT 
--     PS.PartNo,
--     PS.Revision,
--     PU.[ComponentNo],
--     PU.[PointOfUseCode],
--     COUNT(CASE WHEN PU.[UtcUsageTime] IS NULL THEN 1 END) AS CantidadEtinos
-- FROM [gtt].[dbo].[PointOfUseEtis] PU
-- RIGHT JOIN [gtt].[dbo].[LinePointsOfUse] LP ON LP.PointOfUseCode = PU.PointOfUseCode
-- RIGHT JOIN [gtt].[dbo].[LineProductionSchedule] PS ON PS.LineCode = LP.LineCode
-- WHERE 
--     PU.[UtcExpirationTime] IS NULL
--     --AND PU.[PointOfUseCode] LIKE ('%O%')
--     AND PS.LineCode = 'LO'
--     AND PU.[IsDepleted] != 1
--     AND PS.UtcExpirationTime > GETUTCDATE()
-- GROUP BY 
-- PS.PartNo,
-- PS.Revision,
-- PU.[ComponentNo]
-- ,PU.[PointOfUseCode]
-- ORDER BY CantidadEtinos asc;


SELECT 
RTRIM(CB.NOCTCODECP) AS [Componente]
,RTRIM(CB.NOCTCOMCPT) AS [Rev]
,PU.PointOfUseCode AS [Tunel]
--,LEFT(PU.PointOfUseCode,1) AS [Letra]
,RTRIM(CB.ARCTLIB01) AS [Descripcion]
,RTRIM(CB.APKSTDPACK) AS [STDPACK]
,COUNT(CASE WHEN PU.[UtcUsageTime] IS NULL THEN 1 END) AS CantidadEtinos
,RTRIM(CB.NOCTTYPOPE) AS [Capacidad]
--,*--NOCTTYPOPE 
FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB
RIGHT JOIN [gtt].[dbo].[PointOfUseEtis] PU ON PU.ComponentNo COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOCTCODECP) AND  Pu.PointOfUseCode COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOCTCODOPE)
RIGHT JOIN [gtt].[dbo].[LineProductionSchedule] PS ON PS.LineCode COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOKTCOMPF) AND PS.PartNo COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOKTCODPF)   
WHERE 
    PU.UtcExpirationTime IS NULL
    --AND PS.LineCode = 'LO' 
    --AND PS.LineCode = @lineCode
    AND PU.IsDepleted != 1 
    AND PS.UtcExpirationTime > GETUTCDATE()
GROUP BY
    PS.PartNo
    ,PS.Revision
    ,RTRIM(CB.NOCTCODECP)
    ,PU.PointOfUseCode
    ,RTRIM(CB.NOCTTYPOPE)
    ,RTRIM(CB.ARCTLIB01)
    ,RTRIM(CB.NOCTCOMCPT)
    ,RTRIM(CB.APKSTDPACK)
ORDER BY CantidadEtinos,STDPACK asc


WITH CTE AS (
    SELECT 
        RTRIM(CB.NOCTCODECP) AS [Componente]
        ,RTRIM(CB.NOCTCOMCPT) AS [Rev]
        ,PU.PointOfUseCode AS [Tunel]
        ,RTRIM(CB.ARCTLIB01) AS [Descripcion]
        ,RTRIM(CB.APKSTDPACK) AS [STDPACK]
        ,COUNT(CASE WHEN PU.[UtcUsageTime] IS NULL THEN 1 END) AS CantidadEtinos
        ,RTRIM(CB.NOCTTYPOPE) AS [Capacidad]
    FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB
    RIGHT JOIN [gtt].[dbo].[PointOfUseEtis] PU ON PU.ComponentNo COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOCTCODECP) AND  Pu.PointOfUseCode COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOCTCODOPE)
    RIGHT JOIN [gtt].[dbo].[LineProductionSchedule] PS ON PS.LineCode COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOKTCOMPF) AND PS.PartNo COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOKTCODPF)   
    WHERE 
        PU.UtcExpirationTime IS NULL
        --AND PS.LineCode = 'LO' 
        --AND PS.LineCode = @lineCode
        AND PU.IsDepleted != 1 
        AND PS.UtcExpirationTime > GETUTCDATE()
    GROUP BY
        PS.PartNo
        ,PS.Revision
        ,RTRIM(CB.NOCTCODECP)
        ,PU.PointOfUseCode
        ,RTRIM(CB.NOCTTYPOPE)
        ,RTRIM(CB.ARCTLIB01)
        ,RTRIM(CB.NOCTCOMCPT)
        ,RTRIM(CB.APKSTDPACK)
)
SELECT 
    [Componente]
    ,[Rev]
    ,[Tunel]
    ,[Descripcion]
    ,[STDPACK]
    ,CantidadEtinos
    ,[Capacidad]
    ,[Capacidad] - CantidadEtinos AS [Valance]
FROM CTE
WHERE Capacidad - CantidadEtinos > 0
ORDER BY CantidadEtinos, STDPACK ASC;
