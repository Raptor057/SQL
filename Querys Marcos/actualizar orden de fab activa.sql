/**
 * Se actualiza la orden de fabricacion activa en GTT.
 * Primero se cancela la activa y despues se activa una nueva.
 */
UPDATE LineProductionSchedule
SET UtcExpirationTime = GETUTCDATE()
WHERE LineCode='LP' AND UtcExpirationTime='2099-12-31 23:59:59.997';

INSERT INTO LineProductionSchedule(LineCode, WorkOrderCode, PartNo, HourlyRate, UtcEffectiveTime, UtcExpirationTime)
VALUES('LP', 'W07648036', '85621-CHREARMX', 1, GETUTCDATE(), '2099-12-31 23:59:59.997');
