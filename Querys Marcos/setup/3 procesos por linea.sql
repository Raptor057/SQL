/**
 * Todos los tuneles correspondientes a los procesos asociados a una linea.
 * La informacion de esta tabla se utiliza para la trazabilidad.
 */

-- este query es para saber si los tuneles tienen trazabilidad. se tiene que agregar un registro si se agrega un tunel

SELECT * FROM dbo.LineProcessPointsOfUse 

where LineCode = 'LO'