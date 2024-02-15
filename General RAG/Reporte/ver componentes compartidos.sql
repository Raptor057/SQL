--LinesCodesSharingPointOfUseAsync
/*
            public async Task<IEnumerable<string>> LinesCodesSharingPointOfUseAsync(string pointOfUseCode, string componentNo) =>
            await Connection.QueryAsync<string>(@"
            SELECT  DISTINCT(s.LineCode) FROM dbo.LineProductionSchedule s
            JOIN dbo.LineGamma g
            ON g.PartNo = s.PartNo AND g.LineCode = s.LineCode AND g.PointOfUseCode = @pointOfUseCode AND g.CompNo = @componentNo
            WHERE s.UtcExpirationTime >= GETUTCDATE();"
            , new { pointOfUseCode, componentNo }).ConfigureAwait(false);

*/
SELECT DISTINCT ppu.letter,PP.part_number
FROM [MXSRVTRACA].[APPS].[dbo].[pro_prod_units] PPU
INNER JOIN [MXSRVTRACA].[APPS].[dbo].[pro_production] PP ON  PP.id_line = PPU.id AND PP.is_stoped = 0 AND is_running = 1 AND is_finished = 0
INNER JOIN dbo.LineGamma LG ON LG.PartNo COLLATE SQL_Latin1_General_CP1_CI_AS = PP.part_number AND LG.LineCode  COLLATE SQL_Latin1_General_CP1_CI_AS = ppu.letter
AND LG.PointOfUseCode = 'BM2' AND LG.CompNo = '43914'
GROUP BY ppu.letter,PP.part_number

SELECT DISTINCT(RTRIM(ppu.letter)) AS [LineCode]
FROM [MXSRVTRACA].[APPS].[dbo].[pro_prod_units] PPU
INNER JOIN [MXSRVTRACA].[APPS].[dbo].[pro_production] PP ON  PP.id_line = PPU.id AND PP.is_stoped = 0 AND is_running = 1 AND is_finished = 0
INNER JOIN dbo.LineGamma LG ON LG.PartNo COLLATE SQL_Latin1_General_CP1_CI_AS = PP.part_number AND LG.LineCode  COLLATE SQL_Latin1_General_CP1_CI_AS = ppu.letter
AND LG.PointOfUseCode = 'BM2' AND LG.CompNo = '43914'


