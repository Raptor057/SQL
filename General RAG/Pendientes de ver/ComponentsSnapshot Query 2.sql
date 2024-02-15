/*Query para guardar la receta al cambio de etiquetas*/

DECLARE @PointOfUseCode VARCHAR(4)
DECLARE @LineCode VARCHAR(4)

SET @PointOfUseCode = 'O01'
SET @LineCode = (SELECT TOP 1 LineCode from LinePointsOfUse WHERE PointOfUseCode = @PointOfUseCode)
--INSERT INTO ComponentsSnapshot (SnapShotID,LineCode,PointOfUseCode,EtiNo,MasterEtiNo,ComponentNo,ComponentRev,ComponentDescription,LotNo)
SELECT CAST(FORMAT(GETUTCDATE(), 'yyyyMMddHHmmssfff') AS BIGINT) AS [ID],LPU.LineCode, PUE.PointOfUseCode,PUE.EtiNo,
CASE 
        WHEN CHARINDEX('-', PUE.EtiNo) > 0 THEN
            LEFT(PUE.EtiNo, CHARINDEX('-', PUE.EtiNo) - 1)
        ELSE
            PUE.EtiNo
    END AS MasterEtiNo
,PUE.ComponentNo,RTRIM(CB.NOCTCOMCPT) AS [ComponentRev],RTRIM(CB.ARCTLIB01) AS [Description],PUE.LotNo
  FROM [gtt].[dbo].[PointOfUseEtis] PUE
  FULL JOIN LinePointsOfUse LPU ON PUE.PointOfUseCode = LPU.PointOfUseCode
  FULL JOIN LineProductionSchedule LPS ON LPS.LineCode = LPU.LineCode AND  LPS.UtcExpirationTime > GETUTCDATE()
  RIGHT JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB ON RTRIM(CB.NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.PartNo 
  AND RTRIM(NOKTCOMPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.LineCode 
  AND RTRIM(CB.NOCTCODECP) COLLATE SQL_Latin1_General_CP1_CI_AS = PUE.ComponentNo
  AND TRIM(CB.NOCTCODOPE) COLLATE SQL_Latin1_General_CP1_CI_AS = LPU.PointOfUseCode
  WHERE LPU.LineCode = @LineCode AND PUE.UtcExpirationTime IS NULL AND PUE.UtcUsageTime IS NOT NULL AND PUE.UtcUsageTime <GETUTCDATE()


-- DECLARE @PointOfUseCode VARCHAR(4)
-- SET @PointOfUseCode = 'P01'
-- EXEC InsertComponentsSnapshot @PointOfUseCode = @PointOfUseCode;


--///////////////CONTAR COMPONENTES ACTIVOS////////////////////
-- DECLARE @PartNo VARCHAR(20)
-- DECLARE @Result INT

-- SET @LineCode = (SELECT TOP 1 LineCode from LinePointsOfUse WHERE PointOfUseCode = @PointOfUseCode)

-- SET @PartNo = (SELECT top 1  LPS.PartNo AS [PartNo]
--   FROM [gtt].[dbo].[PointOfUseEtis] PUE
--   FULL JOIN LinePointsOfUse LPU ON PUE.PointOfUseCode = LPU.PointOfUseCode
--   FULL JOIN LineProductionSchedule LPS ON LPS.LineCode = LPU.LineCode AND  LPS.UtcExpirationTime > GETUTCDATE()
--   RIGHT JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB ON RTRIM(CB.NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.PartNo 
--   AND RTRIM(NOKTCOMPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.LineCode 
--   AND RTRIM(CB.NOCTCODECP) COLLATE SQL_Latin1_General_CP1_CI_AS = PUE.ComponentNo
--   AND TRIM(CB.NOCTCODOPE) COLLATE SQL_Latin1_General_CP1_CI_AS = LPU.PointOfUseCode
--   WHERE LPU.LineCode = @LineCode AND PUE.UtcExpirationTime IS NULL AND PUE.UtcUsageTime IS NOT NULL AND PUE.UtcUsageTime <GETUTCDATE())


-- SELECT COUNT(PUE.ComponentNo) AS [CountComponentActive]
--   FROM [gtt].[dbo].[PointOfUseEtis] PUE
--   FULL JOIN LinePointsOfUse LPU ON PUE.PointOfUseCode = LPU.PointOfUseCode
--   FULL JOIN LineProductionSchedule LPS ON LPS.LineCode = LPU.LineCode AND  LPS.UtcExpirationTime > GETUTCDATE()
--   RIGHT JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB ON RTRIM(CB.NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.PartNo 
--   AND RTRIM(NOKTCOMPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.LineCode 
--   AND RTRIM(CB.NOCTCODECP) COLLATE SQL_Latin1_General_CP1_CI_AS = PUE.ComponentNo
--   AND TRIM(CB.NOCTCODOPE) COLLATE SQL_Latin1_General_CP1_CI_AS = LPU.PointOfUseCode
--   WHERE LPU.LineCode = @LineCode AND PUE.UtcExpirationTime IS NULL AND PUE.UtcUsageTime IS NOT NULL AND PUE.UtcUsageTime <GETUTCDATE()

-- SELECT 
--   COUNT(RTRIM(NOCTCODECP)) AS [CountBomComponent]
--   FROM  [MXSRVTRACA].[TRAZAB].[cegid].[bom]
--   WHERE RTRIM(NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS = @PartNo --Modelo 
--   AND RTRIM(NOKTCOMPF) COLLATE SQL_Latin1_General_CP1_CI_AS = @LineCode --Linea

-- SELECT @Result = CASE WHEN (SELECT COUNT(PUE.ComponentNo) AS [CountComponentActive]
--                             FROM [gtt].[dbo].[PointOfUseEtis] PUE
--                             FULL JOIN LinePointsOfUse LPU ON PUE.PointOfUseCode = LPU.PointOfUseCode
--                             FULL JOIN LineProductionSchedule LPS ON LPS.LineCode = LPU.LineCode AND LPS.UtcExpirationTime > GETUTCDATE()
--                             RIGHT JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB ON RTRIM(CB.NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.PartNo 
--                             AND RTRIM(NOKTCOMPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.LineCode 
--                             AND RTRIM(CB.NOCTCODECP) COLLATE SQL_Latin1_General_CP1_CI_AS = PUE.ComponentNo
--                             AND TRIM(CB.NOCTCODOPE) COLLATE SQL_Latin1_General_CP1_CI_AS = LPU.PointOfUseCode
--                             WHERE LPU.LineCode = @LineCode AND PUE.UtcExpirationTime IS NULL AND PUE.UtcUsageTime IS NOT NULL AND PUE.UtcUsageTime < GETUTCDATE()) 
--                           = (SELECT COUNT(RTRIM(NOCTCODECP)) AS [CountBomComponent]
--                              FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom]
--                              WHERE RTRIM(NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS = @PartNo --Modelo 
--                              AND RTRIM(NOKTCOMPF) COLLATE SQL_Latin1_General_CP1_CI_AS = @LineCode --Linea
--                             )
--                     THEN 1 ELSE 0 END

-- SELECT @Result AS [Result]