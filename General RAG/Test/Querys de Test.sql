-- INSERT INTO [dbo].[ActiveEtisTemp]
--            ([PointOfUseCode]
--            ,[EtiNo]
--            ,[ComponentNo]
--            ,[UtcEffectiveTime]
--            ,[UtcUsageTime]
--            ,[UtcExpirationTime]
--            ,[IsDepleted]
--            ,[Comments]
--            ,[LotNo])
--            --SELECT * from PointOfUseEtis WHERE ComponentNo = ''
--             SELECT * from UfnGetActiveEtisInLine('LO')

            --Borrar toda la tabla y resetear el contador.
            -- DELETE dbo.ActiveEtisTemp
            -- DBCC CHECKIDENT (ActiveEtisTemp, RESEED, 0)
            -- delete PointOfUseEtis
            -- DBCC CHECKIDENT (PointOfUseEtis, RESEED, 0)


--Copiar datos de la tabla PointOfUseEtis ggt del servidor MXSRVAPPS a PointOfUseEtis Test Local 

-- INSERT INTO [dbo].[PointOfUseEtis]
--            ([PointOfUseCode]
--            ,[EtiNo]
--            ,[ComponentNo]
--            ,[UtcEffectiveTime]
--            ,[UtcUsageTime]
--            ,[UtcExpirationTime]
--            ,[IsDepleted]
--            ,[Comments]
--            ,[LotNo])
--            select [PointOfUseCode]
--            ,[EtiNo]
--            ,[ComponentNo]
--            ,[UtcEffectiveTime]
--            ,[UtcUsageTime]
--            ,[UtcExpirationTime]
--            ,[IsDepleted]
--            ,[Comments]
--            ,[LotNo] from mxsrvapps.gtt.dbo.PointOfUseEtis --where UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL and PointOfUseCode like('%A%')
-- --select * from PointOfUseEtis

INSERT INTO [dbo].[ActiveEtisTemp]
           ([PointOfUseCode]
           ,[EtiNo]
           ,[ComponentNo]
           ,[UtcEffectiveTime]
           ,[UtcUsageTime]
           ,[UtcExpirationTime]
           ,[IsDepleted]
           ,[Comments]
           ,[LotNo])
           select [PointOfUseCode]
           ,[EtiNo]
           ,[ComponentNo]
           ,[UtcEffectiveTime]
           ,[UtcUsageTime]
           ,[UtcExpirationTime]
           ,[IsDepleted]
           ,[Comments]
           ,[LotNo] from PointOfUseEtis 
           --where UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL and PointOfUseCode like('%A%')
            where Etino = 'E387413-T1067127'
            select * from ActiveEtisTemp