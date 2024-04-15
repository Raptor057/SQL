/**
 * Todos los tuneles correspondientes a los procesos asociados a una linea.
 * La informacion de esta tabla se utiliza para la trazabilidad.
 */

-- este query es para saber si los tuneles tienen trazabilidad. se tiene que agregar un registro si se agrega un tunel

SELECT * FROM dbo.LineProcessPointsOfUse 
where LineCode = 'E2'

--delete dbo.LineProcessPointsOfUse where LineCode = 'E2'

INSERT INTO dbo.LineProcessPointsOfUse (LineCode,ProcessID,PointOfUseCode,UtcEffectiveTime,UtcExpirationTime)
SELECT LineCode,'999',PointOfUseCode, GETUTCDATE(), '2099-12-31 23:59:59.997' FROM dbo.LinePointsOfUse WHERE LineCode = 'E2';