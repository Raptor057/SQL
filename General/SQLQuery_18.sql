USE [gtt]
GO
/****** Object:  Trigger [dbo].[utr_on_tm_packed]    Script Date: 10/25/2022 2:07:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
drop TRIGGER [dbo].[UtrOnProcess]
   ON [dbo].[ProcessHistory]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    return;

	MERGE
	INTO dbo.EtiCounters WITH (HOLDLOCK) AS target
	USING (
		SELECT e.EtiNo, SUM(t.total) [total] FROM (
            SELECT LineCode, COUNT(*)
            FROM inserted
            WHERE ProcessID = '999'
            GROUP BY LineCode
        ) t(linea, total)
        JOIN dbo.LinePointsOfUse p
            ON p.LineCode = t.linea
        JOIN dbo.PointOfUseEtis e WITH(NOLOCK)
            ON e.PointOfUseCode = p.PointOfUseCode AND e.UtcExpirationTime IS NULL
        GROUP BY e.EtiNo
	) AS source (eti_no, total)
	ON (target.EtiNo = source.eti_no)
	WHEN MATCHED
	  THEN UPDATE
		  SET CounterValue = CounterValue + source.total
			 ,LastUtcUpdateTime = GETUTCDATE()
	WHEN NOT MATCHED
	  THEN INSERT (EtiNo, CounterValue, LastUtcUpdateTime, BinSize)
		  VALUES (source.eti_no, source.total, GETUTCDATE(), (SELECT TOP 1
            ISNULL(se.qty, ISNULL(e.qty, ISNULL(tr.qty, -1))) [BinSize]
        FROM (SELECT source.eti_no)t(EtiNo)
        LEFT JOIN MXSRVTRACA.TRAZAB.dbo.pro_subeti se
            ON LEFT(t.EtiNo, 2) = 'es' AND ISNUMERIC(RIGHT(t.EtiNo, LEN(t.EtiNo) - 2)) = 1
            AND CAST(se.id AS VARCHAR(50)) = RIGHT(t.EtiNo, LEN(t.EtiNo) - 2)
        LEFT JOIN MXSRVTRACA.APPS.dbo.wh_eti001_transfer tr WITH(NOLOCK)
            ON LEFT(t.EtiNo, 1) = 'e' AND CHARINDEX('-t', t.EtiNo) > 0
            AND CAST(tr.id AS VARCHAR(50)) = RIGHT(t.EtiNo, LEN(t.EtiNo) - CHARINDEX('-t', t.EtiNo) - 1)
        LEFT JOIN MXSRVTRACA.APPS.dbo.pro_eti001 e WITH(NOLOCK)
            ON LEFT(t.EtiNo, 1) = 'E' AND CHARINDEX('-', t.EtiNo) = 0
            AND ISNUMERIC(RIGHT(t.EtiNo, LEN(t.EtiNo) - 1)) = 1 AND CAST(e.id AS VARCHAR(50)) = RIGHT(t.EtiNo, LEN(t.EtiNo) - 1)));

END