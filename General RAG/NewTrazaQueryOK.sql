--=============================================================
--Variables a tomar de la tabla PointOfUseCode
DECLARE @EtiNo VARCHAR (20)
DECLARE @PointComp VARCHAR(10)
DECLARE @PointOfUseCode VARCHAR(4)
DECLARE @IsInActiveEtisTemp INT
DECLARE @IsAviableInActiveEtisTemp INT
DECLARE @IsAviableInPointOfUseEtis INT --Nuevo


SET @EtiNo = 'E387413-T1067127'
SET @PointComp = (select ComponentNo from PointOfUseEtis where EtiNo = @EtiNo and UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL)
SET @PointOfUseCode = (select PointOfUseCode from PointOfUseEtis where EtiNo = @EtiNo and UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL)
SET @IsAviableInPointOfUseEtis = (select COUNT(EtiNo) from PointOfUseEtis where EtiNo = @EtiNo and UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL)
SELECT @IsAviableInPointOfUseEtis
--SELECT @PointComp
--SELECT @PointOfUseCode

--Validar si existe el componente en el tunel usando el numero de Eti
set @IsInActiveEtisTemp = (Select COUNT(ComponentNo) from ActiveEtisTemp where ComponentNo = @PointComp and PointOfUseCode = @PointOfUseCode and EtiNo = @EtiNo) -- Contar el componente en el tunel donde el componente sea el comp obtenido de la eti.
--SELECT @IsInActiveEtisTemp as [Etiqueta ya escaneada]
SELECT IIF(@IsInActiveEtisTemp > 0, 'Etiqueta ya escaneada', 'Etiqueta OK') as [Etiqueta Status]

--Validar si el componente en el tunel esta activo
--set @IsAviableInActiveEtisTemp = (Select COUNT(ComponentNo) from ActiveEtisTemp where ComponentNo = @PointComp and PointOfUseCode = @PointOfUseCode and IsActive = 1) --
--SELECT @IsAviableInActiveEtisTemp as [Etiqueta esta activa en temp]
--SELECT IIF(@IsAviableInActiveEtisTemp > 0, 'Etiqueta ya escaneada', 'Etiqueta OK') as [Etiqueta Status]
-- --SELECT IIF(@IsInActiveEtisTemp < 1 , 'La Eti no existe', 'La Eti si existe');

 IF @IsInActiveEtisTemp < 1
 UPDATE ActiveEtisTemp set IsActive = 0, UtcExpirationTime = GETUTCDATE() where ComponentNo = @PointComp and PointOfUseCode = @PointOfUseCode and IsActive = 1;

INSERT INTO [dbo].[ActiveEtisTemp]
           ([PointOfUseCode]
           ,[EtiNo]
           ,[ComponentNo]
           ,[UtcEffectiveTime]
           ,[UtcExpirationTime]
           ,[IsDepleted]
           ,[Comments]
           ,[LotNo])
SELECT [PointOfUseCode]
           ,[EtiNo]
           ,[ComponentNo]
           ,[UtcEffectiveTime]
           ,[UtcExpirationTime]
           ,[IsDepleted]
           ,[Comments]
           ,[LotNo]
           FROM PointOfUseEtis WHERE EtiNo = @EtiNo and UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL

select * from ActiveEtisTemp where PointOfUseCode = 'A03'

--select * from ActiveEtisTemp WHERE UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL and  PointOfUseCode LIKE ('A%')

-- --======================================================================================================================================



-- --Uso
-- UPDATE PointOfUseEtis set UtcExpirationTime = GETUTCDATE() WHERE 
-- --EtiNo = 'E387413-T1067127' 
-- UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL and  PointOfUseCode LIKE ('A%')

-- --DesUso
-- UPDATE PointOfUseEtis set UtcExpirationTime = null WHERE 
-- EtiNo = 'E387413-T1067127' 
-- --UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL and  PointOfUseCode LIKE ('A%')

-- select * from PointOfUseEtis WHERE UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL and  PointOfUseCode LIKE ('A%') order by PointOfUseCode asc

-- update PointOfUseEtis set UtcExpirationTime = GETUTCDATE() WHERE UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL and  PointOfUseCode  = 'A03'
-- SELECT * from PointOfUseEtis WHERE PointOfUseCode  = 'A03' ORDER by UtcExpirationTime asc
--  --LIKE ('A%') --order by PointOfUseCode asc



--  --Borrar toda la tabla y resetear el contador.
-- DELETE dbo.ActiveEtisTemp
-- DBCC CHECKIDENT (ActiveEtisTemp, RESEED, 0)
-- delete PointOfUseEtis
-- DBCC CHECKIDENT (PointOfUseEtis, RESEED, 0)


-- --Copiar datos de la tabla PointOfUseEtis ggt del servidor MXSRVAPPS a PointOfUseEtis Test Local 

INSERT INTO [dbo].[PointOfUseEtis]
           ([PointOfUseCode]
           ,[EtiNo]
           ,[ComponentNo]
           ,[UtcEffectiveTime]
           ,[UtcUsageTime]
           ,[UtcExpirationTime]
           ,[IsDepleted]
           ,[Comments]
           ,[LotNo])
           select [PointOfUseCode]
           ,[EtiNo]
           ,[ComponentNo]
           ,[UtcEffectiveTime]
           ,[UtcUsageTime]
           ,[UtcExpirationTime]
           ,[IsDepleted]
           ,[Comments]
           ,[LotNo] from mxsrvapps.gtt.dbo.PointOfUseEtis --where UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL and PointOfUseCode like('%A%')
--select * from PointOfUseEtis


-- --Cargar a la tabla temp todos los componentes activos
-- INSERT INTO [dbo].[ActiveEtisTemp]
--            ([PointOfUseCode]
--            ,[EtiNo]
--            ,[ComponentNo]
--            ,[UtcEffectiveTime]
--            ,[UtcExpirationTime]
--            ,[IsDepleted]
--            ,[Comments]
--            ,[LotNo])
--            select [PointOfUseCode]
--            ,[EtiNo]
--            ,[ComponentNo]
--            ,[UtcEffectiveTime]
--            ,[UtcExpirationTime]
--            ,[IsDepleted]
--            ,[Comments]
--            ,[LotNo] from PointOfUseEtis 
--            where UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL 
--            --and PointOfUseCode like('%A%')
--             --where Etino = 'E387413-T1067127'

--             --delete ActiveEtisTemp where ID ='271'
--             --select * from ActiveEtisTemp order by PointOfUseCode asc

--             --  select * from PointOfUseEtis where Etino = 'E387413-T1067127'
--             --  select * from PointOfUseEtis where Etino = 'E387413-T1067128'

-- --Cargar ETI
--             INSERT INTO [dbo].[PointOfUseEtis]
--            ([PointOfUseCode]
--            ,[EtiNo]
--            ,[ComponentNo]
--            ,[UtcEffectiveTime]
--            ,[UtcUsageTime]
--            ,[UtcExpirationTime]
--            ,[IsDepleted]
--            ,[Comments]
--            ,[LotNo]) --SELECT CONCAT([EtiNo],'-TEST') from PointOfUseEtis
--      VALUES('A03','E387413-T1067130','43607',GETUTCDATE(),NULL,null,0,null,'TEST')

-- select * from PointOfUseEtis  where 
-- --UtcUsageTime <= GETUTCDATE() 
-- --AND 
-- UtcExpirationTime IS NULL 
-- and PointOfUseCode = 'A03' ORDER by UtcEffectiveTime asc

-- --Desechar Eti
-- UPDATE PointOfUseEtis SET UtcExpirationTime = GETUTCDATE() where etino = 'E387413-T1067127'

-- --Borrar ETI

-- delete PointOfUseEtis where Etino = 'E387413-T1067129'


-- --UPDATE ActiveEtisTemp SET etino = 'E387413-T1067127' WHERE etino = 'E387413-T1067128'
-- --delete ActiveEtisTemp where Etino = 'E387413-T1067127'


-- --============ Insertar etiquetas en uso en tanla temporal.
-- INSERT INTO [dbo].[ActiveEtisTemp]
--            ([PointOfUseCode]
--            ,[EtiNo]
--            ,[ComponentNo]
--            ,[UtcEffectiveTime]
--            ,[UtcUsageTime]
--            ,[UtcExpirationTime]
--            ,[IsDepleted]
--            ,[Comments]
--            ,[LotNo])
-- SELECT [PointOfUseCode]
--            ,[EtiNo]
--            ,[ComponentNo]
--            ,[UtcEffectiveTime]
--            ,[UtcUsageTime]
--            ,[UtcExpirationTime]
--            ,[IsDepleted]
--            ,[Comments]
--            ,[LotNo]  
-- 	  FROM PointOfUseEtis where UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL order by PointOfUseCode asc;

-- select * from PointOfUseEtis













--======================================================================================================================================


-- set @line = 'LE'
-- set @Component = '43652'
-- set @EtiNo = ''
-- DECLARE @IsActive int 
-- set @IsActive = (Select COUNT(ComponentNo) from ActiveEtisTemp where ComponentNo = @Component and PointOfUseCode LIKE (CONCAT((select top 1 value from string_split(@linecode,'L') order by value desc),'%')) and IsActive = 1) --Valida que el componente exista y este activo en la linea
-- SELECT @IsActive

-- IF @IsActive = 1
-- UPDATE ActiveEtisTemp set IsActive = 0 where ComponentNo = @Component;
-- INSERT INTO [dbo].[ActiveEtisTemp]
--            ([PointOfUseCode]
--            ,[EtiNo]
--            ,[ComponentNo]
--            ,[UtcEffectiveTime]
--            ,[UtcUsageTime]
--            ,[UtcExpirationTime]
--            ,[IsDepleted]
--            ,[Comments]
--            ,[LotNo])
--            SELECT * from PointOfUseEtis WHERE EtiNo = @EtiNo and UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL and PointOfUseCode LIKE (CONCAT((select top 1 value from string_split(@linecode,'L') order by value desc),'%'))


--SELECT IIF((Select COUNT(ComponentNo) from ActiveEtisTemp where ComponentNo = @Component) = 1 ,(''),'No Esta')




-- INSERT INTO [dbo].[ActiveEtisTemp]
--            ([PointOfUseCode]
--            ,[EtiNo]
--            ,[ComponentNo]
--            ,[UtcEffectiveTime]
--            ,[UtcUsageTime]
--            ,[UtcExpirationTime]
--            ,[IsDepleted]
--            ,[Comments]
--            ,[LotNo])
--            --SELECT * from PointOfUseEtis WHERE ComponentNo = ''
--            SELECT * from UfnGetActiveEtisInLine('LO')
--==============================================================


--UPDATE ActiveEtisTemp set IsActive = 1 where IsActive is not NULL

--=================
select * from PointOfUseEtis where UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL order by PointOfUseCode

declare @eti varchar(50)
set @eti ='E387413-T1067127'

select COUNT(EtiNo) from PointOfUseEtis where EtiNo = @eti

update PointOfUseEtis set UtcUsageTime = GETDATE()  where EtiNo = @eti

select * from PointOfUseEtis where EtiNo = @eti

--delete PointOfUseEtis where UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL and PointOfUseCode like('%A%')
--update PointOfUseEtis set UtcUsageTime = null where UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL and PointOfUseCode like('%A%')