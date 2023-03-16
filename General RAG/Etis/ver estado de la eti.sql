--select * from PointOfUseEtis where PointOfUseCode  like ('H02') ORDER BY UtcEffectiveTime ASC

--UPDATE PointOfUseEtis SET  UtcUsageTime = null , UtcExpirationTime = null where EtiNo = 'E370384-T989580'

--UPDATE PointOfUseEtis SET  EtiNo ='E370384-T989580' where EtiNo = 'E370384-T989581'

--UPDATE PointOfUseEtis SET  UtcUsageTime = '2022-10-25 00:00:00.000' , UtcExpirationTime = '2022-10-31 14:08:38.897' where EtiNo = 'E370384-T989580'

--2022-10-25 00:00:00.000 2022-10-31 14:08:38.897

--select * from PointOfUseEtis WHERE UtcUsageTime is null and UtcExpirationTime is null ORDER BY UtcEffectiveTime DESC

SELECT * from PointOfUseEtis where EtiNo = 'E69392-T1054039'--where PointOfUseCode = 'A34' ORDER BY UtcEffectiveTime  DESC
--UPDATE PointOfUseEtis SET UtcExpirationTime = NULL WHERE EtiNo = 'E401282-T1061038'

--SELECT * from PointOfUseEtis where PointOfUseCode ='A34'
 --and UtcEffectiveTime is null--and UtcUsageTime <> null
--where EtiNo = 'E391569-T1059888'--'E370384-T989580'


--DELETE PointOfUseEtis WHERE ID ='11527'



--select * from PointOfUseEtis where EtiNo = 'E399032-T1054275'