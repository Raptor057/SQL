declare 
@No_parte varchar (50),
@Rev nvarchar(10)
set @No_parte = '85779'
set @Rev = '01'

select
REPLACE(REPLACE(ISNULL(NULLIF(RTRIM(t.sufix_cegid), ''), 'NA'), CHAR(13), ''), CHAR(10), '') AS [Patente],
REPLACE(REPLACE(ISNULL(NULLIF(RTRIM(t.patent1), ''), 'NA'), CHAR(13), ''), CHAR(10), '')AS [Patente1],
REPLACE(REPLACE(ISNULL(NULLIF(RTRIM(t.patent2), ''), 'NA'), CHAR(13), ''), CHAR(10), '')AS [Patente2],
REPLACE(REPLACE(ISNULL(NULLIF(RTRIM(t.patent3), ''), 'NA'), CHAR(13), ''), CHAR(10), '')AS [Patente3],
REPLACE(REPLACE(ISNULL(NULLIF(RTRIM(t.patent4), ''), 'NA'), CHAR(13), ''), CHAR(10), '')AS [Patente4],
REPLACE(REPLACE(ISNULL(NULLIF(RTRIM(t.patent5), ''), 'NA'), CHAR(13), ''), CHAR(10), '')AS [Patente5],
REPLACE(REPLACE(ISNULL(NULLIF(RTRIM(t.patent6), ''), 'NA'), CHAR(13), ''), CHAR(10), '')AS [Patente6],
REPLACE(REPLACE(ISNULL(NULLIF(RTRIM(t.patent7), ''), 'NA'), CHAR(13), ''), CHAR(10), '')AS [Patente7],
REPLACE(REPLACE(ISNULL(NULLIF(RTRIM(t.patent8), ''), 'NA'), CHAR(13), ''), CHAR(10), '')AS [Patente8]
FROM [MXSRVCEGID].[PMI].[dbo].[UARTICLE] C
JOIN [MXSRVTRACA].[APPS].[dbo].[patent] t
ON RTRIM(C.ARKTPATENT) COLLATE French_CI_AS = t.sufix_cegid  
WHERE RTRIM(C.ARKTCODART) =@No_parte and rtrim(C.ARKTCOMART) = @Rev