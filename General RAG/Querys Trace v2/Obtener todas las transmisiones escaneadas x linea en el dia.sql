
declare @originalDate datetime
select @originalDate = GETUTCDATE()-1
declare @withoutTime datetime
select @withoutTime = dateadd(d, datediff(d, 0, @originalDate), 0)

--select @withoutTime

SELECT TOP (1000) * FROM [gtt].[dbo].[ProcessHistory] where LineCode = 'LE' and UtcTimeStamp > @withoutTime order by UtcTimeStamp DESC

--DELETE [ProcessHistory] where LineCode = 'LE' and UtcTimeStamp > @withoutTime 