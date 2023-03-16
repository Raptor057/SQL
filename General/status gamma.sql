DECLARE @line NVARCHAR(50) = 'LO', @workday DATE = DATEADD(DAY, 0, GETDATE());

-- get line schedule data
WITH line_settings (line_id, line_code, moment, part_no, codew) AS (
    SELECT id, letter, CAST(FORMAT(@workday, 'yyyyMMdd') + ' 12:06:01' AS DATETIME), modelo, codew
    FROM APPS.dbo.pro_prod_units WITH(NOLOCK)
    WHERE letter = @line
), schedule (model_no, codew, part_no, line_id, line_code, moment) AS (
    SELECT client_name, s.codew, s.part_no, s.line_id, s.line_code, s.moment
	FROM line_settings s
	JOIN APPS.dbo.pro_production wo WITH(NOLOCK)
		ON wo.id_line = s.line_id AND s.part_no = wo.part_number AND s.codew = wo.codew
		AND wo.start_date <= s.moment AND (wo.end_at IS NULL OR s.moment < wo.end_at)
)
SELECT
    bom.NOKTCOMPF [line],
	bom.NOKTCODPF [part_no],
    bom.i          [component_idx],
	bom.NOCTCODECP [component_no],
	bom.NOCTCOMCPT [component_rev],
	bom.NOCTCODOPE [point_of_use],
	bom.NOCTTYPOPE [load_capacity],
    bom.APKSTDPACK [standard_pack_quantity],
    bom.ARCTCODFAM [family],
    (
        SELECT COUNT(*) FROM TRAZAB.dbo.tbl_Point_use pu WITH(NOLOCK)
        WHERE pu.linea    = bom.NOKTCOMPF
        AND pu.NP_final   = bom.NOKTCODPF
        AND pu.Punto_uso  = bom.NOCTCODOPE
        AND pu.Componente = bom.NOCTCODECP
		AND pu.is_used    = 0) [load_count],
		eti.eti_no [active_eti_no]
FROM TRAZAB.cegid.bom WITH(NOLOCK)
CROSS JOIN schedule s 
OUTER APPLY (
    SELECT TOP 1 *
    FROM TRAZAB.dbo.Etis_WB eti WITH(NOLOCK)
    WHERE eti.status  = 0 AND eti.MODELO = s.model_no
    AND eti.component = bom.NOCTCODECP
    AND s.line_code   = bom.NOKTCOMPF
    AND eti.NP_FINAL  = bom.NOKTCODPF
    ORDER BY eti.id DESC) eti

WHERE bom.NOKTCODPF = s.part_no
    AND bom.NOKTCOMPF = s.line_code

ORDER BY point_of_use, component_no, component_rev;