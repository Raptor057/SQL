--Conexión a la base de datos MXSRVAPPS GTT
USE [MXSRVAPPS GTT];
GO

--Ejecutar el procedimiento almacenado UspUpdateLineGamma
EXEC dbo.UspUpdateLineGamma 'LA', '85079-10', 'LA';

--Conexión a la base de datos MXSRVTRACA TRAZAB
USE [MXSRVTRACA].[TRAZAB].[dbo];
GO

--Ejecutar el procedimiento almacenado usp_update_bom_info
EXECUTE [dbo].[usp_update_bom_info] '82015', 'LF';
