--SELECT TOP (1000) * FROM [gtt].[dbo].[PointOfUseEtis] WHERE EtiNo = @EtiNo

declare @Line VARCHAR(2),
@date1 DATETIME,
@date2 DATETIME

SET @Line = 'A'
set @date1 = GETUTCDATE()-10
set @date2 = GETUTCDATE()

--SELECT * FROM PointOfUseEtis where 

SELECT * FROM PointOfUseEtis WHERE PointOfUseCode like (CONCAT('%',@Line,'%')) AND UtcEffectiveTime BETWEEN @date1 and @date2 order by UtcEffectiveTime desc