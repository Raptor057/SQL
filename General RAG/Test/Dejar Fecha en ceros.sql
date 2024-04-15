--quitarle los segundos a la fecha para dejarla en 00:00:00.000

declare @originalDate datetime
select @originalDate = GETUTCDATE()

declare @withoutTime datetime
select @withoutTime = dateadd(d, datediff(d, 0, @originalDate), 0)

select @withoutTime