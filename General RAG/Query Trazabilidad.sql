declare @unit_id VARCHAR(15)
SET @unit_id = '9020624'
SELECT top 10000
    t.Linea [LineName],
    t.NP_FINAL [PartNo],
    t.Modelo [Client],
    t.Telesis_no [UnitID],
    CAST(t.fecha_scan + ' ' + t.hora_scan AS DATETIME) [TimeStamp],
    e.puesto_no [PointOfUseCode],
    e.component [ComponentNo],
    bom.ARCTLIB01 [Description],
    e.rev_cc [Revision],
    e.eti_no [EtiNo],
    e.lote [LotNo],bom.NOCTCOMCPT
FROM MXSRVTRACA.TRAZAB.dbo.Trazab_WB t
LEFT JOIN MXSRVTRACA.TRAZAB.dbo.Etis_WB e WITH(NOLOCK)
    ON e.SET_ID = t.ETI_no
LEFT JOIN MXSRVTRACA.TRAZAB.cegid.bom bom
    ON bom.NOKTCODPF = t.NP_FINAL AND bom.NOKTCOMPF = RIGHT(t.Linea, 2)
    AND bom.NOCTCODOPE = e.puesto_no AND RTRIM(bom.NOCTCODECP) = e.component
    AND CASE WHEN LEFT(bom.NOCTCOMCPT, 1) IN ('X', 'Y', '0') THEN bom.NOCTCOMCPT ELSE LEFT(bom.NOCTCOMCPT, 1) END
    = CASE WHEN LEFT(e.rev_cc, 1) IN ('X', 'Y', '0') THEN e.rev_cc ELSE LEFT(e.rev_cc, 1) END
WHERE t.Telesis_no=@unit_id
ORDER BY e.puesto_no, e.component;