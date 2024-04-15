-- SELECT * FROM dbo.LineProductionSchedule s
-- JOIN dbo.LineGamma g
--     ON g.PartNo = s.PartNo AND g.LineCode = s.LineCode AND g.PointOfUseCode = 'BM2' AND g.CompNo = '43914'
-- WHERE s.UtcExpirationTime >= '2099-12-31 23:59:59.997'


-- SELECT *  from dbo.LineGamma g
--      --AND g.PointOfUseCode = 'A22' AND g.CompNo = '15822'
-- WHERE g.PointOfUseCode = 'A22' AND g.CompNo = '15822' --AND PartNo = '85006-10'--s.UtcExpirationTime >= '2099-12-31 23:59:59.997'



SELECT pue.* from PointOfUseEtis pue 
RIGHT JOIN LinePointsOfUse lpu ON lpu.PointOfUseCode = pue.PointOfUseCode
WHERE pue.UtcExpirationTime is NULL  AND pue.EtiNo = 'E426943-T1160789' AND pue.ComponentNo = '00609'--AND pue.UtcUsageTime is not NULL 
ORDER BY ID desc