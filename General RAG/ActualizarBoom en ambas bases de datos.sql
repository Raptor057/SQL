DECLARE @modelo VARCHAR(15)
DECLARE @Line_Code VARCHAR(2)

SET @modelo =''
SET @Line_Code=''

EXEC dbo.UspUpdateLineGamma @Line_Code, @modelo, @Line_Code;
--EXEC [MXSRVTRACA].[dbo].[usp_update_bom_info] 'GT87140', 'LE'
EXEC [MXSRVTRACA].[TRAZAB].[dbo].[usp_update_bom_info] @modelo, @Line_Code