/*
Este Query sirve para ver todas las ordenes activas en el sistema GTT
*/
SELECT TOP (1000) * FROM [gtt].[dbo].[LineProductionSchedule] WHERE UtcExpirationTime > GETUTCDATE()

/* 
Este Query sirve para dar de baja una Orden activa en el GT Traza v2 esto se usa solo para la linea N y la E (en el caso de Rider)
*/
UPDATE [gtt].[dbo].[LineProductionSchedule] SET UtcExpirationTime = GETUTCDATE() WHERE UtcExpirationTime > GETUTCDATE() AND WorkOrderCode = ''
