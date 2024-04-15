/**
 * Relacion de procesos validos para las lineas.
 * Todas las piezas nacen con proceso 0, todas las lineas tienen proceso 999
 * de empaque, 100 y 101 son exlusivos de linea P. Si acaso se tendrian que
 * agregar, por ejemplo, procesos de la linea LE si se configura.
 */

-- procesos de las lineas. se repiten entre lineas, la linea P tiene procesos exclusivos

SELECT * FROM Processes