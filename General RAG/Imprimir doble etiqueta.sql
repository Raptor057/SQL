declare @codew nvarchar (50)
set @codew = 'W07871357' -- aqui va el numero de orden de lo que se esta corriendo

select * from pro_production  where codew = @codew 
UPDATE pro_production SET dblid = 2 WHERE codew = @codew
