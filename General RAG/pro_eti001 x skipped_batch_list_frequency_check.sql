SELECT TOP (1000) *
  FROM [APPS].[dbo].[pro_eti001] PE
  INNER JOIN [APPS].[dbo].[skipped_batch_list_frequency_check] SL ON PE.part_number = SL.part_number and PE.rev = sl.rev