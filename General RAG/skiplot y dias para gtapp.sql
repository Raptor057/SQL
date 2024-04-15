SELECT TOP (1) * FROM [APPS].[dbo].[skipped_batch_list_frequency_check] WHERE part_number = '37723' AND rev = 'A' order by id desc

update [APPS].[dbo].[skipped_batch_list_frequency_check] set frequency_date = GETDATE() WHERE part_number = '37723' AND rev = 'A'

SELECT DATEDIFF(DAY, (SELECT TOP (1) frequency_date FROM [APPS].[dbo].[skipped_batch_list_frequency_check] WHERE part_number = '37723' AND rev = 'A' order by id desc), GETDATE()) AS [Days Transcurred]
