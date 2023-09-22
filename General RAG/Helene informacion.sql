SELECT TOP (1000) 
ph.UtcTimeStamp,
ph.UnitID,
cmb.NOCTCODECP,
poe.EtiNo,
P.ID,
p.lot
--*
FROM [gtt].[dbo].[LineProductionSchedule] LPS
 JOIN [MXSRVTRACA].[TRAZAB].[dbo].[Master_labels_WB] MLW ON LPS.WorkOrderCode COLLATE SQL_Latin1_General_CP1_CI_AS = mlw.codew
 JOIN [MXSRVTRACA].[TRAZAB].[dbo].[Master_lbl_TMid] mlt on mlt.Master_id=mlw.Id
 JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] cmb ON cmb.NOKTCODPF = mlw.part_num and cmb.NOCTCODOPE ='E23'
 JOIN PointOfUseEtis poe ON poe.PointOfUseCode collate SQL_Latin1_General_CP1_CI_AS =cmb.NOCTCODOPE
 JOIN ProcessHistory PH on ph.UnitID = mlt.TM_id AND ph.ProcessID = 999
 JOIN [MXSRVTRACA].[APPS].[dbo].[pro_eti001] p ON  p.part_number =  cmb.NOCTCODECP
WHERE LPS.LineCode = 'LE' AND cmb.NOCTCODECP in ('120791','120942','120766') AND cmb.NOKTCODPF in ('87245','87244','87248') AND 
      p.id IN (
          SELECT TOP (1000)
              CASE
                  WHEN CHARINDEX('-', [EtiNo]) > 0 THEN
                      SUBSTRING([EtiNo], CHARINDEX('E', [EtiNo]) + 1, CHARINDEX('-', [EtiNo]) - CHARINDEX('E', [EtiNo]) - 1)
                  ELSE
                      SUBSTRING([EtiNo], CHARINDEX('E', [EtiNo]) + 1, LEN([EtiNo]) - CHARINDEX('E', [EtiNo]))
              END AS ExtractedData
          FROM [gtt].[dbo].[PointOfUseEtis]
          WHERE PointOfUseCode = 'E23'
      ) AND ph.UtcTimeStamp >= poe.UtcUsageTime AND PH.UtcTimeStamp <= poe.UtcExpirationTime AND PH.UtcTimeStamp >= LPS.UtcEffectiveTime AND PH.UtcTimeStamp <= LPS.UtcExpirationTime
      order by ph.UtcTimeStamp DESC




