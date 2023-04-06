DECLARE @line NVARCHAR(50) = 'LB', @workday DATE = DATEADD(DAY, 0, GETDATE());

-- get line schedule data
WITH line_settings (line_id, line_code, moment, part_no, codew) AS (
    SELECT id, letter, CAST(FORMAT(@workday, 'yyyyMMdd') + ' 12:06:01' AS DATETIME), modelo, codew
    FROM APPS.dbo.pro_prod_units WITH(NOLOCK)
    --WHERE letter = @line
), schedule (model_no, codew, part_no, line_id, line_code, moment, effective_time, expiration_time) AS (
    SELECT client_name, s.codew, s.part_no, s.line_id, s.line_code, s.moment, start_date, ISNULL(end_at, s.moment)
	FROM line_settings s
	JOIN APPS.dbo.pro_production wo WITH(NOLOCK)
		ON wo.id_line = s.line_id AND s.part_no = wo.part_number AND s.codew = wo.codew
		AND wo.start_date <= s.moment AND (wo.end_at IS NULL OR s.moment < wo.end_at)
)
SELECT
    bom.NOKTCOMPF [line],
	bom.NOKTCODPF [part_no],
	effective_time, expiration_time,
	CASE WHEN SUM(CASE WHEN pu.Id IS NULL THEN 0 ELSE 1 END + CASE WHEN eti.eti_no IS NULL THEN 0 ELSE 1 END) > 0 THEN 1 ELSE 0 END [is_ready]
FROM schedule s 

JOIN TRAZAB.cegid.bom WITH(NOLOCK)
    ON bom.NOKTCODPF  = s.part_no
    AND bom.NOKTCOMPF = s.line_code

LEFT JOIN TRAZAB.dbo.tbl_Point_use pu WITH(NOLOCK)
    ON pu.linea       = bom.NOKTCOMPF
    AND pu.NP_final   = bom.NOKTCODPF
    AND pu.Punto_uso  = bom.NOCTCODOPE
    AND pu.Componente = bom.NOCTCODECP
	AND pu.is_used    = 0

LEFT JOIN TRAZAB.dbo.Etis_WB eti WITH(NOLOCK)
    ON eti.status     = 0
	AND eti.MODELO    = s.model_no
    AND eti.component = bom.NOCTCODECP
    AND s.line_code   = bom.NOKTCOMPF
    AND eti.NP_FINAL  = bom.NOKTCODPF

GROUP BY bom.NOKTCOMPF, bom.NOKTCODPF, effective_time, expiration_time
ORDER BY line;