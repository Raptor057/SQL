-- DECLARE @Numero_Parte VARCHAR(50),
-- @rev VARCHAR(50);
-- set @Numero_Parte =('85779')
-- set @rev =('LP')

-- SELECT t.sufix_cegid AS [Patente],
--        t.patent1,
--        t.patent2,
--        t.patent3,
--        t.patent4,
--        t.patent5,
--        t.patent6,
--        t.patent7,
--        t.patent8
-- FROM [MXSRVCEGID].[PMI].[dbo].[UARTICLE] C
-- JOIN [MXSRVTRACA].[APPS].[dbo].[patent] t
-- ON RTRIM(C.ARKTPATENT) COLLATE French_CI_AS = t.sufix_cegid  
-- --WHERE RTRIM(C.ARKTCODART) =@Numero_Parte and rtrim(C.ARKTCOMART) = @rev
-- --WHERE rtrim(C.ARKTCODART) = '85779' 
-- --AND 
-- WHERE rtrim(C.ARKTCOMART) = 'LP'
-- order by t.sufix_cegid asc


--select * from [MXSRVTRACA].[APPS].[dbo].[patent]
declare @Patent varchar (50),
@No_parte varchar (50),
@Rev nvarchar(10)
set @No_parte = '85779'
set @Rev = '01'
--select * from [MXSRVCEGID].[PMI].[dbo].[UARTICLE] where rtrim(ARKTCODART) like ('%85779%') and rtrim(ARKTCOMART) like ('%01%')
set @Patent = (select rtrim(ARKTPATENT) from [MXSRVCEGID].[PMI].[dbo].[UARTICLE] where rtrim(ARKTCODART) like (@No_parte) and rtrim(ARKTCOMART) like (@Rev))
select @Patent

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
ON RTRIM(C.ARKTPATENT) COLLATE French_CI_AS = t.sufix_cegid  
WHERE RTRIM(C.ARKTCODART) =@No_parte and rtrim(C.ARKTCOMART) = @Rev
