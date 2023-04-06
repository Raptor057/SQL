--============================================================================================================================================
--======================    Esto es lo que se tiene que ejecutar, lo de abajo es para buscar a un empleado con su numero    ==================

--update emp_rh set PWDKIOSCO=RIGHT('0000' + CAST(ABS(CHECKSUM(NewId())) % 10000 AS VARCHAR(4)), 4) where EMPLEADO>=7899 AND EMPLEADO < 7912
--select EMPLEADO, NOMBRE, PATERNO, MATERNO, PWDKIOSCO from EMP_RH where EMPLEADO>=7899 AND EMPLEADO < 7912

--============================================================================================================================================
-- SELECT * from EMP_RH WHERE EMPLEADO = '5785'
-- SELECT * from EMP_RH WHERE EMPLEADO = '5787'

SELECT * from EMP_RH WHERE EMPLEADO in('5787','5785') 

--SELECT NOMBRE, PATERNO, MATERNO, IMSS, RFC from EMP_RH WHERE EMPLEADO in('5787','5785') 

--select * from MXSRVADMIN.NETGT.dbo.EMP_RH
