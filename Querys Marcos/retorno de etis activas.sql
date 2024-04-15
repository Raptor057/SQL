/**
 * Tomar todas las etiquetas activas en una linea y ponerles la fecha
 * de retorno.
 */
SELECT *
--UPDATE e SET e.UtcExpirationTime = GETUTCDATE()
FROM dbo.LinePointsOfUse p -- todos los tuneles de la linea
JOIN dbo.PointOfUseEtis e -- todas las ETIs que corresponden con los tuneles
    ON e.PointOfUseCode = p.PointOfUseCode AND e.UtcUsageTime IS NOT NULL AND e.UtcExpirationTime IS NULL
WHERE p.LineCode = 'LA'
ORDER BY e.PointOfUseCode;