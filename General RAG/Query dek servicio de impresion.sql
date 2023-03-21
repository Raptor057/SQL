
DECLARE
@82015 VARCHAR(50),
@82021 VARCHAR(50),
@87245 VARCHAR(50)
set @82015 =(SELECT top 1 id FROM APPS.dbo.pro_tms where serial LIKE ('%82015%') ORDER BY id DESC) -- t
set @82021 =(SELECT top 1 id FROM APPS.dbo.pro_tms where serial LIKE ('%82021%') ORDER BY id DESC) -- t
set @87245 = (SELECT top 1 id FROM APPS.dbo.pro_tms where serial LIKE ('%87245%') ORDER BY id DESC) -- t
declare @transmission_id VARCHAR(50)
--set @transmission_id = @82015
--set @transmission_id = @82021
set @transmission_id = @87245
DECLARE
		@hr INT,
		@err_source NVARCHAR(50),
		@err_description NVARCHAR(4000),
		@line NVARCHAR(50),			-- Line identifier (LE LA, LB, ...)
		@type NVARCHAR(50),			-- Product type (ie WB)
		@part_no NVARCHAR(50),		-- Part number
		@part_rev NVARCHAR(50),		-- Part revision
		@julian_day INT,			-- Day of the year
		@year INT,					-- Year (four digits)
		@line_code NVARCHAR(50),	-- Product type + line identifier
		@reference NVARCHAR(50),	-- External reference
		@ratio NVARCHAR(50),		-- ?
        @Origen NVARCHAR(50),
		@is_double_lid BIT;	-- Indicates whether double print is required
	SELECT
		@line			= t.[line],
		@type			= t.[type],
		@part_no		= t.[serial],
		@part_rev		= t.[rev],
		@julian_day		= t.[julian_day],
		@year			= t.[year],
		@line_code		= t.[type] + ' ' + t.[line],
		@reference		= RTRIM(p.ref_ext),
		@ratio			= t.ratio,
        @Origen         =RTRIM(C.APKORIGEN),
        @is_double_lid	= CASE WHEN t.print_count = 1 THEN 0 ELSE 1 END
        FROM APPS.dbo.pro_tms t
        JOIN APPS.dbo.pro_production p ON p.id = t.id_reference
        JOIN [MXSRVCEGID].[PMI].[dbo].[UARTICLE] C ON RTRIM(C.ARKTCODART) = t.serial COLLATE French_CI_AS and RTRIM(C.ARKTCOMART) = t.rev COLLATE French_CI_AS
        WHERE t.id = @transmission_id;
        SELECT CONCAT(@part_no,' ',@part_rev,' ',@Origen)
    --=======================================================================
    --SELECT top 100 * FROM [MXSRVCEGID].[PMI].[dbo].[UARTICLE] C

--SELECT top 1000 * FROM APPS.dbo.pro_production -- p ON p.id = t.id_reference

-- 82015 D1
SELECT top 1000 
-- --*
ARKTCODART,ARKTCOMART,APKORIGEN 
FROM [MXSRVCEGID].[PMI].[dbo].[UARTICLE] WHERE RTRIM(ARKTCODART) like (CONCAT('%',@part_no,'%')) and RTRIM(ARKTCOMART) like (CONCAT('%',@part_rev,'%'))