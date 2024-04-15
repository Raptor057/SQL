-- SELECT *
-- FROM [gtt].[dbo].[PointOfUseEtis] POUE
-- INNER JOIN [gtt].[dbo].LinePointsOfUse LPOU ON LPOU.PointOfUseCode = POUE.PointOfUseCode
-- INNER JOIN [MXSRVTRACA].[APPS].[dbo].[pro_prod_units] PPU ON LPOU.LineCode COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(PPU.letter) 
-- INNER JOIN [MXSRVTRACA].[APPS].[dbo].[pro_production] PP ON  PPU.id = PP.id_line AND PP.is_stoped = 0 AND PP.is_running = 1 AND PP.is_finished = 0
-- INNER JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB ON RTRIM(CB.NOKTCODPF) = RTRIM(PP.part_number) AND RTRIM(CB.NOKTCOMPF) = RTRIM(PPU.letter) AND LPOU.PointOfUseCode COLLATE SQL_Latin1_General_CP1_CI_AS = RTRIM(CB.NOCTCODOPE)
-- WHERE POUE.UtcExpirationTime IS NULL AND POUE.UtcUsageTime IS NOT NULL
-- AND LPOU.LineCode = 'LA'

--SQL

-- SELECT COUNT(PUE.ComponentNo) AS [CountComponentActive]
--         FROM [gtt].[dbo].[PointOfUseEtis] PUE
--         FULL JOIN LinePointsOfUse LPU ON PUE.PointOfUseCode = LPU.PointOfUseCode
--         FULL JOIN LineProductionSchedule LPS ON LPS.LineCode = LPU.LineCode AND LPS.UtcExpirationTime > GETUTCDATE()
--         RIGHT JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB ON RTRIM(CB.NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.PartNo 
--         AND RTRIM(NOKTCOMPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.LineCode 
--         AND RTRIM(CB.NOCTCODECP) COLLATE SQL_Latin1_General_CP1_CI_AS = PUE.ComponentNo
--         AND TRIM(CB.NOCTCODOPE) COLLATE SQL_Latin1_General_CP1_CI_AS = LPU.PointOfUseCode
--         WHERE LPU.LineCode = @LineCode AND PUE.UtcExpirationTime IS NULL AND PUE.UtcUsageTime IS NOT NULL AND PUE.UtcUsageTime < GETUTCDATE()


SELECT COUNT(PUE.ComponentNo) AS [CountComponentActive]
FROM [gtt].[dbo].[PointOfUseEtis] PUE
INNER JOIN LinePointsOfUse LPU ON PUE.PointOfUseCode = LPU.PointOfUseCode
INNER JOIN LineProductionSchedule LPS ON LPS.LineCode = LPU.LineCode AND LPS.UtcExpirationTime > GETUTCDATE()
RIGHT JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB ON RTRIM(CB.NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.PartNo 
AND RTRIM(NOKTCOMPF) COLLATE SQL_Latin1_General_CP1_CI_AS = LPS.LineCode 
AND RTRIM(CB.NOCTCODECP) COLLATE SQL_Latin1_General_CP1_CI_AS = PUE.ComponentNo
AND TRIM(CB.NOCTCODOPE) COLLATE SQL_Latin1_General_CP1_CI_AS = LPU.PointOfUseCode
WHERE LPU.LineCode = 'LO' AND PUE.UtcExpirationTime IS NULL AND PUE.UtcUsageTime IS NOT NULL AND PUE.UtcUsageTime < GETUTCDATE()
