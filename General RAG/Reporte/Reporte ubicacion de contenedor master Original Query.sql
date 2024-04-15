--/-/-/-/-/-/-/-/-/-/-/-
--Original
--DataSet1
SELECT
    'M' + CAST(m.Id AS VARCHAR) [MasterID],
    m.line [LineName],
    m.part_num [Model],
    m.qty [Quantity],
    m.is_active IsActive,
    uss.fecha [UsShippingDate],
    cuss.fecha CusShippingDate
FROM mxsrvtraca.trazab.dbo.Master_labels_WB m WITH (NOLOCK)
LEFT JOIN mxsrvtraca.trazab.dbo.shipments uss
    ON uss.master_id = m.Id AND uss.Destino = 'US'
LEFT JOIN mxsrvtraca.trazab.dbo.shipments cuss
    ON cuss.master_id = m.Id AND cuss.Destino = 'CUS'

WHERE m.is_active = 1
AND (
    (uss.Id IS NULL AND cuss.Id IS NULL AND @filter = 0) -- en planta
    OR
    (uss.Id IS NOT NULL AND cuss.Id IS NULL AND @filter = 1) -- en bodega
    OR
    (uss.Id IS NOT NULL AND cuss.Id IS NOT NULL AND @filter = 2) -- en cliente
)
AND uss.fecha BETWEEN @us_shipping_from AND @us_shipping_to
AND m.line IN (@line_name)
AND m.part_num IN (@model)

--/-/-/-/-/-/-/-
--LineName
SELECT
    DISTINCT m.line [LineName]
FROM mxsrvtraca.trazab.dbo.Master_labels_WB m WITH (NOLOCK)
LEFT JOIN mxsrvtraca.trazab.dbo.shipments uss
    ON uss.master_id = m.Id AND uss.Destino = 'US'
LEFT JOIN mxsrvtraca.trazab.dbo.shipments cuss
    ON cuss.master_id = m.Id AND cuss.Destino = 'CUS'

WHERE m.is_active = 1
AND (
    (uss.Id IS NULL AND cuss.Id IS NULL AND @filter = 0) -- en planta
    OR
    (uss.Id IS NOT NULL AND cuss.Id IS NULL AND @filter = 1) -- en bodega
    OR
    (uss.Id IS NOT NULL AND cuss.Id IS NOT NULL AND @filter = 2) -- en cliente
)
AND uss.fecha BETWEEN @us_shipping_from AND @us_shipping_to

--/-/-/-/-/-/-/-/-
--ModelsDataSet
SELECT
    DISTINCT m.part_num [Model]
FROM mxsrvtraca.trazab.dbo.Master_labels_WB m WITH (NOLOCK)
LEFT JOIN mxsrvtraca.trazab.dbo.shipments uss
    ON uss.master_id = m.Id AND uss.Destino = 'US'
LEFT JOIN mxsrvtraca.trazab.dbo.shipments cuss
    ON cuss.master_id = m.Id AND cuss.Destino = 'CUS'

WHERE m.is_active = 1
AND (
    (uss.Id IS NULL AND cuss.Id IS NULL AND @filter = 0) -- en planta
    OR
    (uss.Id IS NOT NULL AND cuss.Id IS NULL AND @filter = 1) -- en bodega
    OR
    (uss.Id IS NOT NULL AND cuss.Id IS NOT NULL AND @filter = 2) -- en cliente
)
AND uss.fecha BETWEEN @us_shipping_from AND @us_shipping_to
AND m.line IN (@line_name)