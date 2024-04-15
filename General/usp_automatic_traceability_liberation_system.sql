CREATE PROCEDURE usp_automatic_traceability_liberation_system
    @LineCode VARCHAR(25)
AS
BEGIN
    DECLARE @Linea VARCHAR(25)
    DECLARE @Part_Num VARCHAR(25)
    DECLARE @CodeWO VARCHAR(25)
    DECLARE @Qty INT
    DECLARE @Aproved VARCHAR(25)
    DECLARE @Fecha VARCHAR(25)
    DECLARE @Rev VARCHAR(25)
    DECLARE @PNClient VARCHAR(25)
    DECLARE @FechaApp VARCHAR(25)
    DECLARE @UserApp VARCHAR(25)

    SELECT TOP (1000)
        @Linea = PPU.comments,
        @Part_Num = PP.[part_number],
        @CodeWO = PP.[codew],
        @Qty = PP.[std_pack],
        @Aproved = 1,
        @FechaApp = FORMAT (GETDATE(), 'dd-MMM-yyyy'),
        @UserApp = 'AUTOMATIC TRACEABILITY LIBERATION SYSTEM',
        @PNClient = pp.ref_ext,
        @Rev = pp.rev,
        @Fecha = FORMAT (GETDATE(), 'dd-MMM-yyyy')
    FROM [MXSRVTRACA].[APPS].[dbo].[pro_production] PP
    INNER JOIN [MXSRVTRACA].[APPS].[dbo].pro_prod_units PPU ON PP.id_line = PPU.id
    WHERE PP.is_stoped = 0 AND PP.is_running = 1 AND PP.is_finished = 0 AND PPU.letter = @LineCode

    INSERT INTO [MXSRVTRACA].[TRAZAB].[dbo].[Tbl_qc_aproved_list] (linea, part_num, codewo, qty, is_approved, fecha_app, user_app, PN_Cliente, rev, fecha)
    VALUES (@Linea, @Part_Num, @CodeWO, @Qty, @Aproved, @FechaApp, @UserApp, @PNClient, @Rev, @Fecha)
END
