--SELECT TOP (1) * FROM [gtt].[dbo].[LineProductionSchedule] WHERE LineCode = 'LN' order by UtcExpirationTime DESC

SELECT TOP (100) * FROM [gtt].[dbo].[LineProductionSchedule] 
--WHERE UtcExpirationTime = '2099-12-31 23:59:59.997'
WHERE UtcExpirationTime >= '2099-12-31 23:59:59.997'
order by UtcExpirationTime DESC
