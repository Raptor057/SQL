-- SELECT
-- COUNT(MD.SerialNumber)
-- FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB 
-- INNER JOIN  [gtt].[dbo].[EnginePinionSubassemblyRatio] EPS ON RTRIM(CB.NOCTCODECP) COLLATE SQL_Latin1_General_CP1_CI_AS  = EPS.[subassembly]
-- INNER JOIN [gtt].[dbo].[MotorsData] MD ON EPS.[subassembly] = MD.Modelo AND EPS.[Engine] = MD.MotorPartNum AND EPS.[pinion] = MD.PinionPartNum
-- WHERE CB.[NOKTCODPF] = (SELECT RTRIM([part_number]) AS [PartNo] FROM [MXSRVTRACA].[APPS].[dbo].[pro_production] WHERE is_stoped = 0 AND is_running = 1 AND is_finished = 0 AND id_line = 5) 
-- AND MD.SerialNumber = '0051' AND MD.DateTimeMotor = '2023-12-02 13:11:00.000'


-- CREATE FUNCTION UfnEnginePinionSubassemblyRatioCompatibility
-- (
--     @Motor_Number INT,
--     @DateTimeMotor DATETIME
-- )
-- RETURNS TABLE
-- AS
-- RETURN
-- (
--     SELECT COUNT(MD.SerialNumber) AS Result
--     FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom] CB
--     INNER JOIN [gtt].[dbo].[EnginePinionSubassemblyRatio] EPS ON RTRIM(CB.NOCTCODECP) COLLATE SQL_Latin1_General_CP1_CI_AS = EPS.[subassembly]
--     INNER JOIN [gtt].[dbo].[MotorsData] MD ON EPS.[subassembly] = MD.Modelo AND EPS.[Engine] = MD.MotorPartNum AND EPS.[pinion] = MD.PinionPartNum
--     WHERE CB.[NOKTCODPF] = (SELECT RTRIM([part_number]) FROM [MXSRVTRACA].[APPS].[dbo].[pro_production] WHERE is_stoped = 0 AND is_running = 1 AND is_finished = 0 AND id_line = 5)
--     AND MD.SerialNumber = @Motor_Number AND MD.DateTimeMotor = @DateTimeMotor
-- );


DECLARE @Motor_Number INT = 123; -- Puedes cambiar este valor
DECLARE @DateTimeMotor DATETIME = '2024-03-01'; -- Puedes cambiar este valor

SELECT Result FROM dbo.UfnEnginePinionSubassemblyRatioCompatibility(@Motor_Number, @DateTimeMotor);
