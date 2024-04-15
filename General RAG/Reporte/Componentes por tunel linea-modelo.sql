SELECT
    LPOU.PointOfUseCode AS [Tunel],
    --POE.ComponentNo,
    CB.NOCTCODECP AS [# Componente],
    CB.NOCTTYPOPE AS [Capacidad del tunel],
    COALESCE(COUNT(POE.[PointOfUseCode]), 0) AS [Componentes cargados]
FROM
    [gtt].[dbo].LinePointsOfUse LPOU
INNER JOIN
    [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB ON CB.NOKTCOMPF COLLATE SQL_Latin1_General_CP1_CI_AS = LPOU.LineCode
                                                AND CB.NOCTCODOPE COLLATE SQL_Latin1_General_CP1_CI_AS = LPOU.PointOfUseCode
LEFT JOIN
    [gtt].[dbo].[PointOfUseEtis] POE ON POE.PointOfUseCode = LPOU.PointOfUseCode
                                          AND POE.ComponentNo = CB.NOCTCODECP COLLATE SQL_Latin1_General_CP1_CI_AS
WHERE
    CB.NOKTCODPF = 'GT87146'
    AND CB.NOKTCOMPF = 'LE'
    AND POE.UtcExpirationTime IS NULL
GROUP BY
    LPOU.PointOfUseCode,
    --POE.ComponentNo,
    CB.NOCTCODECP,
    CB.NOCTTYPOPE
    ORDER BY [Componentes cargados] asc,LPOU.PointOfUseCode ASC
