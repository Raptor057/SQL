DECLARE @partno VARCHAR(10),
@rev VARCHAR(50)

set @partno = '87245'
set @rev = '20'

SELECT top 1000 APKNPCECO2,* from UARTICLE WHERE ARKTSOC = 300 and ARKTCODART = @partno and ARKTCOMART = @rev and rtrim(APKNPCECO2) != 0

SELECT count(APKNPCECO2) from UARTICLE WHERE ARKTSOC = 300 and ARKTCODART = @partno and ARKTCOMART = @rev and rtrim(APKNPCECO2) != '' and rtrim(APKNPCECO2) != 0

--SELECT top 1000 APKNPCECO2,* from UARTICLE WHERE ARKTSOC = 300 and APKNPCECO2 != 0


--SELECT top 1000 APKSTDPACK,APKNPCECON,APKNPCECO2,* from UARTICLE WHERE ARKTSOC = 300 and ARKTCODART = @partno and ARKTCOMART = @rev
--and APKNPCECON = '0' --Cant spack001 
--and APKNPCECO2 = '0' --Cant spack001 bis