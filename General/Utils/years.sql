WITH years (year) AS (
    SELECT 2021
    UNION ALL
    SELECT year + 1 FROM years WHERE year < YEAR(GETDATE())
)
SELECT * FROM years;