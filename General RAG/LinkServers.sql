USE [master]
GO

/****** Object:  LinkedServer [MXSRVCEGID]    Script Date: 3/3/2023 11:21:15 AM ******/
EXEC master.dbo.sp_addlinkedserver @server = N'MXSRVAPPS', @srvproduct=N'SQL Server'
GO

EXEC master.dbo.sp_serveroption @server=N'MXSRVAPPS', @optname=N'collation compatible', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'MXSRVAPPS', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'MXSRVAPPS', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'MXSRVAPPS', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'MXSRVAPPS', @optname=N'rpc', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'MXSRVAPPS', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'MXSRVAPPS', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'MXSRVAPPS', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'MXSRVAPPS', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'MXSRVAPPS', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'MXSRVAPPS', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'MXSRVAPPS', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'MXSRVAPPS', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


