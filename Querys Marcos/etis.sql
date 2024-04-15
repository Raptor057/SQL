/**
 * Obtener todas las etiquetas cargadas en la linea (si no tienen hora de uso estan activas para
 * trazabilidad)
 */
SELECT e.*
FROM LinePointsOfUse p
JOIN PointOfUseEtis e
    -- Hacer match con el tunel de la linea
    ON e.PointOfUseCode = p.PointOfUseCode
    -- Considerar que la ETI este en la linea, o sea que no tenga una hora de expiracion
    -- (todas deben de tener hora efectiva o de carga)
    AND e.UtcExpirationTime IS NULL
    -- Todas las ETIs que tienen un valor (o sea, no nulo) es por que se utilizaron
    -- y como no tienen hora de expiracion tampoco, son ETIs en uso en la trazabilidad.
    -- (remover el comentario para que solo se devuelvan los componentes parte del set activo)
    --AND UtcUsageTime IS NOT NULL
WHERE p.LineCode='LC';