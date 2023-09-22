SELECT TOP (1000)   [MLB].Id
      ,[Master_id]
      ,[TM_id]
      --,[pack_time]
      ,DATEADD(HOUR, -5, pack_time) AS nueva_fecha_hora_UTC
      ,ml.codew
      ,ML.part_num
  FROM [TRAZAB].[dbo].[Master_lbl_TMid]  MLB
  JOIN [TRAZAB].[dbo].[Master_labels_WB] ML ON MLB.Master_id = ML.Id 
  WHERE 
  --TM_id LIKE ('%9736831%')
  --Master_id LIKE ('%57232%')
  pack_time BETWEEN '2023-06-13 00:00:00.600' and '2023-06-15 00:00:00.600'
  AND ML.line = 'RIDER LE' AND ML.part_num = '87248'

--DATEADD(HOUR, -5, '2023-06-13 12:20:29.230') AS nueva_fecha_hora;