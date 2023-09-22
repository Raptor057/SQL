SELECT dbo.UfnToLocalTime(PH.UtcTimeStamp) as [Fecha de Escaneo], PH.UnitID, PH.LineCode,LPP.PointOfUseCode,BM.NOKTCODPF as [Numero de componente],PO.ComponentNo,PO.EtiNo,dbo.UfnToLocalTime(PO.UtcEffectiveTime)as [Fecha de Carga],dbo.UfnToLocalTime(PO.UtcUsageTime)as [Fecha de Uso],dbo.UfnToLocalTime(PO.UtcExpirationTime)as [Fecha de Fecha de expiracion]
FROM ProcessHistory PH
INNER JOIN LineProcessPointsOfUse  LPP ON LPP.LineCode=PH.LineCode AND LPP.LineCode='LE'
INNER JOIN [MXSRVTRACA].[TRAZAB].[cegid].[bom] BM ON BM.NOCTCODOPE collate SQL_Latin1_General_CP1_CI_AS = LPP.PointOfUseCode
INNER JOIN PointOfUseEtisV2 PO ON po.PointOfUseCode=LPP.PointOfUseCode AND ph.UtcTimeStamp>= PO.UtcUsageTime AND ph.UtcTimeStamp <= po.UtcExpirationTime and PO.ComponentNo COLLATE SQL_Latin1_General_CP1_CI_AS = BM.NOCTCODECP
INNER JOIN LineProductionSchedule LP ON LP.LineCode = LPP.LineCode AND PH.UtcTimeStamp >= LP.UtcEffectiveTime AND PH.UtcTimeStamp <= LP.UtcExpirationTime AND LP.PartNo collate SQL_Latin1_General_CP1_CI_AS = BM.NOKTCODPF
WHERE PH.ProcessID = 0 AND PH.LineCode = 'LE' AND BM.NOKTCODPF IN('87245','87244','87248') AND LPP.PointOfUseCode='E23' AND BM.NOCTCODECP IN ('120791','120942','120766')
ORDER BY PH.UtcTimeStamp DESC
