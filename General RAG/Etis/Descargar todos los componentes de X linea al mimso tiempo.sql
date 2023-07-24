SELECT TOP (1000) [ID]
      ,[PointOfUseCode]
      ,[EtiNo]
      ,[ComponentNo]
      ,[UtcEffectiveTime]
      ,[UtcUsageTime]
      ,[UtcExpirationTime]
      ,[IsDepleted]
      ,[Comments]
      ,[LotNo]
  FROM [gtt].[dbo].[PointOfUseEtis] WHERE 
  PointOfUseCode LIKE ('%J%')
--AND UtcUsageTime is NULL and UtcExpirationTime is NULL and IsDepleted != 1
--AND UtcUsageTime is NOT NULL and UtcExpirationTime is NULL and IsDepleted != 1
AND UtcExpirationTime is NULL and IsDepleted != 1 ORDER BY PointOfUseCode ASC


-- SELECT * FROM PointOfUseEtisV2  WHERE 
-- PointOfUseCode LIKE ('%E%')
-- AND UtcExpirationTime is NULL and IsDepleted != 1 ORDER BY PointOfUseCode ASC

  --and UtcExpirationTime is NULL
  --AND UtcUsageTime is not NULL

--   UPDATE PointOfUseEtis SET UtcExpirationTime = GETUTCDATE() WHERE   PointOfUseCode LIKE ('%I%')
--   and
--   UtcExpirationTime is NULL
--   AND UtcUsageTime is not NULL

--   UPDATE PointOfUseEtis SET UtcExpirationTime = GETUTCDATE() WHERE
--     PointOfUseCode LIKE ('%I%')
--   and UtcUsageTime is NULL and UtcExpirationTime is NULL and IsDepleted != 1

   UPDATE PointOfUseEtis SET UtcExpirationTime = GETUTCDATE() WHERE
     PointOfUseCode LIKE ('%J%')
AND UtcExpirationTime is NULL and IsDepleted != 1

-- UPDATE PointOfUseEtisV2 SET UtcExpirationTime = GETUTCDATE() WHERE
--      PointOfUseCode LIKE ('%E%')
-- AND UtcExpirationTime is NULL and IsDepleted != 1
