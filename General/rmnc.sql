WITH months AS (
    SELECT * FROM (VALUES(1, 'ENE'),(2, 'FEB'),
    (3, 'MAR'),(4, 'ABR'),(5, 'MAY'),(6, 'JUN'),
    (7, 'JUL'),(8, 'AGO'),(9, 'SEP'),(10, 'OCT'),
    (11, 'NOV'),(12, 'DIC'))t([no], [name])
)
SELECT
    CASE WHEN DATEPART(MONTH, rmnc.fecha) < 6
        THEN CAST(DATEPART(YEAR, rmnc.fecha) - 1 AS NVARCHAR) + ' - ' + CAST(DATEPART(YEAR, rmnc.fecha) AS NVARCHAR)
        ELSE CAST(DATEPART(YEAR, rmnc.fecha) AS NVARCHAR) + ' - ' + CAST(DATEPART(YEAR, rmnc.fecha) + 1 AS NVARCHAR)
    END                     [Temporada],
    rmnc.RMNC_ID            [No.],
    m.name                  [Mes],
    rmnc.part_number        [No. de Parte],
    rmnc.qty_lote           [Cantidad Detenida],
    rmnc.elaboro            [Requerido por],
    rmnc.area_reporta       [Area a aplicarse],
    CAST(NULL AS NVARCHAR)  [Dim / Apariencia],
    rmnc.dim_ref            [Caracteristica],
    rmnc.apar_esp           [Especificacion],
    rmnc.apar_actual        [Actual],
    CAST(NULL AS NVARCHAR)  [Disposicion],
    rmnc.fecha              [Fecha de apertura],
    DATEPART(MONTH, rmnc.fecha) [Mes apertura],
    DATEPART(WEEK, rmnc.fecha) [Semana apertura],
    CASE WHEN rmnc.medio_detec_prod = 1 THEN 'SI' ELSE 'NO' END [Medio de detección en producción],
    CAST(NULL AS NVARCHAR) [Ubicación fisica del reporte],
    CAST(NULL AS NVARCHAR) [Acciones pendientes],
    CAST(NULL AS INT) [Tiempo total del sorteo],
    CAST(NULL AS INT) [Tiempo total del retrabajo],
    CASE WHEN rmnc.is_closed = 0 THEN 'ABIERTA' ELSE 'CERRADA' END [Status],
    CASE WHEN rmnc.is_closed = 0 THEN 'PENDIENTE' ELSE CAST(rmnc.fecha_c AS NVARCHAR) END [Fecha de cierre],
    rmnc.[comments] [Comentarios]
FROM dbo.tbl_rmnc rmnc
JOIN months m ON m.no = DATEPART(MONTH, rmnc.fecha)
WHERE rmnc.area_reporta = 'MOLDEO' AND rmnc.fecha >= '20210601' AND '20210630' <= rmnc.fecha
ORDER BY rmnc.fecha;