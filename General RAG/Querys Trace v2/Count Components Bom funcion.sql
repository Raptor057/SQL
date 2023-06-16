SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Rogelio Arriaga
-- Create date: Jun 15, 2023
-- Description: Count of CEGID Bom for a specific revision part number.
--
-- Parameters:
--   @part_no   - Part number
--   @revision  - Revision (for now, this is the line 2 chars code like LA, LB, LT...)
--
-- Returns:     Num of Gama Cegid.
--
-- Change History:
--   06/15/2023 RA: 
-- =============================================
CREATE FUNCTION [dbo].[count_bom_info]
    (@part_no NVARCHAR(50),
    @revision NVARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @CountComponents INT;

    SELECT @CountComponents = COUNT(n.NOKTCODPF)
    FROM MXSRVCEGID.PMI.dbo.NOMENC n WITH (NOLOCK)
    JOIN MXSRVCEGID.PMI.dbo.ARTICLE a WITH (NOLOCK) ON a.ARKTSOC = n.NOKTSOC
        AND a.ARCTFATN != 17
        AND a.ARKTCODART = n.NOCTCODECP
        AND a.ARKTCOMART = n.NOCTCOMCPT
    LEFT JOIN MXSRVCEGID.PMI.dbo.UARTICLE u WITH (NOLOCK) ON n.NOCTCODECP = u.ARKTCODART
        AND n.NOCTCOMCPT = u.ARKTCOMART
    JOIN MXSRVCEGID.PMI.dbo.ARTICLE z WITH (NOLOCK) ON z.ARKTCODART = n.NOKTCODPF
        AND z.ARKTCOMART = n.NOKTCOMPF
        AND z.ARCTFATN != 17
    WHERE n.NOKTSOC = '300'
        AND RTRIM(n.NOKTCODPF) = UPPER(@part_no)
        AND RTRIM(n.NOKTCOMPF) = UPPER(@revision)
        AND NOT (n.NOCTCODOPE = '' OR n.NOCTCODOPE IS NULL);

    RETURN @CountComponents;
END
GO
