/*
DB APPS
Este Query sirve para ver las ordenes activas y corriendo en GT-Apps
*/
DECLARE @letter VARCHAR(2)
DECLARE @codew VARCHAR(50)
set @letter = ('E1') --Aqui se pone las 2 letras de la Linea Ejemplo LA,LO,E1,MW,MX

--Informacion de la orden activa
SELECT TOP (1000) PP.* 
FROM [APPS].[dbo].[pro_production] PP
INNER JOIN [APPS].[dbo].[pro_prod_units] PPU ON PPU.id = PP.id_line
WHERE PP.is_stoped = 0 AND PP.is_running = 1 AND PP.is_finished = 0 AND  PPU.letter = @letter
ORDER BY PP.id DESC

--Declaracion de @codew con el numero de orden activa
SET @codew = (SELECT TOP (1000) PP.codew FROM [APPS].[dbo].[pro_production] PP INNER JOIN [APPS].[dbo].[pro_prod_units] PPU ON PPU.id = PP.id_line WHERE PP.is_stoped = 0 AND PP.is_running = 1 AND PP.is_finished = 0 AND  PPU.letter = @letter)

/*Este query sirve para cambiar el Std Pack de la orden, principalmente esto se usa para la E1 en modelos motores BL
Descomentar las 3 lineas para ejecutar este Update*/
UPDATE [APPS].[dbo].[pro_production]
SET std_pack = '80' --Aqui se pone la cantidad que quieres que salgan las etiquetas de componentes
WHERE is_stoped = 0 AND is_running = 1 AND is_finished = 0 AND [codew] = @codew -- aqui va el numero de orden 
