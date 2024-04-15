SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[skiplotpro_eti001]
ON [APPS].[dbo].[radio_reception]
AFTER INSERT
AS
BEGIN
--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
--     DECLARE @PN VARCHAR(25)
--     DECLARE @REV VARCHAR(25)
--     DECLARE @ID_LABEL VARCHAR(25)
--     DECLARE @LOT VARCHAR(25)

--     DECLARE @SKIPLOT NCHAR(1)

--     SELECT TOP 1 @PN = r.part_number, @REV = pe.rev_cc, @ID_LABEL = r.id_label,@LOT=PE.lot
--     FROM [APPS].[dbo].[radio_reception] R
--     INNER JOIN pro_eti001 PE ON r.id_label=PE.id   
--     ORDER BY r.id DESC;

-- set @SKIPLOT =(select top 1 RTRIM(APKSKIPLOT) FROM [mxsrvcegid].[PMI].[dbo].[UARTICLE]
-- WHERE RTRIM(ARKTCODART) =@PN  AND RTRIM(ARKTCOMART)=@REV)

-- -- Imprime los valores para comprobar
-- --SELECT @PN, @REV, @ID_LABEL, @SKIPLOT,@LOT;


--     IF @SKIPLOT = '1'
--     BEGIN
--         UPDATE pro_eti001 SET is_verified = 1, is_approved = 1 WHERE id = @ID_LABEL;
--         insert into qty_eti001_approvals ([id_label],[lot],[is_approved],[comment],[created_by]) VALUES (@ID_LABEL,@LOT,1,'SKIPLOT OK',222)
--     END
--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
    DECLARE @PN VARCHAR(25)
    DECLARE @REV VARCHAR(25)
    DECLARE @ID_LABEL VARCHAR(25)
    DECLARE @LOT VARCHAR(25)
    
    DECLARE @CRA int --Critico/Recina/Acero

    --DECLARE @SKIPLOT NCHAR(1)

    SELECT TOP 1 @PN = r.part_number, @REV = pe.rev_cc, @ID_LABEL = r.id_label,@LOT=PE.lot
    FROM [APPS].[dbo].[radio_reception] R
    INNER JOIN pro_eti001 PE ON r.id_label=PE.id   
    ORDER BY r.id DESC;

--SET @SKIPLOT =(select top 1 RTRIM(APKSKIPLOT) FROM [mxsrvcegid].[PMI].[dbo].[UARTICLE] WHERE RTRIM(ARKTCODART) =@PN  AND RTRIM(ARKTCOMART)=@REV)

SET @CRA = (SELECT 
COUNT(A.ARKTCODART) AS CRA
--A.ARKTCODART,A.ARKTCOMART,U.ARKCRITPAR,A.ARCTCOSFAM,U.APKSKIPLOT
FROM [mxsrvcegid].[PMI].[dbo].[UARTICLE] U
INNER JOIN [mxsrvcegid].[PMI].[dbo].[ARTICLE] A ON A.ARKTCODART=U.ARKTCODART AND A.ARKTCOMART=U.ARKTCOMART
WHERE U.ARKTCODART ='TEST1'  AND U.ARKTCOMART='C' AND (U.ARKCRITPAR = 'Y' OR A.ARCTCOSFAM = 'RES' OR A.ARCTCOSFAM = 'AC' OR U.APKSKIPLOT != 1))
-- Imprime los valores para comprobar
--SELECT @PN, @REV, @ID_LABEL, @SKIPLOT,@LOT;
            IF @CRA = 0
            BEGIN
                UPDATE pro_eti001 SET is_verified = 1, is_approved = 1 WHERE id = @ID_LABEL;
                insert into qty_eti001_approvals ([id_label],[lot],[is_approved],[comment],[created_by]) VALUES (@ID_LABEL,@LOT,1,'SKIPLOT OK',222)
            END
END;
GO
ALTER TABLE [dbo].[radio_reception] ENABLE TRIGGER [skiplotpro_eti001]
GO
