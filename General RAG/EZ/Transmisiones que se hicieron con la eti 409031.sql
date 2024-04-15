  SELECT --top 5
        PH.LineCode
        ,ML.part_num
        ,LP.Revision
        ,PH.UnitID
        ,MXT.Master_id
        ,dbo.UfnToLocalTime(PH.UtcTimeStamp) as [Local Time]
  FROM [gtt].[dbo].[ProcessHistory] PH
  JOIN MXSRVTRACA.TRAZAB.dbo.Master_lbl_TMid MXT ON MXT.TM_id = CAST(PH.UnitID AS VARCHAR(15)) --PH.UnitID
  JOIN MXSRVTRACA.TRAZAB.dbo.Master_labels_WB  ML ON ML.id = MXT.Master_id
  JOIN LineProductionSchedule LP ON LP.LineCode = PH.LineCode
  WHERE 
  PH.ProcessID = 999
  AND PH.LineCode = 'LE'
  AND ML.is_active != 0
  --AND LP.PartNo IN ('87245', '87244', '87248')
  AND ML.part_num IN ('87245', '87244', '87248','GT87245')
  AND PH.UtcTimeStamp >='2023-06-06 15:35:45.997'
  AND LP.UtcExpirationTime > GETUTCDATE()
  ORDER BY PH.UtcTimeStamp DESC

--409031

