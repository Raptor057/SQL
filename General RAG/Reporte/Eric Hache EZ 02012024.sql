SELECT
        ML.[Id]
      ,ML.[fecha]
      ,ML.[Hora]
      ,ML.[qty]
      ,ML.[line]
      ,ML.[FAMILIA]
      ,ML.[modelo]
      ,ML.[part_num]
      ,ML.[rev]
      ,ML.[description]
      ,ML.[codew]
      ,ML.[customer]
      ,ML.[cust_pn]
      ,ML.[po_num]
      ,ML.[LOTES]
      ,ML.[master_type]
      ,CASE [is_active] WHEN 0 THEN 'Desactivada' WHEN 1 THEN 'Activa' ELSE 'N/A' END
      ,MLT.TM_id
FROM [TRAZAB].[dbo].[Master_labels_WB] ML 
INNER JOIN [TRAZAB].[dbo].[Master_lbl_TMid] MLT ON ML.Id = MLT.Master_id
WHERE ML.part_num IN('87244','87248','87244','87245') AND ML.rev IN ('11','09','10','22') AND ML.master_type = 'MASTER'
ORDER BY ML.id desc


	