SELECT t.sufix_cegid AS [Patente],
       t.patent1,
       t.patent2,
       t.patent3,
       t.patent4,
       t.patent5,
       t.patent6,
       t.patent7,
       t.patent8
FROM [MXSRVTRACA].[APPS].[dbo].[patent] t
JOIN [MXSRVCEGID].[PMI].[dbo].[UARTICLE] C
ON t.sufix_cegid = C.ARKTPATENT COLLATE French_CI_AS 
WHERE C.ARKTCODART = '85779'
order by t.sufix_cegid asc
