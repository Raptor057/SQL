/*ESTE QUERY OBTIENE LAS LINEAS QUE COMPARTEN EL MISMO TUNEL SOLO INGRESANDO EL TUNEL Y COMPONENTE*/
SELECT  DISTINCT(s.LineCode) FROM dbo.LineProductionSchedule s
JOIN dbo.LineGamma g
    ON g.PartNo = s.PartNo AND g.LineCode = s.LineCode AND g.PointOfUseCode = @pointOfUseCode AND g.CompNo = @componentNo
WHERE s.UtcExpirationTime >= GETUTCDATE()