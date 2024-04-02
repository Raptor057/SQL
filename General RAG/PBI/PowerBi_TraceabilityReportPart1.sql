/*
Este query da informacion de esas 4 tablas unidas, para un reporte en PowerBi para generar trazabilidad de los componentes
RA: 03/13/2024
*/
SELECT top 1000
    pe.*
    ,qea.*
    ,wet.*
    ,au.*
FROM 
    [mxsrvtraca].[APPS].[dbo].[pro_eti001] pe
    LEFT JOIN [mxsrvtraca].[APPS].[dbo].[qty_eti001_approvals] qea 
    ON qea.id_label = pe.id
    LEFT JOIN [mxsrvtraca].[APPS].[dbo].[wh_eti001_transfer] wet 
    ON wet.id_pro_eti001 = pe.id
    LEFT JOIN [mxsrvtraca].[APPS].[dbo].[apps_users] au 
    ON wet.created_by = au.[id_user]
WHERE 
    CONVERT(DATETIME, pe.created_at, 23) > DATEADD(YEAR, -3, GETDATE());
