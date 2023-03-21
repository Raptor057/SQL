SELECT t.sufix_cegid AS [Patente],
       t.patent1,
       t.patent2,
       t.patent3,
       t.patent4,
       t.patent5,
       t.patent6,
       t.patent7,
       t.patent8
FROM [MXSRVCEGID].[PMI].[dbo].[UARTICLE] C
JOIN [MXSRVTRACA].[APPS].[dbo].[patent] t
ON C.ARKTPATENT COLLATE French_CI_AS = t.sufix_cegid  
WHERE C.ARKTCODART = '85779'
order by t.sufix_cegid asc
