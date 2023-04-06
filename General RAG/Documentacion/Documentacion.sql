--Ver todas las bases de datos de una instancia
--SELECT name FROM sys.databases order by name asc

--Ver todas las talbas de la base de datos
SELECT TABLE_SCHEMA,TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE='BASE TABLE' order by TABLE_NAME asc
