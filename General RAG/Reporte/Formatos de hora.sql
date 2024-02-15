SELECT dbo.UfnToUniversalTime(DATEADD(HOUR, 19, DATEADD(DAY, DATEDIFF(DAY, 0, GETDATE()), 0))) --Hacer todo lo anterior pero con hora local y convertirla a UTC

SELECT DATEADD(HOUR, -6, GETUTCDATE()) --Restar o sumar horas a la hora actual

SELECT  DATEADD(DAY, DATEDIFF(DAY, 0, GETUTCDATE()), 0) -- Poner la hora actual en hora 0

SELECT DATEADD(HOUR, 19, DATEADD(DAY, DATEDIFF(DAY, 0, GETDATE()), 0)) -- Poner la hora actual en hora 0 y Restar o sumar horas a la hora actual