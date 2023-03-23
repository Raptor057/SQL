-- =============================================
-- Author:		Marcos Vazquez
-- Create date: November 26, 2021
-- Description:	Print a label by sending an HTTP POST request against the printing
--				WEB API in MXSRVAPPS.
--				This procedure makes use of the OLE Automation stored procedures and is
--				based on the content found at
--
--					https://www.zealousweb.com/calling-rest-api-from-sql-server-stored-procedure/.
--
--				More information can be found here:
--
--					https://docs.microsoft.com/en-us/sql/relational-databases/system-stored-procedures/ole-automation-stored-procedures-transact-sql?view=sql-server-ver15
--
-- Parameters:
--   @transmission_id	- Product's unique identifier
--   @message			- Hint to the resulting state
--
-- Returns:     Zero if everything went OK.
--
-- Change History:
--   00/00/00 XX:	...
-- =============================================
CREATE PROCEDURE [dbo].[usp_print_individual_label]
	@transmission_id BIGINT,
	@message NVARCHAR(4000) OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

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
		@origen NVARCHAR(50),		-- Get Origen from CEGID
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
		@is_double_lid	= CASE WHEN t.print_count = 1 THEN 0 ELSE 1 END
	FROM APPS.dbo.pro_tms t
    JOIN APPS.dbo.pro_production p ON p.id = t.id_reference
    WHERE t.id = @transmission_id;
	set @origen =(SELECT * FROM ufn_GetArticleOrigenCegid(@part_no,@part_rev)) --Get Origen by part_no and part_rev directly of CEGID


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
		"Origen": "{origen}",
		"IsDoubleLid": {isDoubleLid}
	}';

	--Se agrego un (REPLACE en esta linea
	SET @Body = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@Body,
						'{tmId}', CAST(@transmission_id AS NVARCHAR(50))),
						'{partRev}', @part_rev),
						'{partNo}', @part_no),
						'{julianDay}', CAST(@julian_day AS NVARCHAR(50))),
						'{year}', CAST(@year AS NVARCHAR(50))),
						'{lineCode}', @line_code),
						'{reference}', @reference),
						'{ratio}', @ratio),
						'{origen}', RTRIM(@origen)), --Se el campo Origen.
						'{isDoubleLid}', CASE WHEN @is_double_lid = 1 THEN 'true' ELSE 'false' END)
	;

	EXEC @hr = sp_OACreate 'MSXML2.XMLHTTP', @Object OUT;
	IF @hr <> 0
	BEGIN
		EXEC sp_OAGetErrorInfo @Object, @err_source OUT, @err_description OUT;
		SET @message = @err_source + ': ' + @err_description;
		RETURN -1;
	END

	EXEC @hr = sp_OAMethod @Object, 'open', NULL, 'post', @URL, 'false';
	IF @hr <> 0
	BEGIN
		EXEC sp_OAGetErrorInfo @Object, @err_source OUT, @err_description OUT;
		SET @message = @err_source + ': ' + @err_description;
		RETURN -1;
	END

	EXEC @hr = sp_OAMethod @Object, 'setRequestHeader', null, 'Content-Type', 'application/json';
	IF @hr <> 0
	BEGIN
		EXEC sp_OAGetErrorInfo @Object, @err_source OUT, @err_description OUT;
		SET @message = @err_source + ': ' + @err_description;
		RETURN -1;
	END

	EXEC @hr = sp_OAMethod @Object, 'send', null, @body;
	IF @hr <> 0
	BEGIN
		EXEC sp_OAGetErrorInfo @Object, @err_source OUT, @err_description OUT;
		SET @message = @err_source + ': ' + @err_description;
		RETURN -1;
	END

	EXEC @hr = sp_OAMethod @Object, 'responseText', @message OUT;
	IF @hr <> 0
	BEGIN
		EXEC sp_OAGetErrorInfo @Object, @err_source OUT, @err_description OUT;
		SET @message = @err_source + ': ' + @err_description;
		RETURN -1;
	END

	EXEC sp_OADestroy @Object;

	SET @message = 'SUCCESS';
	RETURN 0;
END;