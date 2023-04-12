SELECT e.* FROM dbo.LinePointsOfUse p
JOIN dbo.PointOfUseEtis e
    ON e.PointOfUseCode = p.PointOfUseCode
    AND e.UtcUsageTime IS NOT NULL AND e.UtcExpirationTime IS NULL
WHERE p.LineCode = 'LT';