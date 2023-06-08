DECLARE @partNo VARCHAR(50),
@lineCode VARCHAR(15)

set @partNo = '85540'
set @lineCode = 'LB'

-- IF OBJECT_ID('tempdb..#temp') IS NOT NULL
--     DROP TABLE #temp;

-- SELECT t.*,
--     CASE WHEN LEFT(CompRev, 1) IN ('X','Y','0') THEN CompRev ELSE LEFT(CompRev, 1) END [CompRev2]
-- INTO #temp
-- FROM (
--     SELECT
--         i          [SeqNo],
--         NOKTCODPF  [PartNo],
--         NOKTCOMPF  [PartRev],
--         NOKTCOSFAM [PartFamily],
--         NOCTCODECP [CompNo],
--         NOCTCOMCPT [CompRev],
--         ARCTCODFAM [CompFamily],
--         ARCTLIB01  [CompDesc],
--         NOCTCODOPE [PointOfUse],
--         NOCTTYPOPE [Capacity],
--         APKSTDPACK [StdPackQty],
--         NOKNLIGNOM [OperationNo],
--         NOCNQTECOM [ReqQty],
--         NOKNLIGNOM [OperatioNo],
--         NOCTCODATE [WorkshopCode]
--     FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom]
--     WHERE NOKTCODPF = @partNo AND NOKTCOMPF = @lineCode
-- ) AS t

-- SELECT
--     SeqNo, PartNo, PartRev, PartFamily, CompNo, CompRev, CompFamily, CompDesc, PointOfUse, Capacity, StdPackQty, OperationNo, SUM(ReqQty) [ReqQty], WorkshopCode, CompRev2
-- FROM #temp
-- GROUP BY SeqNo, PartNo, PartRev, PartFamily, CompNo, CompRev, CompFamily, CompDesc, PointOfUse, Capacity, StdPackQty, OperationNo, WorkshopCode, CompRev2
-- --ORDER BY PointOfUse DESC

--     --SELECT DISTINCT(RTRIM(NOKTCODPF)) FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom]

--     --SELECT DISTINCT(RTRIM(NOKTCODPF)) AS [Numero de Parte] FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom] ORDER BY NOKTCODPF DESC

--     SELECT DISTINCT RTRIM(NOKTCODPF) AS [Numero de Parte], NOKTCODPF AS [Numero de Parte Original]
--     FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom]
--     ORDER BY [Numero de Parte Original] ASC


--     --SELECT DISTINCT(RTRIM(NOKTCOMPF)) AS [Linea] FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom] ORDER BY NOKTCOMPF DESC

--     SELECT DISTINCT RTRIM(NOKTCOMPF) AS [Linea], NOKTCOMPF AS [Linea Original]
--     FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom]
--     ORDER BY [Linea Original] ASC

--         SELECT top 100 * FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom]

           SELECT top 1 RTRIM(NOKTCODPF) AS [Numero de Parte],RTRIM(NOKTCOMPF) AS [Linea] FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom] WHERE NOKTCOMPF = @lineCode AND NOKTCODPF=@partNo
