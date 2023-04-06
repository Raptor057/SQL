--UPDATE apps_users SET [password] = @Passwd WHERE id_user = @IDUser
--UPDATE apps_users SET is_supervisor = @Is_supervisor WHERE id_user = @IDUser
--select * from apps_users WHERE is_supervisor = 1 AND active = 1 and id_user = @IDUser

--select * from apps_users WHERE is_supervisor = 1 AND active = 1

--SELECT COUNT(*) FROM dbo.apps_users WHERE is_supervisor = 1 AND active = 1 AND password = 'Gtmex20'

--======================================================================================
--Crear Usuarios
DECLARE @active int
DECLARE @user VARCHAR(20)
DECLARE @password VARCHAR(20)
DECLARE @departament VARCHAR(3)
DECLARE @mail VARCHAR(max)
DECLARE @Is_admin INT
DECLARE @Is_supervisor INT
DECLARE @create_at DATETIME
DECLARE @displayname VARCHAR(max)

set @active = 1
set @user = 'Test'
set @password = '12345'
set @departament = 'OP'
set @mail = '@'
set @Is_admin = 0
set @Is_supervisor = 0
set @create_at = GETDATE()
set @displayname = NULL

--select [DevTest].[dbo].[UfnGenerateRandomPassword](10,'CN')
--INSERT INTO apps_users VALUES (@active,@user,@password,@departament,@mail,@Is_admin,@Is_supervisor,@create_at,@displayname);
--select * from apps_users --WHERE 
--======================================================================================
--Borrar usuarios
--DELETE apps_users 
select * from apps_users where active = 1