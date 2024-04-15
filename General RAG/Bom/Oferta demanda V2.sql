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
--   select EtiNo, ComponentNo,COUNT(EtiNo) FROM [gtt].[dbo].[PointOfUseEtis] WHERE UtcExpirationTime is NULL
--   GROUP BY EtiNo, ComponentNo

SELECT 
    PS.PartNo
    ,PS.Revision
    --PU.ComponentNo
    ,RTRIM(CB.NOCTCODECP) AS [Componente]
    ,PU.PointOfUseCode
    --,COUNT(PU.EtiNo) AS [Count Etis]
    --,SUM(CASE WHEN PU.EtiNo IS NOT NULL THEN 1 ELSE 0 END) AS [Count Etis]
    ,COUNT(CASE WHEN PU.[UtcUsageTime] IS NULL THEN 1 END) AS CantidadEtinos
    ,RTRIM(CB.NOCTTYPOPE) AS [Capacidad]
    ,RTRIM(CB.ARCTLIB01) AS [Descripcion]
    FROM [gtt].[dbo].[PointOfUseEtis] PU
    RIGHT JOIN [gtt].[dbo].[LinePointsOfUse] LP ON LP.PointOfUseCode = PU.PointOfUseCode
    RIGHT JOIN [gtt].[dbo].[LineProductionSchedule] PS ON PS.LineCode = LP.LineCode
    RIGHT JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB ON PU.PointOfUseCode COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOCTCODOPE) COLLATE SQL_Latin1_General_CP1_CI_AS AND PS.PartNo COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS AND PS.LineCode COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOKTCOMPF) COLLATE SQL_Latin1_General_CP1_CI_AS
WHERE 
    PU.UtcExpirationTime IS NULL
    AND PS.LineCode = 'LO' 
    AND PU.IsDepleted != 1 
    AND PS.UtcExpirationTime > GETUTCDATE()
    --AND  PU.UtcUsageTime IS NULL 
   --GROUP BY PU.PointOfUseCode,RTRIM(CB.NOCTTYPOPE),PS.PartNo,PS.Revision,RTRIM(CB.ARCTLIB01),RTRIM(CB.NOCTCODECP)
GROUP BY 
    PS.PartNo
    ,PS.Revision
    ,RTRIM(CB.NOCTCODECP)
    ,PU.PointOfUseCode
    ,RTRIM(CB.NOCTTYPOPE)
    ,RTRIM(CB.ARCTLIB01)
   ORDER BY 
   PU.PointOfUseCode
   ,RTRIM(CB.NOCTCODECP) asc 
