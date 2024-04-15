--declare @Line VARCHAR(10)
--SET @Line = 'LO'
-- -- UPDATE pcmx SET is_blocked = 1 WHERE LINE LIKE('%'+@Line)
--select * FROM pcmx WHERE LINE LIKE('%'+@Line)
-- --------------------------------------------------------------------
 declare @lineName VARCHAR(10)
-- --declare @processName VARCHAR(10)
-- declare @hostname VARCHAR(10)
 declare @is_blocked INT
-- --set @processName = 'TRAZA'
 SET @lineName = 'WB LH'
-- set @hostname = 'MXDT202001'
 SET @is_blocked =0
UPDATE pcmx SET is_blocked = 0 WHERE LINE LIKE('%'+@lineName) --and PROCESSNAME = 'PACK'
-- --UPDATE pcmx SET is_blocked = 0 WHERE LINE = @lineName and PROCESSNAME = 'PACK'
-- --UPDATE pcmx SET is_blocked = @is_blocked WHERE PCNAME = @hostname
-- --SELECT [PCNAME], is_blocked from pcmx WHERE PCNAME = @hostname
--UPDATE pcmx SET is_blocked = @is_blocked WHERE LINE LIKE('%'+@lineName) 
-- SELECT PCNAME, is_blocked , PROCESSNAME FROM pcmx WHERE LINE=@lineName --AND PROCESSNAME=@processName
-- --SELECT is_blocked FROM dbo.pcmx WHERE LINE LIKE('%'+@lineName) --PCNAME = @hostname
-- --SELECT is_blocked FROM dbo.pcmx WHERE LINE = @lineName --PCNAME = @hostname
-- --SELECT is_blocked FROM dbo.pcmx WHERE PCNAME = 'MXDT202001'
-- --select * FROM pcmx WHERE LINE LIKE('%'+@lineName)
select * from pcmx WHERE LINE = @lineName


-- --SELECT * FROM dbo.pro_prod_units WHERE letter = 'LA'