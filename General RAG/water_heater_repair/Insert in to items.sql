DECLARE @item_id INT = 999;
DECLARE @is_validated INT = 0; -- Asigna un valor a operation_id según sea necesario
DECLARE @status_id INT = 1
WHILE @item_id <= 1044
BEGIN
    insert into [water_heater_repair].[dbo].[items]([id],[is_validated],[status_id])
    VALUES (@item_id, @is_validated, @status_id); 

    SET @item_id = @item_id + 1;
END
