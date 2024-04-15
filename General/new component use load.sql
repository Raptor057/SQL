--select top 100 * from dbo.Tbl_Point_use where linea='LH' and Punto_uso='BM2' and is_used=0 and is_finished=0

-- DECLARE
--     @user_input NVARCHAR(50),
--     @eti_no NVARCHAR(50) = 'E265916-T677245',
--     @line_code NVARCHAR(50) = 'WB LH',
--     @part_no  NVARCHAR(50) = '85540',
--     @part_rev NVARCHAR(50) = 'LH';

DECLARE
    @user_input NVARCHAR(50),
    @eti_no NVARCHAR(50) = 'E242827',
    @line_code NVARCHAR(50) = 'WB LA',
    @part_no  NVARCHAR(50) = '87109-10',
    @part_rev NVARCHAR(50) = 'LA';

DECLARE
    @point_of_use_no NVARCHAR(50),
    @component_no NVARCHAR(50);

SELECT
    @point_of_use_no = Punto_uso,
    @component_no    = Componente
FROM dbo.Tbl_Point_use
WHERE ETI_no=@eti_no AND linea=@part_rev AND NP_final=@part_no
AND is_used=0 AND is_finished=0 AND fecha_retorno IS NULL;

--SELECT '@point_of_use_no'=@point_of_use_no, '@component_no'=@component_no;

IF NOT (@point_of_use_no IS NULL OR @component_no IS NULL)
BEGIN
    IF EXISTS(SELECT * FROM dbo.pumps_x_lines WHERE pump_code=@point_of_use_no)
    BEGIN   
        SELECT 'shared';
    END
    ELSE
    BEGIN
        SELECT 'not shared';
        UPDATE dbo.Tbl_Point_use
        SET expiration_date = UTCDATETIME()
        WHERE linea=@line_code
        AND Punto_uso = @point_of_use_no
        AND componente = @component_no
        AND effective_date IS NOT NULL
        AND expiration_date IS NULL;

        UPDATE dbo.Tbl_Point_use SET effective_date = UTCDATETIME() WHERE ETI_no = @eti_no AND effective_date IS NULL;
    END
END