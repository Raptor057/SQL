SELECT TOP (1000) *
  FROM [APPS].[dbo].[pro_eti001] --WHERE poline != '-'
  WHERE created_at = CAST(GETDATE() AS date)
  order by id desc

-- UPDATE PE
-- SET PE.[poline] = R.[line] --CONCAT(R.[order],'-',R.[line]) 
-- FROM [APPS].[dbo].[pro_eti001] PE
-- INNER JOIN radio_reception R ON PE.id = R.id_label;


-- UPDATE PE
-- SET PE.[poline] = CONCAT(R.[order],'-',R.[line]) 
-- FROM [APPS].[dbo].[pro_eti001] PE
-- INNER JOIN (
--     SELECT TOP 10 *
--     FROM radio_reception
--     ORDER BY id DESC
-- ) R ON PE.id = R.id_label;

-- UPDATE PE
-- SET PE.[poline] = COALESCE(CONCAT(R.[order], '-', R.[line]), PE.reference)
-- FROM [APPS].[dbo].[pro_eti001] PE
-- LEFT JOIN (
--     SELECT TOP 10 *
--     FROM radio_reception
--     ORDER BY id DESC
-- ) R ON PE.id = R.id_label;


UPDATE PE
SET PE.[poline] = CONCAT(R.[order],'-',R.[line])
FROM [APPS].[dbo].[pro_eti001] PE
INNER JOIN radio_reception R ON PE.id = R.id_label
WHERE PE.created_at = CAST(GETDATE() AS date)

update [APPS].[dbo].[pro_eti001] set poline = reference WHERE poline IS NULL AND created_at = CAST(GETDATE() AS date)

update [APPS].[dbo].[pro_eti001] set poline = NULL WHERE created_at = CAST(GETDATE() AS date)
