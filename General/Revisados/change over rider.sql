DECLARE
    @COMPANY_CODE INT = 300,
    @DISABLED INT = 17,
    @GAMMA NVARCHAR(50) = 'LD',
    @cur_part_no NVARCHAR(50) = 'GT87140',
    @new_part_no NVARCHAR(50) = '87129',
    @cur_model_no NVARCHAR(50) = 'GTUSA0',
    @full_line_code NVARCHAR(50) = 'RIDER LE';

--UPDATE APPS.dbo.pro_prod_units SET modelo = @model_no WHERE letter = RIGHT(@line_code, 2);

WITH cur_bom AS (
    SELECT ROW_NUMBER() OVER(PARTITION BY NOCTCODECP ORDER BY NOCTCODECP) i, *
    FROM MXSRVCEGID.PMI.dbo.NOMENC a WITH(NOLOCK)
    JOIN MXSRVCEGID.PMI.dbo.ARTICLE art
        ON art.ARKTSOC = a.NOKTSOC AND art.ARKTCODART = a.NOCTCODECP AND art.ARKTCOMART = a.NOCTCOMCPT AND art.ARCTCODFAM IN ('CMP','PMQ','PM', 'DIV') AND art.ARCTFATN != @DISABLED
    WHERE a.NOKTSOC = @COMPANY_CODE
    AND a.NOKTCOMPF = @GAMMA
    AND a.NOKTCODPF = @cur_part_no
), new_bom AS (
    SELECT ROW_NUMBER() OVER(PARTITION BY NOCTCODECP ORDER BY NOCTCODECP) i, *
    FROM MXSRVCEGID.PMI.dbo.NOMENC a WITH(NOLOCK)
    JOIN MXSRVCEGID.PMI.dbo.ARTICLE art
        ON art.ARKTSOC = a.NOKTSOC AND art.ARKTCODART = a.NOCTCODECP AND art.ARKTCOMART = a.NOCTCOMCPT AND art.ARCTCODFAM IN ('CMP','PMQ','PM', 'DIV') AND art.ARCTFATN != @DISABLED
    WHERE a.NOKTSOC = @COMPANY_CODE
    AND a.NOKTCOMPF = @GAMMA
    AND a.NOKTCODPF = @new_part_no
)
--UPDATE t SET t.eti_status = 1
SELECT c.NOCTCODECP, c.NOCTCOMCPT
FROM cur_bom c
LEFT JOIN new_bom n
    ON n.i = c.i AND n.NOCTCODECP = c.NOCTCODECP AND n.NOCTCOMCPT = c.NOCTCOMCPT
JOIN dbo.trazab_rider t
    ON t.eti_status = 0
    AND LTRIM(RTRIM(c.NOCTCODECP)) = t.component_number COLLATE French_CI_AS
    AND LTRIM(RTRIM(c.NOCTCOMCPT)) = t.cmp_rev COLLATE French_CI_AS
    AND t.NP_FINAL = @cur_part_no AND t.modelo = @cur_model_no AND t.linea = @full_line_code
WHERE n.NOCTCODECP IS NULL;

--select * from Trazab_Rider where eti_status=0 and modelo='GTUSA0' and linea='rider le' and component_number<>'' and NP_FINAL='GT87140'