SELECT
SH.UnitID
,CS.SnapShotID
,SH.PartNo
,CS.LineCode
,RTRIM(SH.Revision) AS [Revision]
,CS.ComponentNo
,CS.ComponentRev
,CS.PointOfUseCode
,CS.EtiNo
,CS.MasterEtiNo
,CS.ComponentDescription
,SH.UtcTimeStamp
  FROM [gtt].[dbo].[UnitIDShapshotHistory] SH
  INNER JOIN [gtt].[dbo].ComponentsSnapShot CS ON SH.SnapShotID = CS.SnapShotID AND SH.LineCode = CS.LineCode
  WHERE SH.UnitID = (select top 1 UnitID from ProcessHistory WHERE LineCode !='LN' AND LineCode !='LF' and ProcessID = 999 ORDER BY UtcTimeStamp DESC)
  ORDER BY CS.PointOfUseCode ASC


  SELECT TOP (1) [UtcTimeStamp]
      ,[UnitID]
      ,[ProcessID]
      ,[LineCode]
  FROM [gtt].[dbo].[ProcessHistory] WHERE LineCode !='LN' AND LineCode !='LF' order BY UtcTimeStamp desc