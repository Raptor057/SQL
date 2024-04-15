declare 
@UnitID bigint,
@PartNo nvarchar (50),
@lineCode nvarchar(2),
@WorkOrderCode nvarchar(50),
@revision nvarchar (2)
set @WorkOrderCode = 'W07863552'
set @UnitID = 1
-- set @PartNo = '85540'
-- set @lineCode = 'LC'
set @revision = @lineCode
--EXEC UpsInsertProductionTraceability 8515985, '85540';
--CREATE VIEW dbo.GammasFromCegid AS
--SELECT
--        --RTRIM(n.NOKTCODPF)              [PartNo],
--        --RTRIM(n.NOKTCOMPF)              [PartRev],
--        --RTRIM(z.ARCTCOSFAM)             [PartFamily],
--        RTRIM(n.NOCTCODECP)             [CompNo],
--        --RTRIM(n.NOCTCOMCPT)             [CompRev],
--        --RTRIM(n.NOCTCODOPE)             [PointOfUseCode],
--        --RTRIM(n.NOCTTYPOPE)             [Capacity],
--        --CAST(n.NOCNQTECOM AS INT)       [Quantity],
--        --RTRIM(n.NOKNLIGNOM)             [OperationNo],
--        --RTRIM(a.ARITNATURE)             [Nature],
--        RTRIM(LEFT(a.ARCTLIB01, 50))    [CompDesc]
--        --RTRIM(a.ARCTCODFAM)             [CompFamilyCode],
--        --RTRIM(a.ARCTCOSFAM)             [CompFamily],
--        --u.APKSTDPACK                    [StdPackSize],
--        --n.NOCTCODATE                    [WorkshopCode] 
--    from MXSRVCEGID.PMI.dbo.NOMENC n with(nolock)
--    join MXSRVCEGID.PMI.dbo.ARTICLE a with(nolock)
--        on a.ARKTSOC = n.NOKTSOC and a.ARCTFATN != 17 
--        and a.ARKTCODART = n.NOCTCODECP AND a.ARKTCOMART = n.NOCTCOMCPT
--    left join MXSRVCEGID.PMI.dbo.UARTICLE u with(nolock)
--        on n.NOCTCODECP = u.ARKTCODART AND n.NOCTCOMCPT = u.ARKTCOMART
--    --join MXSRVCEGID.PMI.dbo.ARTICLE z with(nolock)
--    --    on z.ARKTCODART = n.NOKTCODPF AND z.ARKTCOMART = n.NOKTCOMPF
--    --    and z.ARCTFATN != 17
--    where n.NOKTSOC = '300'
--    -- 03-09-22 PMI is case sensitive
--    and RTRIM(n.NOKTCODPF) = UPPER(@partNo) and RTRIM(n.NOKTCOMPF) = UPPER(@revision)
--    and not (n.NOCTCODOPE = '' OR n.NOCTCODOPE IS NULL);


SELECT
        RTRIM(n.NOKTCODPF)              [PartNo],
        RTRIM(n.NOKTCOMPF)              [PartRev],
        RTRIM(n.NOCTCODECP)             [CompNo],
        RTRIM(LEFT(a.ARCTLIB01, 50))    [CompDesc]
    from MXSRVCEGID.PMI.dbo.NOMENC n with(nolock)
    join MXSRVCEGID.PMI.dbo.ARTICLE a with(nolock)
        on a.ARKTSOC = n.NOKTSOC and a.ARCTFATN != 17 
        and a.ARKTCODART = n.NOCTCODECP AND a.ARKTCOMART = n.NOCTCOMCPT
    left join MXSRVCEGID.PMI.dbo.UARTICLE u with(nolock)
        on n.NOCTCODECP = u.ARKTCODART AND n.NOCTCOMCPT = u.ARKTCOMART
    where n.NOKTSOC = '300'
    -- and RTRIM(n.NOKTCODPF) = UPPER(@partNo) and RTRIM(n.NOKTCOMPF) = UPPER(@revision)
     and RTRIM(n.NOKTCODPF) = UPPER('AEM5.614.2101303-1') and RTRIM(n.NOKTCOMPF) = UPPER('U1')
    and not (n.NOCTCODOPE = '' OR n.NOCTCODOPE IS NULL);


	--select * from GammasFromCegid GFC where PartNo = '84737' and PartRev = 'LC'
