-- SELECT [item_id]
--       ,[operation_id]
--       ,[initial_status]
--       ,[closing_status]
--       ,[repairer_id]
--       ,[repair_time]
--       ,[comments]
--   FROM [water_heater_repair].[dbo].[items_x_operations] --WHERE item_id = 100
--   WHERE closing_status is null and initial_status != '' and initial_status != 'x'
--   --order BY item_id DESC,operation_id ASC


DECLARE @item_id INT = 1045;
DECLARE @operation_id INT;

WHILE @item_id <= 1744
BEGIN
INSERT INTO [water_heater_repair].[dbo].[items_x_operations] (item_id, operation_id, initial_status)
VALUES

-- (@item_id,1, ''),
-- (@item_id,2, ''),
-- (@item_id,3, ''),
-- (@item_id,4, ''),
-- (@item_id,5, ''),
-- (@item_id,6, ''),
-- (@item_id,7, ''),
-- (@item_id,8, ''),
-- (@item_id,9, ''),
-- (@item_id,10, ''),
-- (@item_id,11, ''),
-- (@item_id,12, ''),
-- (@item_id,13, ''),
-- (@item_id,14, ''),
-- (@item_id,15, ''),
-- (@item_id,16, ''),
-- (@item_id,17, ''),
-- (@item_id,18, ''),
-- (@item_id,19, ''),
-- (@item_id,20, ''),
-- (@item_id,21, ''),
-- (@item_id,22, ''),
-- (@item_id,23, ''),
-- (@item_id,24, ''),
-- (@item_id,25, ''),
-- (@item_id,26, ''),
-- (@item_id,27, ''),
-- (@item_id,28, ''),
-- (@item_id,29, ''),
-- (@item_id,30, ''),
-- (@item_id,31, ''),
-- (@item_id,32, ''),
-- (@item_id,33, ''),
-- (@item_id,34, ''),
-- (@item_id,35, ''),
-- (@item_id,36, ''),
-- (@item_id,37, ''),
-- (@item_id,38, ''),
-- (@item_id,39, ''),
-- (@item_id,40, ''),
-- (@item_id,41, ''),
-- (@item_id,43, ''),
-- (@item_id,44, ''),

----------------------------
(@item_id, 45, (SELECT [instruction] FROM [water_heater_repair].[dbo].[operations] WHERE id = 45)),
(@item_id, 46, (SELECT [instruction] FROM [water_heater_repair].[dbo].[operations] WHERE id = 46)),
(@item_id, 47, (SELECT [instruction] FROM [water_heater_repair].[dbo].[operations] WHERE id = 47)),
(@item_id, 48, (SELECT [instruction] FROM [water_heater_repair].[dbo].[operations] WHERE id = 48)),
(@item_id, 49, (SELECT [instruction] FROM [water_heater_repair].[dbo].[operations] WHERE id = 49)),
---(@item_id, 50, (SELECT [instruction] FROM [water_heater_repair].[dbo].[operations] WHERE id = 50)),--
--(@item_id, 51, (SELECT [instruction] FROM [water_heater_repair].[dbo].[operations] WHERE id = 51)),--Al parecer este sobra
---(@item_id, 52, (SELECT [instruction] FROM [water_heater_repair].[dbo].[operations] WHERE id = 52)),--
---(@item_id, 53, (SELECT [instruction] FROM [water_heater_repair].[dbo].[operations] WHERE id = 53)),--
(@item_id, 54, (SELECT [instruction] FROM [water_heater_repair].[dbo].[operations] WHERE id = 54)),
(@item_id, 55, (SELECT [instruction] FROM [water_heater_repair].[dbo].[operations] WHERE id = 55)),
(@item_id, 58, (SELECT [instruction] FROM [water_heater_repair].[dbo].[operations] WHERE id = 58)),
(@item_id, 56, (SELECT [instruction] FROM [water_heater_repair].[dbo].[operations] WHERE id = 56)),
(@item_id, 57, (SELECT [instruction] FROM [water_heater_repair].[dbo].[operations] WHERE id = 57));
SET @item_id = @item_id + 1;
END

-- orden
--  45,
--   46,
-- 47,
-- 48,
-- 49,
-- 50,
-- 51,
-- 52,
-- 53,
-- 54,
-- 55,
-- 58,
-- 56,
-- 57