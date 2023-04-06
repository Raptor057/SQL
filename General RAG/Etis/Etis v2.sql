--======= VARIABLES  ================================================================
DECLARE @Eti VARCHAR(max)
set @Eti = 'E69360-T1063582'
--==================================================================================

--======= BORRAR ETI DE LA BASE DE DATOS ===========================================

--DELETE PointOfUseEtis WHERE EtiNo = @Eti
--SELECT * FROM PointOfUseEtis WHERE EtiNo=@Eti
--==================================================================================

--======= ESCANEAR ETI EN ENSAMBLE =================================================
--UPDATE PointOfUseEtis set UtcUsageTime = GETDATE() where EtiNo = 'E398918-T1059670'
--SELECT * FROM PointOfUseEtis WHERE EtiNo LIKE('E190464-T1059277')
--==================================================================================