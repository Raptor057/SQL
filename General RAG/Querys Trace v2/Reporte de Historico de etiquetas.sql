declare 
@fechadecarga1 DATETIME,
@fechadecarga2 DATETIME,
@LineCode VARCHAR(4),
@Componente VARCHAR(20),
@Tunel varchar (4),
@EtiNo VARCHAR (50)

set @fechadecarga1 = GETUTCDATE()
set @fechadecarga2 = GETUTCDATE()-2
set @LineCode = NULL
set @Tunel = NULL   
set @Componente = NULL
set @EtiNo = NULL
--set @fechadecargainicial = (select top 1 UtcEffectiveTime FROM [gtt].[dbo].[PointOfUseEtis] where UtcEffectiveTime is not NULL ORDER by  UtcEffectiveTime asc)



SELECT TOP (1000)
    L.LineCode AS [LINEA],
    P.[PointOfUseCode] as [TUNEL]
      ,P.[EtiNo] as [ETIQUETA]
      ,P.[ComponentNo] as [COMPONENTE]
      ,P.[UtcEffectiveTime] as [FECHA DE CARGA]
      ,P.[UtcUsageTime] as [FECHA DE USO]
      ,P.[UtcExpirationTime] as [FECHA DE DESCARGA]
  FROM [gtt].[dbo].[PointOfUseEtis] P
    JOIN LinePointsOfUse L
    ON P.PointOfUseCode = L.PointOfUseCode
    where UtcExpirationTime IS NOT NULL 
    AND P.UtcEffectiveTime BETWEEN @fechadecarga2 and @fechadecarga1
    --(@fechadecarga2 OR  @fechadecargainicial = (select top 1 UtcEffectiveTime FROM [gtt].[dbo].[PointOfUseEtis] where UtcEffectiveTime is not NULL ORDER by  UtcEffectiveTime asc)) and @fechadecarga1 
    --AND P.UtcEffectiveTime >= COALESCE(@fechadecargainicial, (select top 1 UtcEffectiveTime FROM [gtt].[dbo].[PointOfUseEtis] where UtcEffectiveTime is not NULL ORDER by  UtcEffectiveTime asc))
    -- AND (L.LineCode IS NULL OR @LineCode = L.LineCode )
    -- AND (P.PointOfUseCode IS NULL OR @Tunel = p.PointOfUseCode)
    -- AND (P.ComponentNo IS NULL OR  @Componente = p.ComponentNo)
    AND (L.LineCode = COALESCE(@LineCode, L.LineCode))
    AND (P.PointOfUseCode = COALESCE(@Tunel, P.PointOfUseCode))
    AND (P.ComponentNo = COALESCE(@Componente, P.ComponentNo))
    AND (P.EtiNo = COALESCE(@EtiNo, P.EtiNo))
    order by p.PointOfUseCode asc, p.UtcEffectiveTime DESC

-- select top 1 UtcEffectiveTime FROM [gtt].[dbo].[PointOfUseEtis] where UtcEffectiveTime is not NULL ORDER by  UtcEffectiveTime asc
-- select top 1 UtcUsageTime FROM [gtt].[dbo].[PointOfUseEtis] where UtcUsageTime is not NULL ORDER by  UtcUsageTime asc
-- select top 1 UtcExpirationTime FROM [gtt].[dbo].[PointOfUseEtis] where UtcExpirationTime is not NULL ORDER by  UtcExpirationTime asc


SELECT DISTINCT L.LineCode AS [LINEA]
  FROM [gtt].[dbo].[PointOfUseEtis] P
    JOIN LinePointsOfUse L
    ON P.PointOfUseCode = L.PointOfUseCode


declare @LineCode VARCHAR(4),
@fechadecarga1 DATETIME,
@fechadecarga2 DATETIME,
@Componente VARCHAR(4)
set @LineCode = 'LA'
set @fechadecarga1 = GETUTCDATE()
set @fechadecarga2 = GETUTCDATE()-2
set @Componente = Null
-- SELECT DISTINCT P.[PointOfUseCode] as [TUNEL]
--   FROM [gtt].[dbo].[PointOfUseEtis] P
--     JOIN LinePointsOfUse L
--     ON P.PointOfUseCode = L.PointOfUseCode
--     where UtcExpirationTime IS NOT NULL 
--     AND P.UtcEffectiveTime BETWEEN @fechadecarga2 and @fechadecarga1
--     and (@LineCode IS NULL OR L.LineCode = @LineCode)
--     ORDER by P.PointOfUseCode ASC

    SELECT DISTINCT P.[ComponentNo] as [COMPONENTE]
  FROM [gtt].[dbo].[PointOfUseEtis] P
    JOIN LinePointsOfUse L
    ON P.PointOfUseCode = L.PointOfUseCode
    where UtcExpirationTime IS NOT NULL 
    AND P.UtcEffectiveTime BETWEEN @fechadecarga2 and @fechadecarga1
    and (@LineCode IS NULL OR L.LineCode = @LineCode)
    and (P.PointOfUseCode IS NULL OR P.PointOfUseCode = @Tunel)
    ORDER by p.ComponentNo ASC
    

    SELECT DISTINCT(LineCode) from LinePointsOfUse

    SELECT GETUTCDATE()

    SELECT GETUTCDATE()-30