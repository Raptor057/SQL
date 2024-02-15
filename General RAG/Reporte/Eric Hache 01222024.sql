
SELECT
    lpou.LineCode,
    --poe.[PointOfUseCode],
    poe.[EtiNo] AS [PointOfUseEtiNo],
    wt.[id_pro_eti001],
    poe.[ComponentNo],
    --poe.[UtcEffectiveTime],
    --poe.[UtcUsageTime],
    --poe.[UtcExpirationTime],
    --poe.[IsDepleted],
    --poe.[Comments],
    poe.[LotNo],
    --wt.[id] AS [TransferID],
    --wt.[id_pro_eti001],
    CONCAT('E', wt.[id_pro_eti001], '-T', wt.[id]) AS [TransferEtiNo],
    LPS.WorkOrderCode,
    MLW.description,
    mlw.rev,
    MLT.TM_id,
    MLT.pack_time,
    MLW.Fecha
   --top 100000 poe.*,wt.*,lpou.*,lps.*,mlw.*,mlt.*
FROM [gtt].[dbo].[PointOfUseEtis] poe
RIGHT JOIN [MXSRVTRACA].[APPS].[dbo].[wh_eti001_transfer] wt ON poe.[EtiNo] = CONCAT('E', wt.[id_pro_eti001], '-T', wt.[id])
RIGHT JOIN [gtt].[dbo].LinePointsOfUse LPOU ON LPOU.PointOfUseCode = poe.PointOfUseCode
RIGHT JOIN [gtt].[dbo].LineProductionSchedule LPS ON LPS.LineCode = LPOU.LineCode AND LPS.WorkOrderCode IN ('W08080449','W08161778','W08236439','W08161682',
'W08062685','W08068458','W08068555','W08068613','W07935628','W07961402','W07935686','W08037281','W08012616','W07918599','W07961303','W07739225','W07952317',
'W07928352','W07888135','W07928409','W07927920','W07888039','W07739159','W07890255','W07878988') AND poe.UtcUsageTime >= LPS.UtcEffectiveTime AND poe.UtcExpirationTime <= LPS.UtcExpirationTime 
RIGHT JOIN [MXSRVTRACA].[TRAZAB].[dbo].[Master_labels_WB] MLW ON MLW.codew COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.WorkOrderCode AND MLW.[line] = 'WB LA' 
AND MLW.part_num IN ('85079','85079','85079-10','85564','85564-10','85564-10','85564-10','85564','85079-10') AND MLW.rev in ('A','X02A1','X03A1','Y01A','X02A2')
RIGHT JOIN [MXSRVTRACA].[TRAZAB].[dbo].[Master_lbl_TMid] MLT ON MLT.Master_id = MLW.ID AND MLW.ID is not null
WHERE wt.[id_pro_eti001] IN ('418353','418354','358725','358726','358727','358728','358729','358730','358731','358732','358733','358734','358735','358736','358737','358738','358739')
AND poe.LotNo IN ('2023-02-28','2109012051','2109302051','2111152051')
AND poe.[UtcEffectiveTime] is not null
and MLW.fecha in ('07-Dec-2023','06-Dec-2023','05-Dec-2023','30-Nov-2023','28-Nov-2023','27-Nov-2023','20-Nov-2023','16-Nov-2023','15-Nov-2023','14-Nov-2023','13-Nov-2023','08-Nov-2023','07-Nov-2023',
'06-Nov-2023','02-Nov-2023','01-Nov-2023','31-Oct-2023','30-Oct-2023','26-Oct-2023','31-Aug-2023','30-Aug-2023','29-Aug-2023','25-Aug-2023','24-Aug-2023','23-Aug-2023','22-Aug-2023','18-Aug-2023','27-Jul-2023',
'26-Jul-2023','25-Jul-2023','21-Jul-2023','20-Jul-2023','19-Jul-2023','14-Jul-2023','12-Jul-2023','07-Jul-2023','06-Jul-2023','05-Jul-2023','04-Jul-2023','30-Jun-2023','08-Jun-2023','07-Jun-2023','25-May-2023',
'23-May-2023','27-Apr-2023','26-Apr-2023','25-Apr-2023','24-Apr-2023','21-Apr-2023','20-Apr-2023','19-Apr-2023','18-Apr-2023','14-Apr-2023','13-Apr-2023','11-Apr-2023','10-Apr-2023','06-Apr-2023','05-Apr-2023',
'04-Apr-2023','30-Mar-2023','24-Mar-2023','23-Mar-2023','22-Mar-2023','21-Mar-2023','17-Mar-2023','16-Mar-2023','15-Mar-2023','14-Mar-2023','09-Mar-2023','08-Mar-2023','07-Mar-2023','06-Mar-2023','03-Mar-2023',
'02-Mar-2023','01-Mar-2023','28-Feb-2023')
--ORDER BY LPS.UtcEffectiveTime desc
