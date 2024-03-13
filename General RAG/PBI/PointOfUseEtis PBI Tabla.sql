SELECT 
    POUE.[ID]
    ,LPOU.LineCode
    ,POUE.[PointOfUseCode]
    ,POUE.[EtiNo]
    ,POUE.[ComponentNo]
    ,dbo.UfnToLocalTime(POUE.[UtcEffectiveTime]) AS [CstEffectiveTime]
    ,dbo.UfnToLocalTime(POUE.[UtcUsageTime]) AS [CstUsageTime]
    ,dbo.UfnToLocalTime(POUE.[UtcExpirationTime]) AS [CstExpirationTime]
    ,POUE.[IsDepleted]
    , CASE 
    WHEN POUE.UtcUsageTime IS NULL AND POUE.UtcExpirationTime IS NULL AND POUE.IsDepleted = 0 THEN 'Etiqueta cargada sin uso'
    WHEN POUE.UtcUsageTime IS NOT NULL AND POUE.UtcExpirationTime IS NULL AND POUE.IsDepleted = 0 THEN 'Etiqueta cargada en uso'
    WHEN POUE.UtcUsageTime IS NULL AND POUE.UtcExpirationTime IS NOT NULL AND POUE.IsDepleted = 0 THEN 'Etiqueta retornada sin usar'
    WHEN POUE.UtcUsageTime IS NOT NULL AND POUE.UtcExpirationTime IS NOT NULL AND POUE.IsDepleted = 0 THEN 'Etiqueta retornada usada'
    WHEN POUE.UtcUsageTime IS NOT NULL AND POUE.UtcExpirationTime IS NOT NULL AND POUE.IsDepleted = 1 THEN 'Etiqueta agotada'
    ELSE 'Otra condición'
    END AS [Estado de etiquetas]
    ,POUE.[Comments]
    ,POUE.[LotNo]
,    CASE
        WHEN CHARINDEX('-T', [EtiNo]) > 0 THEN
            SUBSTRING([EtiNo], CHARINDEX('E', [EtiNo]) + 1, CHARINDEX('-T', [EtiNo]) - CHARINDEX('E', [EtiNo]) - 1)
        WHEN [EtiNo] LIKE 'ES%' THEN
            SUBSTRING([EtiNo], 3, LEN([EtiNo]) - 2)
        WHEN CHARINDEX('E', [EtiNo]) > 0 THEN
            SUBSTRING([EtiNo], CHARINDEX('E', [EtiNo]) + 1, LEN([EtiNo]) - CHARINDEX('E', [EtiNo]))

        ELSE
            NULL -- Otra condición si es necesario
    END AS Etiqueta,
    CASE
        WHEN CHARINDEX('-T', [EtiNo]) > 0 THEN
            SUBSTRING([EtiNo], CHARINDEX('-T', [EtiNo]) + 2, LEN([EtiNo]) - CHARINDEX('-T', [EtiNo]) - 1)
        WHEN CHARINDEX('T', [EtiNo]) > 0 THEN
            SUBSTRING([EtiNo], CHARINDEX('T', [EtiNo]) + 1, LEN([EtiNo]) - CHARINDEX('T', [EtiNo]))
        ELSE
            NULL -- Otra condición si es necesario
    END AS Trasvace
  FROM [gtt].[dbo].[PointOfUseEtis] POUE
  INNER JOIN [gtt].[dbo].[LinePointsOfUse] LPOU ON POUE.PointOfUseCode = LPOU.PointOfUseCode