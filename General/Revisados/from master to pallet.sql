DECLARE
    @master_id BIGINT = 41771;

DECLARE @part_no VARCHAR(50), @line_name NVARCHAR(50);

SELECT @part_no = part_num, @line_name = line FROM Master_labels_WB WHERE id = @master_id;

SELECT '@part_no'=@part_no, '@line_name'=@line_name;

RETURN;

IF EXISTS(SELECT * FROM dbo.Temp_pack_WB WHERE linea=@line_name AND num_p=@part_no)
BEGIN
    BEGIN TRANSACTION;
    WITH t AS (
        SELECT TOP 1 * FROM dbo.Temp_pack_WB WHERE linea=@line_name AND num_p=@part_no
    )
    INSERT INTO dbo.Temp_pack_WB(linea, modelo, telesis, fecha, num_p, [LEVEL], IS_partial, Master_id, Aproved)
    SELECT t.linea, t.modelo, x.TM_id, ISNULL(x.pack_time, GETDATE()), t.num_p, t.[LEVEL], t.IS_partial, t.Master_id, t.Aproved FROM t
    JOIN dbo.Master_lbl_TMid x ON x.Master_id = @master_id;
    DELETE FROM dbo.Master_lbl_TMid WHERE Master_id=@master_id;
    UPDATE Master_labels_WB SET is_active=0, qty=0 WHERE id=@master_id;
    ROLLBACK; -- <<<<<<<<<<<<<<<<< COMMIT;
    PRINT 'OK';
END

--select * from dbo.Temp_pack_WB where linea='wb lp' and num_p='85658'