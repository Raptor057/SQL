SELECT 
COUNT(A.ARKTCODART) AS CRA
--A.ARKTCODART,A.ARKTCOMART,U.ARKCRITPAR,A.ARCTCOSFAM,U.APKSKIPLOT
FROM [mxsrvcegid].[PMI].[dbo].[UARTICLE] U
INNER JOIN [mxsrvcegid].[PMI].[dbo].[ARTICLE] A ON A.ARKTCODART=U.ARKTCODART AND A.ARKTCOMART=U.ARKTCOMART
WHERE U.ARKTCODART ='TEST1'  AND U.ARKTCOMART='C' AND (U.ARKCRITPAR = 'Y' OR A.ARCTCOSFAM = 'RES' OR A.ARCTCOSFAM = 'AC' OR U.APKSKIPLOT != 1)
