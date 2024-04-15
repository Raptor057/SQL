SELECT top 10000
    [ID],
    [PointOfUseCode],
    [EtiNo],
    [ComponentNo],
    [UtcEffectiveTime],
    [UtcUsageTime],
    [UtcExpirationTime],
    [IsDepleted],
    [Comments],
    [LotNo],
    CASE 
        WHEN UtcUsageTime IS NULL AND UtcExpirationTime IS NULL AND IsDepleted = 0 THEN 'Etiqueta cargada sin uso'
        WHEN UtcUsageTime IS NOT NULL AND UtcExpirationTime IS NULL AND IsDepleted = 0 THEN 'Etiqueta cargada en uso'
        WHEN UtcUsageTime IS NULL AND UtcExpirationTime IS NOT NULL AND IsDepleted = 0 THEN 'Etiqueta retornada sin usar'
        WHEN UtcUsageTime IS NOT NULL AND UtcExpirationTime IS NOT NULL AND IsDepleted = 0 THEN 'Etiqueta retornada usada'
        WHEN UtcUsageTime IS NOT NULL AND UtcExpirationTime IS NOT NULL AND IsDepleted = 1 THEN 'Etiqueta agotada'
        ELSE 'Otra condición'
    END AS [Estado de etiquetas],
    -- Extraer el grupo 'id' usando la expresión regular modificada
   CASE 
    WHEN [EtiNo] LIKE '%[sSeE][aA][0-9]%'
         THEN SUBSTRING([EtiNo], PATINDEX('%[sSeE][aA][0-9]%', [EtiNo]) + 2, LEN([EtiNo]))
    WHEN [EtiNo] LIKE '%[eE][sS][0-9]%'
         THEN SUBSTRING([EtiNo], PATINDEX('%[eE][sS][0-9]%', [EtiNo]) + 2, LEN([EtiNo]))
    WHEN [EtiNo] LIKE '%[eE][0-9]%'
         THEN SUBSTRING([EtiNo], PATINDEX('%[eE][0-9]%', [EtiNo]) + 1, 
                        CASE WHEN CHARINDEX('-T', [EtiNo]) > 0
                             THEN CHARINDEX('-T', [EtiNo]) - PATINDEX('%[eE][0-9]%', [EtiNo]) - 1
                             ELSE LEN([EtiNo]) - PATINDEX('%[eE][0-9]%', [EtiNo])
                        END)
END AS [id],
    -- Extraer el grupo 'trasvase' y sustituir por 'N/A' si es NULL
    COALESCE(
        CASE WHEN [EtiNo] LIKE '%-[tT][0-9]%'
             THEN SUBSTRING([EtiNo], PATINDEX('%-[tT][0-9]%', [EtiNo]) + 2, LEN([EtiNo]))
        END, 'N/A'
    ) AS [trasvase]
FROM
    [gtt].[dbo].[PointOfUseEtis]
