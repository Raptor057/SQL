DECLARE @linea NVARCHAR(50) = 'WB LE', @NP nvarchar(50) = '';

SELECT * FROM dbo.pro_prod_units WHERE comments = @linea;

select * from pro_production where id_line = 19 and is_running=1 and is_stoped = 0 and is_finished = 0;