--Buscar valores repetidos en una columa en sql
  SELECT EtiNo, COUNT(*) as cantidad 
FROM PointOfUseEtis 
GROUP BY EtiNo 
HAVING COUNT(*) > 1;
