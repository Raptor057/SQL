SELECT TOP (1000) [id]
      ,[id_pro_eti001]
      ,[active]
      ,[qty]
      ,[std_pack]
      ,[employee_id]
      ,[created_at]
      ,[created_by]
      ,[blocked]
      ,[date_blocked]
      ,[RMNC]
      ,[date_released]
      ,[packing_count]
  FROM [APPS].[dbo].[wh_eti001_transfer] WHERE id_pro_eti001 
  --in ('418509','415281')--'433269'
 
  in ('418632',
'433269',
'417083',
'418509',
'417084')