SELECT
PS.LineCode AS [Linea]
,PS.PartNo AS [Numero de Parte]
,PS.Revision AS [Modelo Rev]
,PU.EtiNo AS [EtiNo]
,RTRIM(CB.NOCTCODECP) AS [Componente]
,RTRIM(CB.NOCTCOMCPT) AS [Rev]
,PU.PointOfUseCode AS [Tunel]
,RTRIM(CB.ARCTLIB01) AS [Descripcion]
,CASE WHEN PU.[UtcUsageTime] IS NULL THEN 'En espera de escaneo'
    WHEN PU.[UtcUsageTime] IS NOT NULL THEN 'En uso' END AS [Estatus]
FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB
RIGHT JOIN [gtt].[dbo].[PointOfUseEtis] PU ON PU.ComponentNo COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOCTCODECP) AND  Pu.PointOfUseCode COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOCTCODOPE)
RIGHT JOIN [gtt].[dbo].[LineProductionSchedule] PS ON PS.LineCode COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOKTCOMPF) AND PS.PartNo COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOKTCODPF)   
WHERE 
    PU.UtcExpirationTime IS NULL
    AND PU.IsDepleted != 1 
    AND PS.UtcExpirationTime > GETUTCDATE()
ORDER BY Tunel asc,UtcUsageTime desc
