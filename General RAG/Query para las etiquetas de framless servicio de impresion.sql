DECLARE @transmission_id INT
        SET @transmission_id =9388788


DECLARE
		@hr INT,
		@err_source NVARCHAR(50),
		@err_description NVARCHAR(4000),
		@line NVARCHAR(50),			-- Line identifier (ie LA, LB, ...)
		@type NVARCHAR(50),			-- Product type (ie WB)
		@part_no NVARCHAR(50),		-- Part number
		@part_rev NVARCHAR(50),		-- Part revision
		@julian_day INT,			-- Day of the year
		@year INT,					-- Year (four digits)
		@line_code NVARCHAR(50),	-- Product type + line identifier
		@reference NVARCHAR(50),	-- External reference
		@ratio NVARCHAR(50),		-- ?
        @patent1        nvarchar(50),
        @patent2        nvarchar(50),
        @patent3        nvarchar(50),
        @patent4        nvarchar(50),
        @patent5        nvarchar(50),
        @patent6        nvarchar(50),
        @patent7        nvarchar(50),
        @patent8        nvarchar(50),
		@is_double_lid BIT;			-- Indicates whether double print is required

	SELECT
    @line           = t.[line],
    @type           = t.[type],
    @part_no        = t.[serial],
    @part_rev       = t.[rev],
    @julian_day     = t.[julian_day],
    @year           = t.[year],
    @line_code      = t.[type] + ' ' + t.[line],
    @reference      = RTRIM(p.ref_ext),
    @ratio          = t.ratio,
    @patent1        = pt.patent1,
    @patent2        = pt.patent2,
    @patent3        = pt.patent3,
    @patent4        = pt.patent4,
    @patent5        = pt.patent5,
    @patent6        = pt.patent6,
    @patent7        = pt.patent7,
    @patent8        = pt.patent8,
    @is_double_lid  = CASE WHEN t.print_count = 1 THEN 0 ELSE 1 END
FROM APPS.dbo.pro_tms t
JOIN APPS.dbo.pro_production p ON p.id = t.id_reference
JOIN [MXSRVCEGID].[PMI].[dbo].[UARTICLE] C  ON C.ARKTCODART = p.part_number
JOIN [MXSRVTRACA].[APPS].[dbo].[patent] pt ON pt.sufix_cegid = C.ARKTPATENT
--WHERE t.id = @transmission_id --AND C.ARKTCODART = @part_no
--WHERE t.id = @transmission_id AND p.ref_ext COLLATE French_CI_AS = @reference
WHERE t.id = @transmission_id AND p.ref_ext COLLATE French_CI_AS = @reference COLLATE French_CI_AS


select * from APPS.dbo.pro_production
select * from [MXSRVCEGID].[PMI].[dbo].[UARTICLE]
select * from [MXSRVTRACA].[APPS].[dbo].[patent]

-- SELECT *
-- FROM [MXSRVCEGID].[PMI].[dbo].[UARTICLE]
-- WHERE CONCAT(
--         ARKTSOC, 
--         ARKTCODART, 
--         ARKTCOMART, 
--         ARKTGESTIO, 
--         ARKTCONDI, 
--         ARKTEMPL, 
--         ARKCRITPAR, 
--         ARKMAGASIN, 
--         ARKNEXTOP, 
--         APKUPC, 
--         APKCONTENE, 
--         APKSTDPACK, 
--         APKSMKT, 
--         APKBOLSA, 
--         APKRATIO, 
--         ARKTPURCAT, 
--         ARKTPURFAM, 
--         ARKTPURMNG, 
--         ARKTPURBUY, 
--         APKHTS, 
--         APKFRACION, 
--         APKORIGEN, 
--         APKFTID, 
--         APKAREAUSO, 
--         APKCONT001, 
--         APKNPCECON, 
--         APKBOLSA2, 
--         APKDIAPRUE, 
--         APKOTD, 
--         APKSKIPLOT, 
--         ARKTRESP, 
--         ARKTNBEMPR, 
--         ARKTPMIN, 
--         ARKTPMAX, 
--         ARKPULL, 
--         ARKTPURSTA, 
--         ARKTPRULOT, 
--         ARKTTELECT, 
--         ARKTMASTER, 
--         ARKTNBID, 
--         ARKTGAREMU, 
--         ARKTCERTIF, 
--         ARKTINTAUT, 
--         ARKTIMETO, 
--         ARKTPATENT, 
--         APKNPCECO2
--     ) LIKE '%85779%';


--ARKTPATENT
--JOIN [MXSRVCEGID].[PMI].[dbo].[UARTICLE] C ON C.ARKTPATENT = pt.sufix_cegid COLLATE French_CI_AS
--JOIN [MXSRVTRACA].[APPS].[dbo].[patent] pt ON pt.sufix_cegid = C.ARKTPATENT COLLATE French_CI_AS;


    --WHERE t.id = @transmission_id --AND C.ARKTCODART = @part_no

--select * from MXSRVTRACA.APPS.dbo.patent


--     SELECT t.sufix_cegid AS [Patente],
--        t.patent1,
--        t.patent2,
--        t.patent3,
--        t.patent4,
--        t.patent5,
--        t.patent6,
--        t.patent7,
--        t.patent8
-- FROM [MXSRVTRACA].[APPS].[dbo].[patent] t
-- JOIN [MXSRVCEGID].[PMI].[dbo].[UARTICLE] C
-- ON t.sufix_cegid = C.ARKTPATENT COLLATE French_CI_AS 
-- WHERE C.ARKTCODART = '85779'
-- order by t.sufix_cegid asc

-- declare @part_no VARCHAR(50)
-- set @part_no = ''

-- select top 1000 * 	FROM APPS.dbo.pro_tms t
--     JOIN APPS.dbo.pro_production p ON p.id = t.id_reference
--     WHERE p.part_number IN ('85746', '85747', '85776', '85777', '85778', '85779','389016','389016')
--     --where p.part_number = '85779'
--         --where p.part_number = @part_no
--     --WHERE t.id = @transmission_id;

-- SELECT * from [MXSRVCEGID].[PMI].[dbo].[UARTICLE] where ARKTCODART = '85779'

-- --SELECT * from [MXSRVCEGID].[PMI].[dbo].[UARTICLE] where ARKTPATENT IS NOT NULL AND ARKTPATENT != "" 

-- SELECT * from [MXSRVCEGID].[PMI].[dbo].[UARTICLE] where ARKTPATENT IS NOT NULL AND LEN(ARKTPATENT) > 0

-- SELECT DISTINCT  RTRIM((ARKTCODART)) from [MXSRVCEGID].[PMI].[dbo].[UARTICLE] where ARKTPATENT IS NOT NULL AND LEN(ARKTPATENT) > 0
-- --85746
-- --85747
-- --85776
-- --85777
-- --85778
-- --85779

--     select distinct(part_number) FROM APPS.dbo.pro_production