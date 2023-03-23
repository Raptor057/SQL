--===============Pruebas!!!!!===============
DECLARE
@82015 VARCHAR(50),
@82021 VARCHAR(50),
@87245 VARCHAR(50)
set @82015 =(SELECT top 1 id FROM APPS.dbo.pro_tms where serial LIKE ('%82015%') ORDER BY id DESC) -- t
set @82021 =(SELECT top 1 id FROM APPS.dbo.pro_tms where serial LIKE ('%82021%') ORDER BY id DESC) -- t
set @87245 = (SELECT top 1 id FROM APPS.dbo.pro_tms where serial LIKE ('%87245%') ORDER BY id DESC) -- t
declare @transmission_id VARCHAR(50)
--set @transmission_id = @82015

set @transmission_id = '9440980'
--=========================================

--set @transmission_id = @82021
--set @transmission_id = @82015
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
		@station NVARCHAR(50),	-- LINE P STATION
		@reference NVARCHAR(50),	-- External reference
		@ratio NVARCHAR(50),		-- ?
		@origen NVARCHAR(50),		-- Get Origen from CEGID
		@p1 nvarchar(50),
		@p2 nvarchar(50),
		@p3 nvarchar(50),
		@p4 nvarchar(50),
		@p5 nvarchar(50),
		@p6 nvarchar(50),
		@p7 nvarchar(50),
		@p8 nvarchar(50),
		@is_double_lid BIT;			-- Indicates whether double print is required

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
		@station        = t.station,
		@is_double_lid	= CASE WHEN t.print_count = 1 THEN 0 ELSE 1 END
	FROM APPS.dbo.pro_tms t
    JOIN APPS.dbo.pro_production p ON p.id = t.id_reference
    WHERE t.id = @transmission_id;
	--======================
	set @origen =(SELECT top 1 * FROM ufn_GetArticleOrigenCegid(@part_no,@part_rev)) --Get Origen by part_no and part_rev directly of CEGID
	select @part_no
	SELECT @part_rev
	--SELECT top 1 * FROM ufn_GetArticleOrigenCegid(@part_no,SUBSTRING(@part_rev, 1, 1))


			SELECT
		@p1 = R.patente1,
		@p2 = R.patente2,
		@p3 = R.patente3,
		@p4 = R.patente4,
		@p5 = R.patente5,
		@p6 = R.patente6,
		@p7 = R.patente7,
		@p8 = R.patente8
		FROM ufn_GetPatentsByPartNoAndRev(@part_no,@part_rev) R;
	--=======================
	DECLARE @URL NVARCHAR(MAX) = REPLACE(REPLACE('http://mxsrvapps/gtservices/printing/api/productlines/{line}/individuallabels/{type}', '{line}', @line), '{type}', @type);
	DECLARE @Object AS INT;
	DECLARE @ResponseText AS VARCHAR(8000);
	DECLARE @Body AS VARCHAR(8000) =
	'{
		"FinishGoodID": {tmId},
		"Revision": "{partRev}",
		"SerialNo": "{partNo}",
		"JulianDay": {julianDay},
		"Year": {year},
		"LineCode": "{lineCode}",
		"ExternalReference": "{reference}",
		"Ratio": "{ratio}",
		"IsDoubleLid": {isDoubleLid},
		"Station": "{station}",
		"Origen": "{origen}",
		"Patente1": "{patente1}",
		"Patente2": "{patente2}",
		"Patente3": "{patente3}",
		"Patente4": "{patente4}",
		"Patente5": "{patente5}",
		"Patente6": "{patente6}",
		"Patente7": "{patente7}",
		"Patente8": "{patente8}"
	}';

	SET @Body = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@Body,
						'{tmId}', CAST(@transmission_id AS NVARCHAR(50))),
						'{partRev}', @part_rev),
						'{partNo}', @part_no),
						'{station}', @station),
						'{julianDay}', CAST(@julian_day AS NVARCHAR(50))),
						'{year}', CAST(@year AS NVARCHAR(50))),
						'{lineCode}', @line),
						'{reference}', @reference),
						-- 2022-22-04 RA: Add Origen From CEGID with ussing a function GetArticleOrigenCegid.
						'{origen}', ISNULL(NULLIF(RTRIM(@origen), ''), ' ')),
						-- 2023-23-04 RA: Add patent From CEGID and APPS with ussing a function Get[atentsByPartNoAndRev.
						'{patente1}', ISNULL(NULLIF(RTRIM(@p1), ''), ' ')),
						'{patente2}', ISNULL(NULLIF(RTRIM(@p2), ''), ' ')),
						'{patente3}', ISNULL(NULLIF(RTRIM(@p3), ''), ' ')),
						'{patente4}', ISNULL(NULLIF(RTRIM(@p4), ''), ' ')),
						'{patente5}', ISNULL(NULLIF(RTRIM(@p5), ''), ' ')),
						'{patente6}', ISNULL(NULLIF(RTRIM(@p6), ''), ' ')),
						'{patente7}', ISNULL(NULLIF(RTRIM(@p7), ''), ' ')),
						'{patente8}', ISNULL(NULLIF(RTRIM(@p8), ''), ' ')),
						-- 2022-03-10 MV: Value might have blank space to the right affecting the label output.
						'{ratio}', ISNULL(NULLIF(RTRIM(@ratio), ''), 'NA')),
						'{isDoubleLid}', CASE WHEN @is_double_lid = 1 THEN 'true' ELSE 'false' END);
                       SELECT @Body