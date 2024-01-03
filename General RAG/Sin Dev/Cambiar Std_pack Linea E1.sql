/*
DB APPS
Este Query sirve para ver las ordenes activas y corriendo en GT-Apps
*/
SELECT TOP (1000) * FROM [APPS].[dbo].[pro_production] 
WHERE is_stoped = 0 AND is_running = 1 AND is_finished = 0
--AND [order] = ''
ORDER BY id DESC


/*Este query sirve para cambiar el Std Pack de la orden, principalmente esto se usa para la E1 en modelos motores BL
Descomentar las 3 lineas para ejecutar este Update*/

-- UPDATE [APPS].[dbo].[pro_production]
-- SET std_pack = '' --Aqui se pone la cantidad que quieres que salgan las etiquetas de componentes
-- WHERE is_stoped = 0 AND is_running = 1 AND is_finished = 0 AND [order] = '' -- aqui va el numero de orden 
