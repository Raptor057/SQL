SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rogelio Arriaga
-- Create date: 03/03/2323
-- Description:	This function receives the Line Code and returns a table with all currently active components.

-- Parameters: @linecode Two characters representing the production line.
--   @line_code  - Two characters representing the production line.
-- Returns:     Table with all currently active components

-- Change History:
--   03/03/23 RA:	Function created.
-- =============================================
CREATE FUNCTION UfnGetActiveEtisInLine 
(	
	 @linecode VARCHAR(2)
)
RETURNS TABLE 
AS
RETURN 
(
SELECT *  FROM PointOfUseEtis where PointOfUseCode LIKE (CONCAT((select top 1 value from string_split(@linecode,'L') order by value desc),'%')) and UtcUsageTime <= GETUTCDATE() AND UtcExpirationTime IS NULL
)
GO
