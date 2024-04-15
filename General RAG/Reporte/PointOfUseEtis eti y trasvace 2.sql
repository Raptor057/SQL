SELECT 
        [ID]
      ,[SnapShotID]
      ,[LineCode]
      ,[PointOfUseCode]
      ,[EtiNo]
      ,[MasterEtiNo]
      ,[ComponentNo]
      ,[ComponentRev]
      ,[ComponentDescription]
      ,[LotNo]
      ,[UtcTimeStamp],
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
END AS [EtiID],
    -- Extraer el grupo 'trasvase' y sustituir por 'N/A' si es NULL
    COALESCE(
        CASE WHEN [EtiNo] LIKE '%-[tT][0-9]%'
             THEN SUBSTRING([EtiNo], PATINDEX('%-[tT][0-9]%', [EtiNo]) + 2, LEN([EtiNo]))
        END, ''
    ) AS [trasvase]
  FROM [gtt].[dbo].[ComponentsSnapShot]