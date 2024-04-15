SELECT TOP (1000) 
    PP.id_line,
    LP.LineCode,
    LP.WorkOrderCode,
    LP.PartNo,
    LP.Revision
  FROM [gtt].[dbo].[LineProductionSchedule] LP
  JOIN [mxsrvtraca].[APPS].[dbo].[pro_production] PP ON PP.codew COLLATE SQL_Latin1_General_CP1_CI_AS = LP.WorkOrderCode
  WHERE PP.is_stoped = 0 AND PP.is_running = 1 AND PP.is_finished = 0 
  --AND LP.UtcExpirationTime > GETUTCDATE()
  ORDER BY PP.last_update_time DESC