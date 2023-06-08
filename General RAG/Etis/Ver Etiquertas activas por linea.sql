SELECT poue.*
--, c.counter_value [PackingCount], c.bin_size [Size]

FROM dbo.LinePointsOfUse lpou

JOIN dbo.PointOfUseEtis poue
    ON poue.PointOfUseCode = lpou.PointOfUseCode
    AND poue.UtcUsageTime <= GETUTCDATE() AND poue.UtcExpirationTime IS NULL

-- LEFT JOIN [MXSRVTRACA].[TRAZAB].[dbo].[eti_packing_counters] c
--     ON c.eti_no COLLATE SQL_Latin1_General_CP1_CI_AS = poue.EtiNo

WHERE lpou.LineCode = 'LB'
--and poue.PointOfUseCode = 'E25' 
order by PointOfUseCode asc


--=======================
-- SELECT poue.PointOfUseCode, poue.EtiNo, poue.ComponentNo, poue.UtcEffectiveTime, poue.UtcUsageTime

-- FROM dbo.LinePointsOfUse lpou

-- JOIN dbo.PointOfUseEtis poue
--     ON poue.PointOfUseCode = lpou.PointOfUseCode
--     AND poue.UtcUsageTime <= GETUTCDATE() AND poue.UtcExpirationTime IS NULL

-- LEFT JOIN [MXSRVTRACA].[TRAZAB].[dbo].[eti_packing_counters] c
--     ON c.eti_no COLLATE SQL_Latin1_General_CP1_CI_AS = poue.EtiNo

-- WHERE lpou.LineCode = 'LO' 
-- order by PointOfUseCode asc


--=======================


--SELECT * from PointOfUseEtis WHERE ComponentNo = '44419'

--UPDATE PointOfUseEtis set PointOfUseCode = 'E25' WHERE ComponentNo = '44419'
--DELETE PointOfUseEtis WHERE id = '77885'


SELECT poue.* 
FROM dbo.LinePointsOfUse lpou
JOIN dbo.PointOfUseEtis poue
    ON poue.PointOfUseCode = lpou.PointOfUseCode
    AND poue.UtcUsageTime <= GETUTCDATE() AND poue.UtcExpirationTime IS NULL
WHERE lpou.LineCode = 'LB'
order by PointOfUseCode asc


