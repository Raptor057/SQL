DECLARE @LineCode VARCHAR(2)
SET @LineCode = 'LB'

SELECT TOP 1 [PartNo],[HourlyRate], @LineCode AS [LineCode] FROM [gtt].[dbo].[LineModelCapabilities] WHERE PartNo ='180184' ORDER BY LineCode ASC

INSERT INTO LineModelCapabilities (PartNo,HourlyRate,LineCode)
SELECT TOP 1 [PartNo],[HourlyRate],@LineCode FROM [gtt].[dbo].[LineModelCapabilities] WHERE PartNo ='180184' ORDER BY LineCode ASC