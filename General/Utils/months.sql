WITH months (month_no) AS (
    SELECT CAST(1 AS INT)
    UNION ALL
    SELECT month_no + 1 FROM months WHERE month_no < 12
)
SELECT
    month_no,
    DATENAME(MONTH, '2020-' + CAST(month_no AS NVARCHAR(2)) + '-01') [month_name]
FROM months;