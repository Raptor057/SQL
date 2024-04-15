-- SELECT TOP (1) 
--        PH.[UtcTimeStamp]
--       ,PH.[UnitID]
--       ,PH.[LineCode]
--       ,LPS.PartNo
--       ,LPS.Revision
--       ,CS.SnapShotID
--   FROM [gtt].[dbo].[ProcessHistory] PH
--   INNER JOIN gtt.dbo.LineProductionSchedule LPS ON LPS.LineCode = PH.LineCode AND PH.UtcTimeStamp > LPS.UtcEffectiveTime AND LPS.UtcExpirationTime > GETUTCDATE()
--   INNER JOIN gtt.dbo.ComponentsSnapShot CS ON CS.LineCode = LPS.LineCode AND CS.LineCode = PH.LineCode AND CS.UtcTimeStamp > LPS.UtcEffectiveTime 
--   WHERE PH.ProcessID = 999
--   AND PH.LineCode = 'LB' 
--   ORDER BY PH.UtcTimeStamp desc,CS.UtcTimeStamp DESC
DECLARE @lineCode NCHAR(2)
DECLARE @unitID bigint

SET @unitID = (select top 1 UnitID from ProcessHistory WHERE LineCode != 'LN' order by UtcTimeStamp desc)
SET @lineCode = (select top 1 LineCode from ProcessHistory WHERE UnitID = @unitID order by UtcTimeStamp desc)

--EXECUTE [dbo].[UpsInsertUnitIDShapshotHistory] @lineCode,@unitID

-- SELECT TOP 1
--     CS.SnapShotID
--       ,PH.[UnitID]
--       ,PH.[LineCode]
--       ,LPS.PartNo
--       ,LPS.Revision
-- FROM [gtt].[dbo].[ProcessHistory] PH
-- INNER JOIN gtt.dbo.LineProductionSchedule LPS ON LPS.LineCode = PH.LineCode AND PH.UtcTimeStamp > LPS.UtcEffectiveTime AND LPS.UtcExpirationTime > GETUTCDATE()
-- INNER JOIN gtt.dbo.ComponentsSnapShot CS ON CS.LineCode = LPS.LineCode AND CS.LineCode = PH.LineCode AND CS.UtcTimeStamp > LPS.UtcEffectiveTime 
-- WHERE PH.ProcessID = 999
-- AND PH.LineCode = @lineCode 
-- AND PH.UnitID = @unitID
-- ORDER BY PH.UtcTimeStamp DESC,CS.UtcTimeStamp DESC

-- SELECT top 1 UnitID
--   FROM [gtt].[dbo].[ProcessHistory] WHERE ProcessID = 999 AND UtcTimeStamp > GETUTCDATE()-1 AND LineCode != 'LN'
--    ORDER by  UtcTimeStamp desc

--    SELECT TOP (1)[SnapShotID]
--   FROM [gtt].[dbo].[ComponentsSnapShot] WHERE LineCode = @lineCode 
--   ORDER BY UtcTimeStamp desc

--   INSERT INTO UnitIDShapshotHistory
--   (SnapShotID,UnitID,LineCode,PartNo,Revision)
--   SELECT TOP 1
--     RTRIM(CS.SnapShotID)
--       ,RTRIM(PH.[UnitID])
--       ,RTRIM(PH.[LineCode])
--       ,RTRIM(LPS.PartNo)
--       ,RTRIM(LPS.Revision)
-- FROM [gtt].[dbo].[ProcessHistory] PH
-- INNER JOIN gtt.dbo.LineProductionSchedule LPS ON LPS.LineCode = PH.LineCode AND PH.UtcTimeStamp > LPS.UtcEffectiveTime AND LPS.UtcExpirationTime > GETUTCDATE()
-- INNER JOIN gtt.dbo.ComponentsSnapShot CS ON CS.LineCode = LPS.LineCode AND CS.LineCode = PH.LineCode AND CS.UtcTimeStamp > LPS.UtcEffectiveTime 
-- WHERE PH.ProcessID = 999
-- AND PH.LineCode = @lineCode 
-- AND PH.UnitID = @unitID
-- ORDER BY PH.UtcTimeStamp DESC,CS.UtcTimeStamp DESC


-- delete UnitIDShapshotHistory
-- DBCC CHECKIDENT('UnitIDShapshotHistory', RESEED, 0);

-- SELECT * FROM UnitIDShapshotHistory

-- SELECT TOP (1) dbo.UfnToLocalTime([UtcTimeStamp])
--       ,[UnitID]
--       ,[ProcessID]
--       ,[LineCode]
--   FROM [gtt].[dbo].[ProcessHistory] WHERE LineCode != 'LN' and ProcessID = 999
--   order BY UtcTimeStamp DESC