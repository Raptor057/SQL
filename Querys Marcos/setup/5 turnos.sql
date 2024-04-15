-- para saber el turno de la linea 
-- para saber hora por hora

SELECT * FROM ShiftSchedules;

SELECT * FROM ShiftScheduleIntervals;

SELECT * FROM LineShiftSchedules
where LineCode = 'E2'

--Linea,Turno 2 es el primero,fecha de inicio, fecha de expiracion
INSERT LineShiftSchedules (LineCode,ShiftScheduleID,EffectiveDay,ExpirationDay)
VALUES ('E2',2,FORMAT(GETUTCDATE(), 'yyyy-MM-dd'),'2099-12-31')