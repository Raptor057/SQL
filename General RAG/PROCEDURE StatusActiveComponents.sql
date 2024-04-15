DECLARE @PointOfUseCode VARCHAR(4)
DECLARE @LineCode VARCHAR(4)
DECLARE @PartNo VARCHAR(20)
DECLARE @CountBomComponent INT
DECLARE @CountComponentActive INT

DECLARE @Result INT

SET @PointOfUseCode = 'P01'

SET @LineCode = (SELECT TOP 1 LineCode from LinePointsOfUse WHERE PointOfUseCode = @PointOfUseCode)

SET @PartNo = (SELECT top 1  LPS.PartNo AS [PartNo]
  FROM [gtt].[dbo].[PointOfUseEtis] PUE
  FULL JOIN LinePointsOfUse LPU ON PUE.PointOfUseCode = LPU.PointOfUseCode
  FULL JOIN LineProductionSchedule LPS ON LPS.LineCode = LPU.LineCode AND  LPS.UtcExpirationTime > GETUTCDATE()
  RIGHT JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB ON RTRIM(CB.NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.PartNo 
  AND RTRIM(NOKTCOMPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.LineCode 
  AND RTRIM(CB.NOCTCODECP) COLLATE SQL_Latin1_General_CP1_CI_AS = PUE.ComponentNo
  AND TRIM(CB.NOCTCODOPE) COLLATE SQL_Latin1_General_CP1_CI_AS = LPU.PointOfUseCode
  WHERE LPU.LineCode = @LineCode AND PUE.UtcExpirationTime IS NULL AND PUE.UtcUsageTime IS NOT NULL AND PUE.UtcUsageTime <GETUTCDATE())


SET @CountComponentActive = (SELECT COUNT(PUE.ComponentNo) AS [CountComponentActive]
  FROM [gtt].[dbo].[PointOfUseEtis] PUE
  FULL JOIN LinePointsOfUse LPU ON PUE.PointOfUseCode = LPU.PointOfUseCode
  FULL JOIN LineProductionSchedule LPS ON LPS.LineCode = LPU.LineCode AND  LPS.UtcExpirationTime > GETUTCDATE()
  RIGHT JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB ON RTRIM(CB.NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.PartNo 
  AND RTRIM(NOKTCOMPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.LineCode 
  AND RTRIM(CB.NOCTCODECP) COLLATE SQL_Latin1_General_CP1_CI_AS = PUE.ComponentNo
  AND TRIM(CB.NOCTCODOPE) COLLATE SQL_Latin1_General_CP1_CI_AS = LPU.PointOfUseCode
  WHERE LPU.LineCode = @LineCode AND PUE.UtcExpirationTime IS NULL AND PUE.UtcUsageTime IS NOT NULL AND PUE.UtcUsageTime <GETUTCDATE())

SET @CountBomComponent = (SELECT 
  COUNT(RTRIM(NOCTCODECP)) AS [CountBomComponent]
  FROM  [MXSRVTRACA].[TRAZAB].[cegid].[bom]
  WHERE RTRIM(NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS = @PartNo --Modelo 
  AND RTRIM(NOKTCOMPF) COLLATE SQL_Latin1_General_CP1_CI_AS = @LineCode) --Linea


SELECT @Result = CASE WHEN (@CountComponentActive)
                          = (@CountBomComponent)
                    THEN 1 ELSE 0 END

--SELECT @Result AS [Result]
SELECT @CountComponentActive , @CountBomComponent,@LineCode,@PartNo


--///////////////////////////////////////////////////////////////////

-- CREATE PROCEDURE StatusActiveComponents
--     @PointOfUseCode VARCHAR(4)
-- AS
-- BEGIN
--     DECLARE @LineCode VARCHAR(4)
--     DECLARE @PartNo VARCHAR(20)
--     DECLARE @CountBomComponent INT
--     DECLARE @CountComponentActive INT
--     DECLARE @Result INT

--     -- Obtener LineCode
--     SET @LineCode = (SELECT TOP 1 LineCode FROM LinePointsOfUse WHERE PointOfUseCode = @PointOfUseCode)

--     -- Obtener PartNo
--     SET @PartNo = (
--         SELECT TOP 1 LPS.PartNo AS [PartNo]
--         FROM [gtt].[dbo].[PointOfUseEtis] PUE
--         FULL JOIN LinePointsOfUse LPU ON PUE.PointOfUseCode = LPU.PointOfUseCode
--         FULL JOIN LineProductionSchedule LPS ON LPS.LineCode = LPU.LineCode AND LPS.UtcExpirationTime > GETUTCDATE()
--         RIGHT JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB ON RTRIM(CB.NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.PartNo 
--         AND RTRIM(NOKTCOMPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.LineCode 
--         AND RTRIM(CB.NOCTCODECP) COLLATE SQL_Latin1_General_CP1_CI_AS = PUE.ComponentNo
--         AND TRIM(CB.NOCTCODOPE) COLLATE SQL_Latin1_General_CP1_CI_AS = LPU.PointOfUseCode
--         WHERE LPU.LineCode = @LineCode AND PUE.UtcExpirationTime IS NULL AND PUE.UtcUsageTime IS NOT NULL AND PUE.UtcUsageTime < GETUTCDATE()
--     )

--     -- Contar componentes activos
--     SET @CountComponentActive = (
--         SELECT COUNT(PUE.ComponentNo) AS [CountComponentActive]
--         FROM [gtt].[dbo].[PointOfUseEtis] PUE
--         FULL JOIN LinePointsOfUse LPU ON PUE.PointOfUseCode = LPU.PointOfUseCode
--         FULL JOIN LineProductionSchedule LPS ON LPS.LineCode = LPU.LineCode AND LPS.UtcExpirationTime > GETUTCDATE()
--         RIGHT JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB ON RTRIM(CB.NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.PartNo 
--         AND RTRIM(NOKTCOMPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.LineCode 
--         AND RTRIM(CB.NOCTCODECP) COLLATE SQL_Latin1_General_CP1_CI_AS = PUE.ComponentNo
--         AND TRIM(CB.NOCTCODOPE) COLLATE SQL_Latin1_General_CP1_CI_AS = LPU.PointOfUseCode
--         WHERE LPU.LineCode = @LineCode AND PUE.UtcExpirationTime IS NULL AND PUE.UtcUsageTime IS NOT NULL AND PUE.UtcUsageTime < GETUTCDATE()
--     )

--     -- Contar componentes en la BOM
--     SET @CountBomComponent = (
--         SELECT COUNT(RTRIM(NOCTCODECP)) AS [CountBomComponent]
--         FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom]
--         WHERE RTRIM(NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS = @PartNo --Modelo 
--         AND RTRIM(NOKTCOMPF) COLLATE SQL_Latin1_General_CP1_CI_AS = @LineCode --Linea
--     )

-- --     -- Establecer el resultado
-- --     SET @Result = CASE
-- --         WHEN @CountComponentActive = @CountBomComponent THEN 1
-- --         ELSE 0
-- --     END
--    -- Establecer el resultado
--     SET @Result = CASE
--         WHEN @PartNo IS NULL THEN 0  -- Si @PartNo es NULL, establecer @Result en 0
--         WHEN @CountComponentActive = @CountBomComponent THEN 1
--         ELSE 0
--     END

--     -- Seleccionar el resultado
--     SELECT @Result AS [Result]
-- END
