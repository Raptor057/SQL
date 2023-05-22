DECLARE @cadena VARCHAR(100) = '00.85A|16260|230301-080048|700U0006065';

DECLARE @parte1 VARCHAR(100), @parte2 VARCHAR(100), @parte3 VARCHAR(100), @parte4 VARCHAR(100),@parte5 VARCHAR(100),@horaStr VARCHAR(6),@horaTime TIME,@fechaHora datetime;
SET @parte1 = SUBSTRING(@cadena, 1, CHARINDEX('|', @cadena) - 1);
SET @cadena = SUBSTRING(@cadena, CHARINDEX('|', @cadena) + 1, LEN(@cadena));
SET @parte2 = SUBSTRING(@cadena, 1, CHARINDEX('|', @cadena) - 1);
SET @cadena = SUBSTRING(@cadena, CHARINDEX('|', @cadena) + 1, LEN(@cadena));
SET @parte3 = SUBSTRING(@cadena, 1, CHARINDEX('|', @cadena) - 1);
SET @horaStr = RIGHT(@parte3, 6);
SET @parte3 = LEFT(rtrim(@parte3), CHARINDEX('-', rtrim(@parte3)) - 1); -- Retirar todo después del guion "-"
SET @cadena = SUBSTRING(@cadena, CHARINDEX('|', @cadena) + 1, LEN(@cadena));
SET @parte4 = @cadena;
SET @parte5 = 'MU';
SET @horaTime = CONVERT(TIME, STUFF(STUFF(@horaStr, 5, 0, ':'), 3, 0, ':'), 8);
SET @fechaHora = CONVERT(DATETIME, CONCAT(@parte3, ' ', CONVERT(VARCHAR(12), @horaTime)), 12);
--SELECT RTRIM(@parte4) AS SerialNumber,RTRIM(@parte1) AS Volt, RTRIM(@parte2) AS RPM, CONVERT(datetime, @fechaHora, 12) AS DateTimeMotor,CONVERT(datetime, @fechaHora, 12) AS UtcDateTimeSerial, RTRIM(@parte5) AS Linea;
INSERT INTO [dbo].[MotorsData]
           ([SerialNumber]
           ,[Volt]
           ,[RPM]
           ,[DateTimeMotor]
           ,[UtcDateTimeSerial]
           ,[Line])
           (SELECT RTRIM(@parte4) AS SerialNumber,RTRIM(@parte1) AS Volt, RTRIM(@parte2) AS RPM, CONVERT(datetime, @fechaHora, 12) AS DateTimeMotor,CONVERT(datetime, @fechaHora, 12) AS UtcDateTimeSerial, RTRIM(@parte5) AS Linea)