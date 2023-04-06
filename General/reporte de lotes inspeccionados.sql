SELECT
    DENSE_RANK() OVER(PARTITION BY CAST(r.created_at AS DATE) ORDER BY e.part_number, e.rev, e.lot) day_lot_idx,
    ROW_NUMBER() OVER(PARTITION BY CAST(r.created_at AS DATE), e.part_number, e.rev, e.lot ORDER BY e.id) lot_eti_idx,
    COUNT(*) OVER(PARTITION BY CAST(r.created_at AS DATE), e.part_number, e.rev, e.lot) total_received_lot_etis,
    SUM(CASE WHEN e.is_approved = 1 THEN 1 ELSE 0 END) OVER(PARTITION BY CAST(r.created_at AS DATE), e.part_number, e.rev, e.lot) total_released_lot_etis,
    SUM(CASE WHEN e.is_approved = 0 THEN 1 ELSE 0 END) OVER(PARTITION BY CAST(r.created_at AS DATE), e.part_number, e.rev, e.lot) total_pending_lot_etis,
    e.id, e.part_number, e.rev, r.[order], r.line, r.qty_total, e.lot, e.supplier, r.created_at, e.is_verified, e.is_approved, e.cert_ontime, r.string_code
FROM radio_reception r
INNER JOIN pro_eti001 e
    ON e.id = r.id_label
WHERE r.created_at >= (SELECT MIN(created_at) FROM pro_eti001 WHERE is_approved = 0)
AND CAST(r.created_at AS DATE) IN ('2021-09-15', '2021-09-20')
ORDER BY CAST(r.created_at AS DATE), e.part_number, e.rev, e.lot;