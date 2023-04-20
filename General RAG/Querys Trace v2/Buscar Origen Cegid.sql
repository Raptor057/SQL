declare @part_no NVARCHAR(50),
@part_rev NVARCHAR(50)

set @part_no = '85503'
set @part_rev = 'A3'

 
 SELECT RTRIM(U.APKORIGEN) as [Origen],U.ARKTCODART,A.ARCTCODPLA
    FROM [MXSRVCEGID].[PMI].[dbo].[UARTICLE] U
    JOIN [MXSRVCEGID].[PMI].[dbo].[ARTICLE] A ON U.ARKTCODART = A.ARKTCODART AND U.ARKTCOMART = A.ARKTCOMART
    WHERE U.ARKTSOC = 300 AND RTRIM(U.ARKTCODART) = @part_no AND RTRIM(A.ARCTCODPLA) = @part_rev


SELECT top 1
a.[ARKTCODART],a.ARITCONART,u.[APKORIGEN]
FROM UARTICLE u
inner join ARTICLE a
on u.ARKTCODART = a.ARKTCODART
where a.ARKTCODART = '85503' and a.ARITCONART like ('%LO%')