DECLARE @linea CHAR(2) = 'LJ', @numero NVARCHAR(50) = '85691';

/**
 * Pasar el material cargado.
 */
-- INSERT INTO PointOfUseEtis(LotNo, PointOfUseCode, EtiNo, ComponentNo, UtcEffectiveTime)
-- SELECT lote, punto_uso, eti_no, componente, CAST(fecha + ' ' + hora AS DATETIME)
-- FROM MXSRVTRACA.TRAZAB.dbo.Tbl_Point_use
-- WHERE linea=@linea AND is_used=0
-- AND eti_no COLLATE SQL_Latin1_General_CP1_CI_AS NOT IN (SELECT etino FROM PointOfUseEtis)
-- AND len(eti_no) < 16 AND NP_Final=@numero
-- ORDER BY punto_uso, componente;

WITH t AS (
    select lote, puesto_no, eti_No, component, min(cast(fecha as datetime)) d, min(cast(fecha as datetime)) d2
    from mxsrvtraca.trazab.dbo.etis_wb with(nolock) where linea='WB ' + @linea and status=0
    group by lote, puesto_no, eti_No, component
), v AS (
    select row_number() over(partition by eti_no order by eti_no, puesto_no asc) i, * from t
)
--INSERT INTO PointOfUseEtis(LotNo, PointOfUseCode, EtiNo, ComponentNo, UtcEffectiveTime, UtcUsageTime)
SELECT DISTINCT v.lote, v.puesto_no, v.eti_no, rtrim(v.component), v.d, v.d2 FROM v
WHERE i = 1
AND v.eti_no COLLATE SQL_Latin1_General_CP1_CI_AS NOT IN (SELECT etino FROM PointOfUseEtis);

-- delete e
-- from PointOfUseEtis e
-- join LinePointsOfUse P
--     on p.LineCode='LT' AND p.PointOfUseCode != 'BM2'
-- where e.PointOfUseCode=p.PointOfUseCode