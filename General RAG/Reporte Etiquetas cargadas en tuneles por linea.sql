SELECT
LPS.[PartNo] AS [Numero de parte]
,LPS.[Revision] AS [Rev]
,LPS.[LineCode] AS [Codigo de linea]
,LPOU.PointOfUseCode AS [Tunel]
,POUE.ComponentNo AS [Componente]
,POUE.EtiNo AS [Etiqueta]
,POUE.UtcEffectiveTime AS [Fecha de carga]
,POUE.UtcUsageTime AS [Fecha de uso]
,POUE.UtcExpirationTime AS [Fecha de expiracion]
,POUE.IsDepleted AS [Estado de la Etiqueta]
,CASE
        WHEN POUE.UtcUsageTime IS NULL THEN 'En tunel sin uso'
        WHEN POUE.UtcUsageTime IS NOT NULL THEN 'En tunel en uso'
    END AS [Estado de uso]
FROM [gtt].[dbo].[LineProductionSchedule] LPS
INNER JOIN [gtt].[dbo].[LinePointsOfUse] LPOU
ON LPOU.LineCode = LPS.LineCode
INNER JOIN [gtt].[dbo].[PointOfUseEtis] POUE
ON LPOU.PointOfUseCode = POUE.PointOfUseCode
INNER JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB
ON CB.NOKTCODPF COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.[PartNo] 
AND CB.NOKTCOMPF COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.[LineCode] 
AND CB.NOCTCODOPE COLLATE SQL_Latin1_General_CP1_CI_AS = POUE.PointOfUseCode 
AND CB.NOCTCODECP COLLATE SQL_Latin1_General_CP1_CI_AS = POUE.ComponentNo 
WHERE
LPS.UtcExpirationTime > GETUTCDATE()
AND POUE.UtcExpirationTime IS NULL
AND POUE.IsDepleted = 0
AND LPS.LineCode = 'LO'
GROUP BY
LPS.[PartNo]
,LPS.[Revision]
,LPS.[LineCode]
,LPOU.PointOfUseCode
,POUE.ComponentNo
,POUE.EtiNo
,POUE.UtcEffectiveTime
,POUE.UtcUsageTime
,POUE.UtcExpirationTime
,POUE.IsDepleted
ORDER BY LPOU.PointOfUseCode ASC,POUE.ComponentNo ASC