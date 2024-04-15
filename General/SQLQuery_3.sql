	MERGE
	INTO dbo.EtiCounters WITH (HOLDLOCK) AS target
	USING (
		SELECT e.EtiNo, SUM(t.total) [total] FROM (
            SELECT LineCode, COUNT(*)
            FROM (SELECT 1, 'LB')inserted(total, LineCode)
            GROUP BY LineCode
        ) t(linea, total)
        JOIN dbo.LinePointsOfUse p
            ON p.LineCode = t.linea
        JOIN dbo.PointOfUseEtis e WITH(NOLOCK)
            ON e.PointOfUseCode = p.PointOfUseCode AND e.UtcExpirationTime IS NULL AND e.UtcUsageTime IS NOT NULL
        GROUP BY e.EtiNo
	) AS source (eti_no, total)
	ON (target.EtiNo = source.eti_no)
	WHEN MATCHED
	  THEN UPDATE
		  SET CounterValue = CounterValue + source.total
			 ,LastUtcUpdateTime = GETUTCDATE()
	WHEN NOT MATCHED
	  THEN INSERT (EtiNo, CounterValue, LastUtcUpdateTime, BinSize)
		  VALUES (source.eti_no, source.total, GETUTCDATE(), -100);
