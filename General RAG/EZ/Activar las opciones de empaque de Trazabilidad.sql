declare @PCNAME NVARCHAR(50)
set @PCNAME = 'MXDT202305'
SELECT * from pcmx WHERE PCNAME = @PCNAME
--activar todas las opciones en empaque

--Trazabilidad Activa
UPDATE pcmx SET Can_Save_traza = 0 WHERE PCNAME = @PCNAME
--Validar numero de parte
UPDATE pcmx SET Can_pick_qctest = 0 WHERE PCNAME = @PCNAME
--Validar Prueba Funcional
UPDATE pcmx SET Can_Val_Benchtest = 0 WHERE PCNAME = @PCNAME
--Validar Revision
UPDATE pcmx SET Can_Val_Rev = 0 WHERE PCNAME = @PCNAME
--Picking de pruebas activo
UPDATE pcmx SET Can_Val_custpn = 0 WHERE PCNAME = @PCNAME


