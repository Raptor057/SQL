DECLARE
    @fecha_expiracion DATETIME = NULL, -- '2099-12-31 23:59:59.997'
    @eti_no NVARCHAR(50) = '';

--SELECT e.*
UPDATE e SET e.UtcExpirationTime = NULLIF(@fecha_expiracion, GETUTCDATE())
FROM dbo.PointOfUseEtis e
WHERE e.EtiNo = @eti_no
AND e.UtcExpirationTime IS NULL;