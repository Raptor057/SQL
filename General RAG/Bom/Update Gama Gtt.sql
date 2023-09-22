--MXSRVAPPS GTT
declare 
@LineCode VARCHAR (20),
@PartNo VARCHAR (50)

set @LineCode = 'LE'
set @PartNo = 'GT85540'

EXEC dbo.UspUpdateLineGamma @LineCode, @PartNo, @LineCode;

--EXEC dbo.UspUpdateLineGamma @LineCode, @PartNo, @LineCode;
--EXECUTE [MXSRVTRACA].[TRAZAB].[dbo].[usp_update_bom_info] '82015', 'LF'
--SELECT TOP (1000) *  FROM [gtt].[dbo].[Gammas] where PartNo = @PartNo and PartRev = @LineCode

      