DECLARE @UnitID bigint
set @UnitID = 10853556

SELECT TOP (1000) 
CSS.[SnapShotID]
,CSS.[LineCode]
,CSS.[PointOfUseCode]
,CSS.[EtiNoID]
,CSS.[EtiNo]
,CSS.[MasterEtiNo]
,CSS.[ComponentNo]
,CSS.[ComponentRev]
,CSS.[ComponentDescription]
,CSS.[LotNo]
,CSS.[UtcTimeStamp]
,dbo.UfnToLocalTime(UISH.[UtcTimeStamp]) AS [Local Time]
,UISH.[SnapShotID]
,UISH.[UnitID]
,UISH.[LineCode]
,UISH.[PartNo]
,UISH.[Revision]
FROM [gtt].[dbo].[ComponentsSnapShot] CSS
INNER JOIN [gtt].[dbo].[UnitIDShapshotHistory] UISH
ON CSS.SnapShotID = UISH.SnapShotID 
WHERE UISH.[UnitID] = @UnitID