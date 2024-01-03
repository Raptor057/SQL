/*
DB GTT
Con este Query podemos ver las etiquetas en general cargadas/en uso/ descargadas
*/
DECLARE @Line VARCHAR (4)
DECLARE @EtiNo VARCHAR (50)
DECLARE @ComponentNo VARCHAR (50)

SET @Line = 'A' -- Aqui poner el tunel completo, o la linea ejemplo LA 
SET @EtiNo = ''
SET @ComponentNo = ''

SELECT TOP 1000 * FROM [gtt].[dbo].[PointOfUseEtis]
WHERE (PointOfUseCode LIKE (CONCAT('%',@Line,'%')) OR EtiNo = @EtiNo OR @ComponentNo = @ComponentNo)
-- AND UtcUsageTime IS NULL AND UtcExpirationTime IS NULL                          -- 1) Descomentar esta linea para ver las etiquetas cargadas pero no usadas
-- AND UtcUsageTime IS NOT NULL AND UtcExpirationTime IS NULL                      -- 2) Descomentar esta linea para ver las etiquetas usadas en momento
-- AND UtcUsageTime is NULL AND UtcExpirationTime IS NOT NULL and IsDepleted != 1  -- 3) Descomentar esta linea para ver las etiquetas descargadas mas no consumidas ni usadas (Retorno sin usar)
-- AND UtcExpirationTime IS NOT NULL and IsDepleted != 1                           -- 4) Descomentar esta linea para ver las etiquetas descargadas mas no consumidas ni usadas (Retorno en general)
-- AND UtcExpirationTime IS NOT NULL and IsDepleted != 0                           -- 5) Descomentar esta linea para ver las etiquetas ya consumidas.
-- ORDER BY PointOfUseCode ASC,UtcEffectiveTime DESC, UtcUsageTime DESC --Descomentar esto solo si lo quires ver organizado por Linea -> fecha de carga -> fecha de uso 
 ORDER BY UtcExpirationTime DESC

-- Aqui tienes que poner la fecha de descarga, por lo general todos los componentes tendran igual la fecha de descarga esto lo puedes ver descomentando el punto 4 del query 
--Descomentar esto para hacer ese cambio
--UPDATE [gtt].[dbo].[PointOfUseEtis] SET UtcExpirationTime = NULL WHERE UtcExpirationTime = '' AND PointOfUseCode LIKE (CONCAT('',REPLACE(@Line, 'L', ''),''))

