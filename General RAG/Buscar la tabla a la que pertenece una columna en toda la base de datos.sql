
select TABLE_NAME
  from INFORMATION_SCHEMA.COLUMNS
where TABLE_SCHEMA = 'dbo'
and COLUMN_NAME = 'ARKTPATENT'
--    and TABLE_NAME = 'AFFTC'
order by ORDINAL_POSITION



select * from UARTICLE

SELECT DISTINCT(ARKTPATENT) FROM UARTICLE

SELECT COUNT(ARKTCODART) from UARTICLE
SELECT DISTINCT(ARKTCODART) FROM UARTICLE

select ARKTCODART from UARTICLE