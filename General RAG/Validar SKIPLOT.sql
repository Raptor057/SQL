--Validar SKIPLOT
--si el valor es igual a 0 es skip lot
-- si hay datos no es
SELECT 
U.ARKCRITPAR,
A.ARCTCOSFAM,
A.ARCTCOSFAM,
U.APKSKIPLOT
FROM [mxsrvcegid].[PMI].[dbo].[UARTICLE] U
INNER JOIN [mxsrvcegid].[PMI].[dbo].[ARTICLE] A ON A.ARKTCODART=U.ARKTCODART AND A.ARKTCOMART=U.ARKTCOMART
WHERE U.ARKTCODART ='44403'  AND U.ARKTCOMART='A' AND (U.ARKCRITPAR = 'Y' OR A.ARCTCOSFAM = 'RES' OR A.ARCTCOSFAM = 'AC' OR RTRIM(U.APKSKIPLOT) != '1')
