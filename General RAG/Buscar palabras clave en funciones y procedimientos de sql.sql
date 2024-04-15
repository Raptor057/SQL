SELECT DISTINCT OBJECT_NAME(sm.object_id) AS procedure_name
FROM sys.sql_modules sm
WHERE sm.definition LIKE '%timezone%'
