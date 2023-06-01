SELECT TOP (1000) * FROM [gtt].[dbo].[PointOfUseEtis] 
WHERE PointOfUseCode LIKE ('%BM1%') AND ComponentNo = '42706' AND IsDepleted != 1 and UtcUsageTime is not NULL AND UtcExpirationTime IS NOT NULL order by UtcExpirationTime DESC