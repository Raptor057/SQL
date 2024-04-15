SELECT *
--UPDATE e SET e.UtcExpirationTime = GETUTCDATE()
FROM dbo.LinePointsOfUse p
JOIN dbo.PointOfUseEtis e
    ON e.PointOfUseCode = p.PointOfUseCode AND e.UtcUsageTime IS NOT NULL AND e.UtcExpirationTime IS NULL
WHERE p.LineCode = 'LA'
ORDER BY e.PointOfUseCode;