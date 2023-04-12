
SELECT TOP 1
--T.modelo,
T.codew
FROM [gtt].[dbo].[ProcessHistory] P
LEFT JOIN mxsrvtraca.apps.dbo.pro_prod_units T
ON P.LineCode COLLATE SQL_Latin1_General_CP1_CI_AS = RIGHT(T.comments, 2) COLLATE SQL_Latin1_General_CP1_CI_AS
order by UtcTimeStamp desc


select * from mxsrvtraca.apps.dbo.pro_prod_units

select * FROM [gtt].[dbo].[ProcessHistory]