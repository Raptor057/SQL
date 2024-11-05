-- SELECT  [Id]
--       ,[Master_id]
--       ,[TM_id]
--       ,[pack_time]
--   FROM [TRAZAB].[dbo].[Master_lbl_TMid]


-- SELECT top 100  mlt.[Id],mlt.[Master_id],
-- CAST([TM_id] AS BIGINT),
-- mlt.[TM_id]
-- ,mlt.[pack_time]
-- ,mlw.fecha
-- FROM [TRAZAB].[dbo].[Master_lbl_TMid] mlt
-- INNER JOIN [TRAZAB].[dbo].Master_labels_WB mlw
-- On mlt.Master_id = mlw.id
-- WHERE ISNUMERIC([TM_id]) != 0
-- order by mlw.id desc

SELECT  [Id]
      ,[Master_id]
      ,CAST([TM_id] AS BIGINT) AS [TM_id]
      ,[pack_time]
  FROM [TRAZAB].[dbo].[Master_lbl_TMid]
  WHERE ISNUMERIC([TM_id]) != 0