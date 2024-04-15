-- Si es NULL entonces la ETI sigue cargada, ya sea en uso o no.
SELECT UtcExpirationTime FROM dbo.PointOfUseEtis WHERE EtiNo = 'E??????';

/**
 * Descarga o retorno de ETIs para que se pueda utilizar de nuevo.
 */
UPDATE dbo.PointOfUseEtis
SET UtcExpirationTime = GETUTCDATE()
WHERE EtiNo = '??????'
-- si el campo UtcUsageTime es nulo, se trata de descarga de material
-- si no es nulo, es un retorno
AND UtcExpirationTime IS NULL;

--SELECT * FROM dbo.LineProductionSchedule