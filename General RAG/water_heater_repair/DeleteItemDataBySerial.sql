-- DECLARE @serial VARCHAR(50)


-- UPDATE [water_heater_repair].[dbo].[items_x_operations] 
-- SET closing_status = NULL
-- WHERE item_id = (SELECT TOP 1 [item_id]
--   FROM [water_heater_repair].[dbo].[item_serials] WHERE UtcTimeStamp is not null
-- and serial_no = @serial)

-- delete [water_heater_repair].[dbo].[item_operation_photos] WHERE item_id = (SELECT TOP 1 [item_id]
--   FROM [water_heater_repair].[dbo].[item_serials] WHERE UtcTimeStamp is not null
-- and serial_no = @serial)

-- delete [water_heater_repair].[dbo].[item_operation_values] WHERE item_id = (SELECT TOP 1 [item_id]
--   FROM [water_heater_repair].[dbo].[item_serials] WHERE UtcTimeStamp is not null
-- and serial_no = @serial)

--   update [water_heater_repair].[dbo].[items] SET 
--   repair_date = NULL, 
--   repairer_name = NULL,
--   welder_name = NULL,
--   new_yellow_wiring_batch_no = NULL,
--   new_black_wiring_batch_no = NULL,
--   flash_the_data_matrix=NULL,
--   validation_time = NULL,
--   status_id = 1 
--   WHERE id = (SELECT TOP 1 [item_id]
--   FROM [water_heater_repair].[dbo].[item_serials] WHERE UtcTimeStamp is not null
-- and serial_no = @serial)


CREATE PROCEDURE DeleteItemDataBySerial
    @serial VARCHAR(50)
AS
BEGIN
    DECLARE @item_id INT;

    -- Obtener el item_id basado en el serial
    SELECT TOP 1 @item_id = [item_id]
    FROM [water_heater_repair].[dbo].[item_serials]
    WHERE UtcTimeStamp IS NOT NULL
    AND serial_no = @serial;

    -- Verificar si se encontró un item_id
    IF @item_id IS NOT NULL
    BEGIN
        -- Actualizar la tabla items_x_operations
        UPDATE [water_heater_repair].[dbo].[items_x_operations]
        SET closing_status = NULL
        WHERE item_id = @item_id;

        -- Eliminar de la tabla item_operation_photos
        DELETE FROM [water_heater_repair].[dbo].[item_operation_photos]
        WHERE item_id = @item_id;

        -- Eliminar de la tabla item_operation_values
        DELETE FROM [water_heater_repair].[dbo].[item_operation_values]
        WHERE item_id = @item_id;

        -- Actualizar la tabla items
        UPDATE [water_heater_repair].[dbo].[items]
        SET 
            repair_date = NULL,
            repairer_name = NULL,
            welder_name = NULL,
            new_yellow_wiring_batch_no = NULL,
            new_black_wiring_batch_no = NULL,
            flash_the_data_matrix = NULL,
            validation_time = NULL,
            status_id = 1
        WHERE id = @item_id;

        -- Mensaje de confirmación
        PRINT 'El item con serial_no ' + @serial + ' y item_id ' + CAST(@item_id AS VARCHAR) + ' ha sido eliminado correctamente.';
    END
    ELSE
    BEGIN
        -- Mensaje en caso de que no se encuentre el serial
        PRINT 'No se encontró un item con el serial_no: ' + @serial;
    END
END;
