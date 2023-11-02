SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[skiplotpro_eti001]
ON [APPS].[dbo].[radio_reception]
AFTER INSERT
AS
BEGIN
    DECLARE @PN VARCHAR(25)
    DECLARE @REV VARCHAR(25)
    DECLARE @ID_LABEL VARCHAR(25)
    DECLARE @SKIPLOT NCHAR(1)

    SELECT TOP 1 @PN = r.part_number, @REV = pe.rev_cc, @ID_LABEL = r.id_label
    FROM [APPS].[dbo].[radio_reception] R
INNER JOIN pro_eti001 PE ON r.id_label=PE.id   
    ORDER BY r.id DESC;

set @SKIPLOT =(select top 1 RTRIM(APKSKIPLOT) FROM [mxsrvcegid].[PMI].[dbo].[UARTICLE]
WHERE RTRIM(ARKTCODART) =@PN  AND RTRIM(ARKTCOMART)=@REV)

-- Imprime los valores para comprobar
--SELECT @PN, @REV, @ID_LABEL, @SKIPLOT;


    IF @SKIPLOT = '1'
    BEGIN
        UPDATE pro_eti001 SET is_verified = 1, is_approved = 1 WHERE id = @ID_LABEL;
    END
END;
GO
ALTER TABLE [dbo].[radio_reception] ENABLE TRIGGER [skiplotpro_eti001]
GO
