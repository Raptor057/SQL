-- SELECT * FROM [gtt].[dbo].[LineProductionSchedule] WHERE UtcExpirationTime >= '2099-12-31 23:00:00.000'
-- ORDER BY LineCode ASC

SELECT * FROM LineProductionSchedule where LineCode = 'LB' --and UtcEffectiveTime <= GETUTCDATE() AND UtcExpirationTime > GETUTCDATE() 
ORDER BY WorkOrderCode desc--WHERE LineCode = 'LB' AND UtcExpirationTime >= '2099-12-31 23:59:59.000'


SELECT COUNT(WorkOrderCode) AS [CountWorkOrderCode] FROM LineProductionSchedule WHERE LineCode = 'LB' AND UtcExpirationTime >= '2099-12-31 23:59:00.000'

SELECT * FROM LineProductionSchedule WHERE UtcExpirationTime >= '2099-12-31 23:59:00.000'


SELECT *  FROM LineProductionSchedule WHERE LineCode = 'LB' AND UtcExpirationTime >= '2099-12-31 23:59:59.000'


SELECT WorkOrderCode FROM dbo.LineProductionSchedule WHERE LineCode = 'LB' AND UtcEffectiveTime <= GETUTCDATE() AND UtcExpirationTime > GETUTCDATE();

