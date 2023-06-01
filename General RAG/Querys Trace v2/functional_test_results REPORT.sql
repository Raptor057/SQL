DECLARE 
@wb BIGINT,
@result BIT

set @wb = NULL
set @result = NULL

SELECT *
FROM [MXSRVTRACA].[APPS].[dbo].[pro_tms_functional_test_results]
WHERE 
    (@wb IS NULL OR WB = @wb) -- Filtra por @wb solo si no es NULL
    AND (@result IS NULL OR RESULTAT = @result) -- Filtra por @result solo si no es NULL
ORDER BY [DATE] DESC
