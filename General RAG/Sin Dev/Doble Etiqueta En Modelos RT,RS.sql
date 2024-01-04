/*
DB APPS
Este Query sirve para ver las ordenes activas y corriendo en GT-Apps
*/
SELECT TOP (1000) * FROM [APPS].[dbo].[pro_production] 
WHERE is_stoped = 0 AND is_running = 1 AND is_finished = 0
--AND [order] = ''
ORDER BY id DESC


/*Este query sirve para hacer que impriman 2 etiquetas individuales, principalmente esto se usa para la LE en modelos RT,RS*/
--UPDATE [APPS].[dbo].[pro_production]  SET dblid = 2 WHERE is_stoped = 0 AND is_running = 1 AND is_finished = 0 AND [order] = ''
