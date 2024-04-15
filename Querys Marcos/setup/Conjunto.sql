--Crear Lineas Nuevas
DECLARE @LineCode VARCHAR(2)
DECLARE @NumTunel INT

set @LineCode = 'MW' --Si es una linea comun y corriente sin procesos extra solo pon el identificador de la linea ejemplo LA,LB,LC,MW,MX etc. solo 2 letras y en MAYUSCULAS
SET @NumTunel = 50 --Int mayor a 9 IMPORTANTE!!

/* 1) Crear los tuneles
se ejecuta este SP para crear los tuneles
el primer valor es el ID de linea, en este caso MX por ser motores, en otros casos 
podria ser LX y asi, solo acepta 2 letras, y el segundo dato es de tipo INT y tiene que ser mayor a 9,
ese indica la cantidad de tuneles que seran insertados
este SP no agrega los tuneles de grasa para el caso de WB asi que se tendran que asgregar manual en la tabla
LinePointsOfUse en la base de datos gtt del servidor MXSRVAPPS*/

--EXEC InsertLinePointsOfUse @LineCode, @NumTunel;
--SELECT * from LinePointsOfUse where LineCode = @LineCode


/**
 * 2) Relacion de procesos validos para las lineas.
 * Todas las piezas nacen con proceso 0, todas las lineas tienen proceso 999
 * de empaque, 100 y 101 son exlusivos de linea P. Si acaso se tendrian que
 * agregar, por ejemplo, procesos de la linea LE si se configura.
 */
-- procesos de las lineas. se repiten entre lineas, la linea P tiene procesos exclusivos
--Solo si la linea va a llevar un proceso que no se encuentra aqui, debera de agregarlo manualmente a la tabla Processes 
--en la base de datos gtt del servidor MXSRVAPPS*/

--SELECT * FROM Processes


/**
 *3)  Todos los tuneles correspondientes a los procesos asociados a una linea.
 * La informacion de esta tabla se utiliza para la trazabilidad.
 */

-- este query es para saber si los tuneles tienen trazabilidad. se tiene que agregar un registro si se agrega un tunel
--El valor que se va a dar es el de la linea creada en el paso 1

--EXEC InsertLineProcessPointsOfUse @LineCode;

SELECT * FROM dbo.LineProcessPointsOfUse where LineCode = @LineCode


/*
*4) Aqui se agrega la ruta de la linea en caso de tener mas de una ruta o proceso esto se encuentra en la tabla
dbo.LineRouting en la base gtt en el server mxsrvapps, este procedimiento crea una ruta simple
Ej:
LineCode	ProcessNo	PrevProcessNo	IsEnabled
MX	        900	        0	            1

si la linea tiene mas turas se tienen que agregar manualmente o en su defecto no ejecutar este SP
*/
--EXEC InsertLineRouting @LineCode;

select * from LineRouting WHERE LineCode = @LineCode

/*
5) este SP incerta la info en la tabla LineShiftSchedules este seria un ejemplo de lo que inserta

insert into LineShiftSchedules (LineCode,ShiftScheduleID,EffectiveDay,ExpirationDay)
VALUES(@LineCode,2,'2022-01-01','2099-12-31')
*/
--EXEC InsertLineShiftSchedule @LineCode;

SELECT * from LineShiftSchedules where LineCode = @LineCode


