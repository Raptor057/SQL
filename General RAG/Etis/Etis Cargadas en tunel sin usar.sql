SELECT poue.*
FROM dbo.LinePointsOfUse lpou
JOIN dbo.PointOfUseEtis poue
    ON poue.PointOfUseCode = lpou.PointOfUseCode
    AND poue.UtcEffectiveTime <= GETUTCDATE() AND poue.UtcUsageTime IS NULL AND poue.UtcExpirationTime IS NULL
WHERE lpou.LineCode = 'LA'
ORDER by PointOfUseCode asc


--ORDER by UtcEffectiveTime asc

--ORDER by UtcEffectiveTime asc

-- and poue.PointOfUseCode = 'H05'
-- and poue.PointOfUseCode = 'H01'

--36356
--00594
--32096

--and poue.PointOfUseCode = 'E14'


--select top 1  * FROM PointOfUseEtis where ComponentNo = '35' and UtcUsageTime is NULL and UtcExpirationTime is NULL --ORDER by UtcEffectiveTime asc

-- DECLARE @EtiID VARCHAR(max)
-- set @EtiID = (select top 1 ID FROM PointOfUseEtis where PointOfUseCode = 'E19' and UtcUsageTime is NULL and UtcExpirationTime is NULL ORDER by UtcEffectiveTime asc)
-- UPDATE PointOfUseEtis set UtcUsageTime = GETUTCDATE() where ID = @EtiID

--UPDATE PointOfUseEtis set UtcEffectiveTime = GETUTCDATE() where ID = 82709 


-- select *  FROM [gtt].[dbo].[PointOfUseEtis] where EtiNo = 'E337090-T1053492'
-- UPDATE PointOfUseEtis SET UtcUsageTime = null WHERE EtiNo = 'E337090-T1053492'
-- --UPDATE PointOfUseEtis SET UtcUsageTime = GETUTCDATE() WHERE EtiNo = 'E337090-T1053492'

-- --E383072-T988089


-- DECLARE @etis VARCHAR(max)
-- set @etis = 'E398791-T1046412'
-- --Etiqueta a cargar en tunel O04
-- DELETE FROM PointOfUseEtis WHERE EtiNo = @etis
-- SELECT * from PointOfUseEtis where EtiNo = @etis


--etiqueta ya cargada en tunel G03
-- UPDATE PointOfUseEtis SET UtcExpirationTime = Null WHERE EtiNo = @etis
-- SELECT * from PointOfUseEtis where EtiNo = @etis