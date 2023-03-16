SELECT * FROM UfnLineScheduledRequirement('LO' ,GETDATE(),1)

SELECT * from UfnLineShift('LO',GETDATE())

SELECT * from UfnLineShift('LO','2023-02-23 18:00:00.000')

SELECT * from UfnLineShift('LO',GETUTCDATE())

select * from UfnProductionTimeIntervals('LO',null,'50')

--select * FROM UspSetLineHeadcount('LO', 'W07815224', 1)