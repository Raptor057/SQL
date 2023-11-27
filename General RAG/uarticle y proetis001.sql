SELECT top 100 * 
--DISTINCT part_number 
  FROM [APPS].[dbo].[pro_eti001] 
  --WHERE id like ('%417865%')--created_by = 211
  --WHERE part_number = '120526'
  --E417865-T1173777
  order by id desc
  

  SELECT top 100 * from mxsrvcegid.pmi.dbo.uarticle where arktcodart = '11013             '

  SELECT TOP 1000
  UA.ARKTCODART,
  UA.ARKTCOMART,
  UA.APKSKIPLOT
  FROM [APPS].[dbo].[pro_eti001] PE
  INNER JOIN mxsrvcegid.pmi.dbo.uarticle UA ON RTRIM(UA.ARKTCODART) COLLATE French_CS_AS_KS_WS = RTRIM(PE.part_number) AND RTRIM(ARKTCOMART) COLLATE French_CI_AS = RTRIM(PE.rev)
  --WHERE UA.APKSKIPLOT = 1