--ID 88 Mi Lap
DECLARE @ID INT
SET @ID = 88
SELECT Id,UBICACION,PCNAME,LINE,PROCESSNAME from pcmx where Id = @ID


select * from pcmx where line like ('%K')
update pcmx set is_blocked = 0 WHERE line like ('%K')
