--Base de datos TRAZAB en server MXSRVTRACA.
DECLARE @Linea VARCHAR (25)
DECLARE @Part_Num VARCHAR (25)
DECLARE @CodeWO VARCHAR (25)
DECLARE @Qty INT
DECLARE @Aproved VARCHAR (25)
DECLARE @Fecha VARCHAR (25)
---------------------------
-- La fecha se queda asi para que de siempre la fecha actual en el formato correspondido.
-- El @Aproved se queda igual para que sea mostrado.
-- El @Qty se queda igual por default.
set @Fecha = FORMAT (getdate(), 'dd-MMM-yyyy')
set @Aproved = 'True'
set @Qty = '1'

--Cambiar esto.
----------------------------------
set @Linea ='WB LB' --Ejemplo: WB LA
set @Part_Num = '85540'
--set @CodeWO = 'W07982821'
set @CodeWO = 'W08622510'
----------------------------------

--select * from [MXSRVTRACA].[TRAZAB].[dbo].[Tbl_qc_aproved_list] where linea = @Linea ORDER BY id desc

insert into [MXSRVTRACA].[TRAZAB].[dbo].[Tbl_qc_aproved_list] (linea, part_num, codewo, qty, is_approved, fecha) VALUES (@Linea,@Part_Num,@CodeWO,@Qty, @Aproved,@Fecha)
--Se va a reposo la actual validar esto.

--select * from [MXSRVTRACA].[TRAZAB].[dbo].[Tbl_qc_aproved_list] 
