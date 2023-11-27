INSERT INTO [APPS].[dbo].[skipped_batch_list_frequency_check] (part_number,rev,skiplot)
  SELECT 
  UA.ARKTCODART,
  UA.ARKTCOMART,
  UA.APKSKIPLOT
  FROM [APPS].[dbo].[pro_eti001] PE
  INNER JOIN mxsrvcegid.pmi.dbo.uarticle UA ON RTRIM(UA.ARKTCODART) COLLATE French_CS_AS_KS_WS = RTRIM(PE.part_number) AND RTRIM(ARKTCOMART) COLLATE French_CI_AS = RTRIM(PE.rev)
  WHERE UA.APKSKIPLOT = 1
  AND ARKTSOC = 300

  select * from mxsrvcegid.pmi.dbo.uarticle

SELECT TOP (1000) *
  FROM [APPS].[dbo].[skipped_batch_list_frequency_check]


--    delete [APPS].[dbo].[skipped_batch_list_frequency_check]
--  DBCC CHECKIDENT('skipped_batch_list_frequency_check', RESEED, 0);
