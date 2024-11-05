DECLARE @UnitID BIGINT = 10335159,
        @PartNo NVARCHAR(50) = NULL,
        @Rev NVARCHAR(50) = NULL,
        @SnapShotID NVARCHAR(50) = NULL,
        @LineCode NVARCHAR(50) = NULL,
        @PointOfUseCode NVARCHAR(50) = NULL,
        @EtiNoID NVARCHAR(50) = NULL,
        @EtiNo NVARCHAR(50) = NULL,
        @MasterEtiNo NVARCHAR(50) = NULL,
        @ComponentNo NVARCHAR(50) = NULL,
        @ComponentRev NVARCHAR(50) = NULL,
        @ComponentDescription NVARCHAR(50) = NULL,
        @LotNo NVARCHAR(50) = NULL,
        @MasterID BIGINT

SELECT
    ush.UnitID,
    mlt.[Master_id] AS [MasterID],
    ush.PartNo,
    RTRIM(ush.Revision) AS [Rev],
    css.[SnapShotID],
    css.[LineCode],
    css.[EtiNo],
    css.[MasterEtiNo],
    css.[ComponentNo],
    css.[ComponentRev],
    css.[ComponentDescription],
    css.[LotNo],
   dbo.UfnToLocalTime(css.[UtcTimeStamp]) as [LocalTime]
FROM [gtt].[dbo].[ComponentsSnapShot] css
INNER JOIN [gtt].[dbo].[UnitIDShapshotHistory] USH
ON css.SnapShotID = USH.SnapShotID
INNER JOIN [MXSRVTRACA].[TRAZAB].[dbo].[Master_lbl_TMid] mlt
ON ush.UnitID = CAST(mlt.[TM_id] AS BIGINT) AND ISNUMERIC(mlt.[TM_id]) != 0
INNER JOIN [MXSRVTRACA].[TRAZAB].[dbo].[Master_labels_WB] mlw
ON mlw.id = mlt.Master_id AND mlw.[is_active] = 1
WHERE (1=1)
  AND (@UnitID IS NULL OR ush.UnitID = @UnitID)
  AND (@PartNo IS NULL OR ush.PartNo = @PartNo)
  AND (@MasterID IS NULL OR mlt.[Master_id] = @PartNo)
  AND (@Rev IS NULL OR RTRIM(ush.Revision) = @Rev)
  AND (@SnapShotID IS NULL OR css.SnapShotID = @SnapShotID)
  AND (@LineCode IS NULL OR css.LineCode = @LineCode)
  AND (@EtiNo IS NULL OR css.EtiNo = @EtiNo)
  AND (@MasterEtiNo IS NULL OR css.MasterEtiNo = @MasterEtiNo)
  AND (@ComponentNo IS NULL OR css.ComponentNo = @ComponentNo)
  AND (@ComponentRev IS NULL OR css.ComponentRev = @ComponentRev)
  AND (@ComponentDescription IS NULL OR css.ComponentDescription = @ComponentDescription)
  AND (@LotNo IS NULL OR css.LotNo = @LotNo)
  ORDER BY ush.UtcTimeStamp DESC
