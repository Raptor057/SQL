--EXEC dbo.UspUpdateGamma '84969-10', 'LA';
--EXEC dbo.UspUpdateGamma '84970-10', 'LA';

/**
 * Obtener componentes a retornar/descargar.
 */
SELECT PointOfUseCode, CompNo, CASE WHEN LEFT(CompRev, 1) IN ('X', 'Y', '0') THEN CompRev ELSE LEFT(CompRev, 1) END FROM dbo.Gammas WHERE PartNo='84969-10' AND PartRev='LA' -- sale
EXCEPT
SELECT PointOfUseCode, CompNo, CASE WHEN LEFT(CompRev, 1) IN ('X', 'Y', '0') THEN CompRev ELSE LEFT(CompRev, 1) END FROM dbo.Gammas WHERE PartNo='84970-10' AND PartRev='LA' -- entra