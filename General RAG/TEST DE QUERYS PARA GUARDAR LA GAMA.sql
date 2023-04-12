declare 
@UnitID bigint,
@PartNo nvarchar (50),
@lineCode nvarchar(2),
@WorkOrderCode nvarchar(50),
@message VARCHAR(50)
set @WorkOrderCode = 'W07863552'
set @UnitID = 9516483
-- set @PartNo = '85746'
-- set @lineCode = 'LP'
set @PartNo = 'GT85540'
set @lineCode = 'LC'

	IF EXISTS (SELECT 1 FROM [gtt].[dbo].[Gammas] WHERE [PartNo] = @PartNo AND PartRev = @lineCode)
	BEGIN
		--Si existe
		INSERT INTO [gtt].[dbo].[ProductionTraceability] (
			[UnitID],
			--[UtcTimeStamp],
			[LineCode],
			[PointOfUseCode],
			[ComponentNo],
			[EtiNo],
			[LotNo],
			[CompRev],
			[CompDesc],
			[codew]
		)
		SELECT
			@UnitID as [UnitID],
			--GETUTCDATE() as [UtcTimeStamp],
			L.LineCode,
			L.PointOfUseCode,
			E.ComponentNo, 
			E.EtiNo,
			E.LotNo,
			G.CompRev,
			G.CompDesc,
			@WorkOrderCode as [codew]
		FROM [gtt].[dbo].[LinePointsOfUse] L
		LEFT JOIN [gtt].[dbo].PointOfUseEtis E
		ON L.PointOfUseCode = E.PointOfUseCode
		LEFT JOIN [gtt].[dbo].Gammas G
		ON G.PointOfUseCode = E.PointOfUseCode AND E.ComponentNo = G.CompNo
		WHERE 
			L.LineCode = @lineCode
			AND E.UtcUsageTime <= GETUTCDATE() 
			AND E.UtcExpirationTime IS NULL 
			AND G.PartRev = @lineCode
			AND G.PartNo = @PartNo
		ORDER BY L.PointOfUseCode ASC
	END
	ELSE
	BEGIN

         IF EXISTS (SELECT 1 FROM [gtt].[dbo].[Gammas] WHERE [PartNo] = @PartNo AND PartRev = @lineCode)
	    BEGIN
		--Si existe despues de ejecutar 
			EXEC dbo.UspUpdateLineGamma @lineCode, @partNo, @lineCode;
			INSERT INTO [gtt].[dbo].[ProductionTraceability] (
			[UnitID],
			--[UtcTimeStamp],
			[LineCode],
			[PointOfUseCode],
			[ComponentNo],
			[EtiNo],
			[LotNo],
			[CompRev],
			[CompDesc],
			[codew]
		)
		SELECT
			@UnitID as [UnitID],
			--GETUTCDATE() as [UtcTimeStamp],
			L.LineCode,
			L.PointOfUseCode,
			E.ComponentNo, 
			E.EtiNo,
			E.LotNo,
			G.CompRev,
			G.CompDesc,
			@WorkOrderCode as [codew]
		FROM [gtt].[dbo].[LinePointsOfUse] L
		LEFT JOIN [gtt].[dbo].PointOfUseEtis E
		ON L.PointOfUseCode = E.PointOfUseCode
		LEFT JOIN [gtt].[dbo].Gammas G
		ON G.PointOfUseCode = E.PointOfUseCode AND E.ComponentNo = G.CompNo
		WHERE 
			L.LineCode = @lineCode
			AND E.UtcUsageTime <= GETUTCDATE() 
			AND E.UtcExpirationTime IS NULL 
			AND G.PartRev = @lineCode
			AND G.PartNo = @PartNo
		ORDER BY L.PointOfUseCode ASC
    END
    ELSE
    BEGIN
            --Does not exist after executing the EXEC dbo.UspUpdateLineGamma @lineCode, @partNo, @lineCode;
            --Change value of @PartNo and try again
            SET @PartNo = RTRIM(REPLACE(@PartNo, 'GT', ''));
            EXEC dbo.UspUpdateLineGamma @lineCode, @partNo, @lineCode;
            			INSERT INTO [gtt].[dbo].[ProductionTraceability] (
			[UnitID],
			--[UtcTimeStamp],
			[LineCode],
			[PointOfUseCode],
			[ComponentNo],
			[EtiNo],
			[LotNo],
			[CompRev],
			[CompDesc],
			[codew]
		)
		SELECT
			@UnitID as [UnitID],
			--GETUTCDATE() as [UtcTimeStamp],
			L.LineCode,
			L.PointOfUseCode,
			E.ComponentNo, 
			E.EtiNo,
			E.LotNo,
			G.CompRev,
			G.CompDesc,
			@WorkOrderCode as [codew]
		FROM [gtt].[dbo].[LinePointsOfUse] L
		LEFT JOIN [gtt].[dbo].PointOfUseEtis E
		ON L.PointOfUseCode = E.PointOfUseCode
		LEFT JOIN [gtt].[dbo].Gammas G
		ON G.PointOfUseCode = E.PointOfUseCode AND E.ComponentNo = G.CompNo
		WHERE 
			L.LineCode = @lineCode
			AND E.UtcUsageTime <= GETUTCDATE() 
			AND E.UtcExpirationTime IS NULL 
			AND G.PartRev = @lineCode
			AND G.PartNo = @PartNo
		ORDER BY L.PointOfUseCode ASC
    END
	END





   