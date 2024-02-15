-- SELECT DISTINCT(s.LineCode) " +
--                 "FROM dbo.LineProductionSchedule s " +
--                 "JOIN dbo.LineGamma g ON g.PartNo = s.PartNo AND g.LineCode = s.LineCode AND g.PointOfUseCode = @pointOfUseCode AND g.CompNo = @componentNo " +
--                 "WHERE s.UtcExpirationTime >= GETUTCDATE() AND s.UtcEffectiveTime < GETUTCDATE()

SELECT DISTINCT RTRIM(CB.NOKTCOMPF) AS [LineCode],RTRIM(CB.NOKTCODPF) AS [Model]
FROM [MXSRVTRACA].[APPS].[dbo].[pro_prod_units] PPU 
INNER JOIN [MXSRVTRACA].[APPS].[dbo].[pro_production] PP ON  PPU.id = PP.id_line AND PP.is_stoped = 0 AND PP.is_running = 1 AND PP.is_finished = 0
INNER JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB ON RTRIM(CB.NOKTCODPF) = RTRIM(PP.part_number) AND RTRIM(CB.NOKTCOMPF) = RTRIM(PPU.letter)
WHERE CB.NOCTCODECP = '43914' AND CB.NOCTCODOPE = 'BM2' 