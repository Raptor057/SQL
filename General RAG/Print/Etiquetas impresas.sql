SELECT TOP (1000) 
s.line,
t.utc_time_stamp,
t.processing_time,
t.result_message
FROM [functional_tests].[dbo].[test_bench_message] t
lEFT JOIN sources_x_lines s 
ON s.source = t.source
ORDER BY t.ID DESC