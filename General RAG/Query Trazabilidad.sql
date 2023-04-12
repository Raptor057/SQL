/*
Chat GPT
Este código es una consulta SQL que devuelve información sobre un producto que ha sido escaneado en el sistema de seguimiento de producción.
La primera línea del código declara una variable @unit_id y la inicializa con el valor '9020624'.
La consulta utiliza varias tablas para obtener información del producto. La tabla principal es Trazab_WB, que contiene información sobre el escaneo del producto. 
La tabla Etis_WB contiene información sobre la etiqueta del producto, y la tabla bom contiene información sobre los componentes del producto.
La consulta selecciona varias columnas de las tablas, incluyendo el nombre de la línea de producción, el número de parte, el modelo, el identificador del producto, 
la fecha y hora del escaneo, el código del punto de uso, el número de componente, la descripción, la revisión, el número de etiqueta y el número de lote.
La cláusula WHERE filtra los resultados por el identificador del producto que se especifica en la variable @unit_id.
La cláusula ORDER BY ordena los resultados por el código del punto de uso y el número de componente.
*/
-- declare @unit_id VARCHAR(15)
-- SET @unit_id = '9020624'
-- SELECT top 10000
--     t.Linea [LineName],
--     t.NP_FINAL [PartNo],
--     t.Modelo [Client],
--     t.Telesis_no [UnitID],
--     CAST(t.fecha_scan + ' ' + t.hora_scan AS DATETIME) [TimeStamp],
--     e.puesto_no [PointOfUseCode],
--     e.component [ComponentNo],
--     bom.ARCTLIB01 [Description],
--     e.rev_cc [Revision],
--     e.eti_no [EtiNo],
--     e.lote [LotNo],bom.NOCTCOMCPT
-- FROM MXSRVTRACA.TRAZAB.dbo.Trazab_WB t
-- LEFT JOIN MXSRVTRACA.TRAZAB.dbo.Etis_WB e WITH(NOLOCK)
--     ON e.SET_ID = t.ETI_no
-- LEFT JOIN MXSRVTRACA.TRAZAB.cegid.bom bom
--     ON bom.NOKTCODPF = t.NP_FINAL AND bom.NOKTCOMPF = RIGHT(t.Linea, 2)
--     AND bom.NOCTCODOPE = e.puesto_no AND RTRIM(bom.NOCTCODECP) = e.component
--     AND CASE WHEN LEFT(bom.NOCTCOMCPT, 1) IN ('X', 'Y', '0') THEN bom.NOCTCOMCPT ELSE LEFT(bom.NOCTCOMCPT, 1) END
--     = CASE WHEN LEFT(e.rev_cc, 1) IN ('X', 'Y', '0') THEN e.rev_cc ELSE LEFT(e.rev_cc, 1) END
-- WHERE t.Telesis_no=@unit_id
-- ORDER BY e.puesto_no, e.component;



-- select top 1000 * from MXSRVTRACA.TRAZAB.dbo.Trazab_WB
-- where NP_FINAL = '84969' and Telesis_no = '9496210'

-- select * from MXSRVTRACA.TRAZAB.dbo.Etis_WB
-- --where NP_FINAL = '84969-10'
-- where NP_FINAL = '84969-10'
-- --where NP_FINAL = '85691'
-- order by fecha desc

-- SELECT TOP 1 SET_ID FROM MXSRVTRACA.TRAZAB.dbo.Etis_WB WITH(NOLOCK) WHERE linea='WB LA' AND status=0

-- select top 3000 * from MXSRVTRACA.TRAZAB.dbo.Etis_WB where linea = 'WB LA' order by fecha desc

--SET_ID = 'LA275926'

-- SELECT @unitID AS Telesis_no, @lineName AS Linea, @operation AS no_empleado, 
--        FORMAT(GETDATE(), 'dd-MMM-yyyy') AS fecha_scan, FORMAT(GETDATE(), 'hh:mm tt') AS hora_scan,
--        (SELECT TOP 1 SET_ID FROM dbo.Etis_WB WITH(NOLOCK) WHERE linea=@lineName AND status=0) AS ETI_no, 
--        @model AS MODELO, @partNo AS NP_FINAL, @codew AS codew

--select top 1000 * from MXSRVTRACA.TRAZAB.cegid.bom


declare @unit_id VARCHAR(15)
--SET @unit_id = '9496210'
SET @unit_id = '9504397'
SELECT
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
    AND CASE WHEN LEFT(bom.NOCTCOMCPT, 1) IN ('X', 'Y', '0','1','2') THEN bom.NOCTCOMCPT ELSE LEFT(bom.NOCTCOMCPT, 1) END
    = CASE WHEN LEFT(e.rev_cc, 1) IN ('X', 'Y', '0','1','2') THEN e.rev_cc ELSE LEFT(e.rev_cc, 1) END
-- LEFT JOIN PointOfUseEtis a
-- ON 
WHERE t.Telesis_no=@unit_id
ORDER BY e.puesto_no, e.component;


declare @unit_id VARCHAR(15)
--SET @unit_id = '9505060'
--SET @unit_id = '9505061'
--SET @unit_id = '9505060'
--SET @unit_id = '7304464'
SET @unit_id = '9504397'
SELECT top 3000 *  FROM MXSRVTRACA.TRAZAB.dbo.Trazab_WB t
-- WHERE
--  t.Telesis_no=@unit_id
--  and
-- Linea = 'WB LA'
-- and
-- NP_FINAL = '87109-10'
WHERE Telesis_NO < '9510592'
order by Telesis_no DESC


--Linea A
select top 3000 * from MXSRVTRACA.TRAZAB.dbo.Etis_WB 
where 
SET_ID like ('LC203290')
and
linea = 'WB LC'
ORDER BY puesto_no, component

SELECT top 1 * FROM MXSRVTRACA.TRAZAB.dbo.Etis_WB  WITH(NOLOCK) WHERE linea='WB LO' AND status=0

SELECT  * FROM MXSRVTRACA.TRAZAB.dbo.Etis_WB  WITH(NOLOCK) WHERE eti_no = 'E360714-T937951'

--Line C
select top 3000 * from MXSRVTRACA.TRAZAB.dbo.Etis_WB where SET_ID = 'LB244608' ORDER BY puesto_no, component
