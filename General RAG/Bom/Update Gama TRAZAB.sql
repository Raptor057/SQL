-- MXSRVTRACA TRAZAB

declare 
@LineCode VARCHAR (20),
@PartNo VARCHAR (50)

set @LineCode = 'LB'
set @PartNo = '85540'


--EXECUTE [dbo].[usp_update_bom_info] 'GT87145', 'LE'
EXECUTE [MXSRVTRACA].[TRAZAB].[dbo].[usp_update_bom_info] @PartNo,@LineCode
--SELECT TOP (1000) *  FROM [TRAZAB].[cegid].[bom] where NOKTCODPF = @PartNo AND NOKTCOMPF = @LineCode


SELECT * FROM cegid.ufn_bom(@partNo, @lineCode) ORDER BY 
--PointOfUse,
CompNo asc;

  -- SELECT
  --          *
  --       FROM cegid.bom
  --       WHERE NOKTCODPF = REPLACE(REPLACE(@PartNo, 'GT', ''), 'U', '') AND NOKTCOMPF = @LineCode

