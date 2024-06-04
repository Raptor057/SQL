DECLARE @PartNo VARCHAR(20)
DECLARE @LineCode VARCHAR(20)

set @PartNo= NULL
set @LineCode = NULL

SELECT 
NOKTCOMPF AS [Linea],
NOKTCODPF AS [Numero de parte],
  NOCTCODOPE AS [Tunel],
  NOCTCODECP AS [Componente],
  COUNT(NOCTCODECP) AS [Cantidad]
FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom]
WHERE (@PartNo IS NULL OR NOKTCODPF = @PartNo) AND (@LineCode IS NULL OR NOKTCOMPF = @LineCode)
GROUP BY NOKTCOMPF, NOKTCODPF, NOCTCODOPE, NOCTCODECP
HAVING COUNT(NOCTCODECP) > 1
ORDER BY NOCTCODOPE ASC, NOCTCODECP ASC;