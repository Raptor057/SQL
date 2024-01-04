/*
DB GTT
Este Query sirve para borrar ordenes utilizadas en Gtt.

***TEORIA***
Cuando los numeros en total se duplica en las cantidades de transmisiones en la UI de Empaque
puede ser porque hay una orden repetida para la misma linea el mismo dia, se soluciona borrando la que no esta activa.
*/
DECLARE @LineCode VARCHAR (4)
DECLARE @WorkOrderCode VARCHAR (25)
SET @LineCode = ''
SET @WorkOrderCode = ''
SELECT * FROM [gtt].[dbo].[LineProductionSchedule] WHERE (LineCode = @LineCode OR WorkOrderCode = @WorkOrderCode) AND UtcEffectiveTime < GETUTCDATE() ORDER BY UtcEffectiveTime DESC

--Delete [gtt].[dbo].[LineProductionSchedule] WHERE UtcEffectiveTime = ''