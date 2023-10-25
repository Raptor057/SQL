--Se borra de la tabla donde se enlazan las master y el unitid
--se desabilita la master
--se ejecuta esto pero primero esto

SELECT TOP (1000) [linea]
      ,[modelo]
      ,[telesis]
      ,[fecha]
      ,[num_p]
      ,[LEVEL]
      ,[IS_partial]
      ,[Master_id]
      ,[Aproved]
  FROM [TRAZAB].[dbo].[Temp_pack_WB] WHERE linea = 'WB LC'

--   INSERT INTO [TRAZAB].[dbo].[Temp_pack_WB] (linea,modelo,telesis,fecha,num_p,IS_partial,Aproved)   
--   (SELECT top 1000 mlw.line,mlw.modelo,mlt.TM_id,mlt.pack_time,mlw.part_num,mlw.is_partial,null AS Aproved
--    FROM Master_labels_WB mlw
--    RIGHT JOIN [TRAZAB].[dbo].[Master_lbl_TMid] mlt ON mlw.Id=mlt.Master_id
--   WHERE mlw.Id = 58769)


SELECT top 1000 *
   FROM [TRAZAB].[dbo].[Master_labels_WB] 
  WHERE Id = 58769