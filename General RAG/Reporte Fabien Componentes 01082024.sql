DECLARE @EtiNo VARCHAR (50)
DECLARE @EtiID VARCHAR (50)

SET @EtiNo = 'E433943-T1187262'
--SET @EtiNo = 'E434287'

set @EtiID = SUBSTRING(@EtiNo, CHARINDEX('E', @EtiNo) + 1, 
    CASE WHEN CHARINDEX('-', @EtiNo) > 0 THEN CHARINDEX('-', @EtiNo) - CHARINDEX('E', @EtiNo) - 1
         ELSE LEN(@EtiNo) - CHARINDEX('E', @EtiNo)
    END)

SELECT TOP 1000
    PE.[id],
    CONCAT('E', PE.[id], CASE WHEN WET.[id] IS NOT NULL THEN '-T' + CAST(WET.[id] AS VARCHAR(50)) ELSE '' END) AS [Eti],
    --PH.UnitID,
    --LPS.LineCode,
    --LPS.PartNo,
    PE.[part_number],
    POU.PointOfUseCode,
    PE.[lot],
    PE.[rev],
    POU.UtcEffectiveTime AS [Fecha de Carga],
    POU.UtcUsageTime AS [Fecha de Uso],
    POU.UtcExpirationTime AS [Fecha de Descarga],
    POU.IsDepleted,
     CASE
        WHEN POU.UtcUsageTime IS NULL AND POU.UtcExpirationTime IS NULL AND  POU.IsDepleted = 0 THEN 'Cargada'
        WHEN POU.UtcUsageTime IS NOT NULL AND POU.UtcExpirationTime IS NULL AND POU.IsDepleted = 0 THEN 'En uso'
        WHEN POU.UtcUsageTime IS NULL AND POU.UtcExpirationTime IS NOT NULL AND POU.IsDepleted = 0 THEN 'Retorno'
        WHEN POU.IsDepleted = 1 THEN 'Consumido'
        WHEN POU.UtcEffectiveTime IS NULL THEN 'No cargado en línea'
        ELSE 'Otro caso'
    END AS Estado
    --LPS.WorkOrderCode

FROM [MXSRVTRACA].[APPS].[dbo].[pro_eti001] PE
FULL JOIN [MXSRVTRACA].[APPS].[dbo].[wh_eti001_transfer] WET ON PE.id = WET.id_pro_eti001
FULL JOIN [gtt].[dbo].[PointOfUseEtis] POU ON CONCAT('E', PE.[id], CASE WHEN WET.[id] IS NOT NULL THEN '-T' + CAST(WET.[id] AS VARCHAR(50)) ELSE '' END) = POU.EtiNo AND POU.UtcUsageTime IS NOT NULL
FULL JOIN [gtt].[dbo].[LinePointsOfUse] LPO ON POU.PointOfUseCode = LPO.PointOfUseCode
--FULL JOIN [gtt].[dbo].[ProcessHistory] PH ON PH.LineCode = LPO.LineCode AND PH.ProcessID = 999
--FULL JOIN [gtt].[dbo].[LineProductionSchedule] LPS ON LPS.LineCode = LPO.LineCode AND POU.UtcEffectiveTime >= LPS.UtcEffectiveTime AND LPS.UtcExpirationTime <= LPS.UtcExpirationTime
-- AND PH.UtcTimeStamp >= LPS.UtcEffectiveTime AND PH.UtcTimeStamp <= LPS.UtcExpirationTime
--AND 
WHERE PE.id = @EtiID
--AND POU.UtcEffectiveTime IS NOT NULL AND UtcUsageTime IS NOT NULL --PONER ESTO COMENTADO PARA VER TODO EN GENERAL SOLO SE DESCOMENTO PARA REDUCIR LOS DATOS.
ORDER BY POU.UtcEffectiveTime DESC


----------------------------------

--Validar si las ordenes coinciden con lo que esta cargado en el tiempo indicado 
SELECT TOP (1000)  LPOU.LineCode,LPS.PartNo,LPS.WorkOrderCode,POU.*
  FROM [gtt].[dbo].[PointOfUseEtis] POU
  FULL JOIN [gtt].[dbo].[LinePointsOfUse] LPOU ON POU.PointOfUseCode = LPOU.PointOfUseCode
  FULL JOIN [gtt].[dbo].[LineProductionSchedule] LPS ON POU.UtcUsageTime >= LPS.UtcEffectiveTime AND POU.UtcExpirationTime <= LPS.UtcExpirationTime OR LPS.UtcExpirationTime >= GETUTCDATE() 
  --WHERE LPOU.LineCode IS NOT NULL
  ORDER BY POU.ID DESC