DECLARE @Year INT
SET @Year = YEAR(GETDATE())

IF ((@Year % 4 = 0 AND @Year % 100 <> 0) OR (@Year % 400 = 0))
DECLARE @Days INT = 366
--   PRINT 'El año ' + CAST(@Year AS VARCHAR) + ' es bisiesto.'
ELSE
set @Days = 365
--   PRINT 'El año ' + CAST(@Year AS VARCHAR) + ' no es bisiesto.'
SELECT @Days


SELECT DATEDIFF(DAY,GETDATE()-10,GETDATE())