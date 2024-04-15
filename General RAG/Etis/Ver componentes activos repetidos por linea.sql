--Ver los componentes repetidos por linea

SELECT poue.ComponentNo, poue.PointOfUseCode, COUNT(*) AS Count
FROM dbo.LinePointsOfUse lpou
JOIN dbo.PointOfUseEtis poue ON poue.PointOfUseCode = lpou.PointOfUseCode
    AND poue.UtcUsageTime <= GETUTCDATE() AND poue.UtcExpirationTime IS NULL
WHERE lpou.LineCode = 'LB'
GROUP BY poue.ComponentNo, poue.PointOfUseCode
HAVING COUNT(*) > 1
ORDER BY poue.ComponentNo, poue.PointOfUseCode