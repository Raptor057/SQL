DECLARE @filter INT
SET @filter = 4

DECLARE @us_shipping_to DATETIME
DECLARE @us_shipping_from DATETIME
set @us_shipping_to = GETDATE()
set @us_shipping_from = GETDATE()-80

SELECT top 1000
        CASE
        WHEN (uss.Id IS NULL AND cuss.Id IS NULL) THEN 'En Planta'
        WHEN (uss.Id IS NOT NULL AND cuss.Id IS NULL) THEN 'En Bodega'
        WHEN (uss.Id IS NOT NULL AND cuss.Id IS NOT NULL) THEN 'En Cliente'
        WHEN (uss.Id IS NULL AND cuss.Id IS NOT NULL) THEN 'Directo a Cliente'
        ELSE 'Otro'
    END AS [Ubicacion],
    'M' + CAST(m.Id AS VARCHAR) [MasterID],
    uss.Id, 
    cuss.Id,
    m.line [LineName],
    m.part_num [Model],
    m.qty [Quantity],
    m.is_active IsActive,
    uss.fecha [UsShippingDate],
    cuss.fecha CusShippingDate,
    'M' as [M],
    m.*,
    'USS' as [USS],
    uss.*,
    'CUSS' as [CUSS],
    cuss.*
FROM mxsrvtraca.trazab.dbo.Master_labels_WB m WITH (NOLOCK)
LEFT JOIN mxsrvtraca.trazab.dbo.shipments uss
    ON uss.master_id = m.Id AND uss.Destino = 'US'
LEFT JOIN mxsrvtraca.trazab.dbo.shipments cuss
    ON cuss.master_id = m.Id AND cuss.Destino = 'CUS'
WHERE 
m.is_active = 1

-- AND m.Id IN ('58961',
-- '58963',
-- '58965',
-- '58968',
-- '58972',
-- '58976',
-- '58979',
-- '58983',
-- '58986',
-- '58991',
-- '58994',
-- '58999',
-- '59002',
-- '59007',
-- '59014',
-- '59018',
-- '59023',
-- '59029',
-- '59032',
-- '59036',
-- '59040',
-- '59044',
-- '59051')

AND (
    (uss.Id IS NULL AND cuss.Id IS NULL AND @filter = 0) -- en planta
    OR
    (uss.Id IS NOT NULL AND cuss.Id IS NULL AND @filter = 1) -- en bodega
    OR
    (uss.Id IS NOT NULL AND cuss.Id IS NOT NULL AND @filter = 2) -- en cliente
    OR
    (uss.Id IS NULL AND cuss.Id IS NOT NULL AND @filter = 3) -- Directo a cliente
    OR
    (@filter = 4) -- Todas
)
 --AND uss.fecha BETWEEN @us_shipping_from AND @us_shipping_to
  AND m.fecha BETWEEN @us_shipping_from AND @us_shipping_to
-- AND m.line IN (@line_name)
--AND m.line IN ('WB LO')
-- AND m.part_num IN (@model)
--AND m.part_num IN ('85503')
order BY m.Id desc



