    DECLARE @PN VARCHAR(25)
    DECLARE @REV VARCHAR(25)
    DECLARE @ID_LABEL VARCHAR(25)
    DECLARE @LOT VARCHAR(25)

    DECLARE @SKIPLOT NCHAR(1)

    SELECT TOP 1 @PN = r.part_number, @REV = pe.rev_cc, @ID_LABEL = r.id_label,@LOT=PE.lot
    FROM [APPS].[dbo].[radio_reception] R
    INNER JOIN pro_eti001 PE ON r.id_label=PE.id   
    ORDER BY r.id DESC;

set @SKIPLOT =(select top 1 RTRIM(APKSKIPLOT) FROM [mxsrvcegid].[PMI].[dbo].[UARTICLE]
WHERE RTRIM(ARKTCODART) =@PN  AND RTRIM(ARKTCOMART)=@REV)

-- Imprime los valores para comprobar
--SELECT @PN, @REV, @ID_LABEL, @SKIPLOT,@LOT;


    IF @SKIPLOT = '0'
    BEGIN
        UPDATE pro_eti001 SET is_verified = 1, is_approved = 1 WHERE id = @ID_LABEL;
        insert into qty_eti001_approvals ([id_label],[lot],[is_approved],[comment],[created_by]) VALUES (@ID_LABEL,@LOT,1,'SKIPLOT OK',222)
    END
