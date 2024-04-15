DECLARE @lineCode VARCHAR(50),
@partnum VARCHAR(50)

SET @lineCode ='LE'
set @partnum = '87245'


SELECT  top 100 * FROM Master_labels_WB WHERE line LIKE (CONCAT('%',@lineCode,'%')) AND part_num = @partnum and is_active != 0 order BY id DESC

--UPDATE Master_labels_WB SET is_active =0 WHERE Id IN (57139)
-- UPDATE Master_labels_WB SET is_active =0 WHERE Id IN (55809,
-- 55758,
-- 55755)