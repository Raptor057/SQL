CREATE VIEW PowerBi_MastersLocationReport AS
SELECT
    CAST(m.Id AS VARCHAR) AS [MasterID],
    m.line AS [LineName],
    m.part_num AS [Model],
    m.qty AS [Quantity],
    -- m.is_active AS IsActive, -- No incluido en la vista
    uss.fecha AS [UsShippingDate],
    cuss.fecha AS CusShippingDate,
    CASE 
        WHEN uss.Id IS NOT NULL AND cuss.Id IS NULL THEN 'En Bodega'
        WHEN uss.Id IS NOT NULL AND cuss.Id IS NOT NULL THEN 'En Cliente'
        WHEN uss.Id IS NULL AND cuss.Id IS NOT NULL THEN 'Directo a Cliente'
        ELSE 'En Planta'
    END AS [LocationStatus]
FROM mxsrvtraca.trazab.dbo.Master_labels_WB m WITH (NOLOCK)
LEFT JOIN mxsrvtraca.trazab.dbo.shipments uss
    ON uss.master_id = m.Id AND uss.Destino = 'US'
LEFT JOIN mxsrvtraca.trazab.dbo.shipments cuss
    ON cuss.master_id = m.Id AND cuss.Destino = 'CUS'
WHERE m.is_active = 1
