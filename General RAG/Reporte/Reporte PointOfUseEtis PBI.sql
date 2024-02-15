SELECT
      POUE.[ID]
      ,LPOU.LineCode
      ,POUE.[PointOfUseCode]
      ,POUE.[EtiNo]
      ,POUE.[ComponentNo]
      ,dbo.UfnToLocalTime(POUE.[UtcEffectiveTime]) AS [UtcEffectiveTime]
      ,dbo.UfnToLocalTime(POUE.[UtcUsageTime]) AS [UtcUsageTime]
      ,dbo.UfnToLocalTime(POUE.[UtcExpirationTime]) AS [UtcExpirationTime]
      ,POUE.[IsDepleted]
      ,POUE.[Comments]
      ,POUE.[LotNo]
      ,CASE
      WHEN POUE.[UtcUsageTime] IS NULL AND POUE.[UtcExpirationTime] IS NULL THEN 'Etiqueta cargada'
      WHEN POUE.[UtcExpirationTime] IS NULL AND POUE.UtcUsageTime IS NOT NULL THEN 'Etiqueta activa'
      WHEN POUE.UtcExpirationTime IS NOT NULL AND POUE.IsDepleted = 1 THEN 'Etiqueta agotada'
      WHEN POUE.UtcExpirationTime IS NOT NULL AND POUE.IsDepleted = 0 THEN 'Etiqueta retornada'
      ELSE 'Otro estado' -- Puedes cambiar esto según tu lógica si hay otros casos
    END AS [EstadoEtiqueta]
FROM [gtt].[dbo].[PointOfUseEtis] POUE
INNER JOIN  [gtt].[dbo].LinePointsOfUse LPOU ON POUE.PointOfUseCode = LPOU.PointOfUseCode