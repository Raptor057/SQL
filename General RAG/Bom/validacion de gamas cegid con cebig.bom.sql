DECLARE @part_no as VARCHAR (50),
@revision VARCHAR(50)

set @part_no = '85595'
set @revision = 'LB'

SELECT dbo.CountComponentsBom(@part_no, @revision) AS [CountComponentsBom];