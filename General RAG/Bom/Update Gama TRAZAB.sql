-- MXSRVTRACA TRAZAB

declare 
@LineCode VARCHAR (20),
@PartNo VARCHAR (50)

set @LineCode = 'MU'
set @PartNo = '389012'


--EXECUTE [dbo].[usp_update_bom_info] 'GT87145', 'LE'
EXECUTE [MXSRVTRACA].[TRAZAB].[dbo].[usp_update_bom_info] @PartNo,@LineCode
--SELECT TOP (1000) *  FROM [TRAZAB].[cegid].[bom] where NOKTCODPF = @PartNo AND NOKTCOMPF = @LineCode


--SELECT * FROM cegid.ufn_bom(@partNo, @lineCode) ORDER BY PointOfUse, CompNo;

  -- SELECT
  --          i          [SeqNo],
  --          NOKTCODPF  [PartNo],
  --          NOKTCOMPF  [PartRev],
  --          NOKTCOSFAM [PartFamily],
  --          NOCTCODECP [CompNo],
  --          NOCTCOMCPT [CompRev],
  --          ARCTCODFAM [CompFamily],
  --          ARCTLIB01  [CompDesc],
  --          NOCTCODOPE [PointOfUse],
  --          NOCTTYPOPE [Capacity],
  --          APKSTDPACK [StdPackQty],
  --          NOKNLIGNOM [OperationNo],
  --          NOCNQTECOM [ReqQty],
  --          NOKNLIGNOM [OperatioNo],
  --          NOCTCODATE [WorkshopCode]
  --       FROM cegid.bom
  --       WHERE NOKTCODPF = REPLACE(REPLACE(@PartNo, 'GT', ''), 'U', '') AND NOKTCOMPF = @LineCode

