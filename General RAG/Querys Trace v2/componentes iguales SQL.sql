DECLARE @part_rev VARCHAR(15),
@part_no VARCHAR(15)
SET @part_no = '85208'
SET @part_rev = 'LC'

SELECT TOP (1000) 
NOKTCODPF,	
NOKTCOMPF,
NOCTCODECP,
NOCTCOMCPT,
NOCTCODOPE,
NOCTTYPOPE,
NOCNQTECOM,
NOKNLIGNOM,
ARCTCODFAM,
ARITNATURE,
ARCTLIB01,
ARCTCOSFAM,
ARKCRITPAR,
APKSTDPACK
FROM [MXSRVTRACA].[TRAZAB].[cegid].[bom] WHERE NOKTCODPF = @part_no AND NOKTCOMPF = @part_rev
EXCEPT
SELECT
			n.NOKTCODPF COLLATE SQL_Latin1_General_CP1_CI_AS AS [NOKTCODPF],         -- final part code (part number)
			n.NOKTCOMPF COLLATE SQL_Latin1_General_CP1_CI_AS AS [NOKTCOMPF],         -- complementary code (part revision)
			--RTRIM(z.ARCTCOSFAM) COLLATE SQL_Latin1_General_CP1_CI_AS AS [ARCTCOSFAM], -- part family
			RTRIM(n.NOCTCODECP) COLLATE SQL_Latin1_General_CP1_CI_AS AS [NOCTCODECP], -- component number
			RTRIM(n.NOCTCOMCPT) COLLATE SQL_Latin1_General_CP1_CI_AS AS [NOCTCOMCPT], -- component revision
			RTRIM(n.NOCTCODOPE) COLLATE SQL_Latin1_General_CP1_CI_AS AS [NOCTCODOPE], -- operation code (point of use)
			RTRIM(n.NOCTTYPOPE) COLLATE SQL_Latin1_General_CP1_CI_AS AS [NOCTTYPOPE], -- operation type (capacity)
			-- 12/17/21 MV: Added column to include the quantity or time required by the operation.
			RTRIM(CAST(n.NOCNQTECOM AS DECIMAL(18, 4))) AS [NOCNQTECOM],        -- qty/time, decimal
			n.NOKNLIGNOM AS [NOKNLIGNOM],        -- line (operation sequence number)

			RTRIM(a.ARCTCODFAM) COLLATE SQL_Latin1_General_CP1_CI_AS AS [ARCTCODFAM],          -- component family code
			a.ARITNATURE COLLATE SQL_Latin1_General_CP1_CI_AS AS [ARITNATURE],                 -- nature
			RTRIM(LEFT(a.ARCTLIB01, 50)) COLLATE SQL_Latin1_General_CP1_CI_AS AS [ARCTLIB01], -- component description
			RTRIM(a.ARCTCOSFAM) COLLATE SQL_Latin1_General_CP1_CI_AS AS [ARCTCOSFAM],          -- component family
			u.ARKCRITPAR COLLATE SQL_Latin1_General_CP1_CI_AS AS [ARKCRITPAR],
			u.APKSTDPACK AS [APKSTDPACK]                  -- standard pack
		FROM MXSRVCEGID.PMI.dbo.NOMENC n with(nolock)

		JOIN MXSRVCEGID.PMI.dbo.ARTICLE a with(nolock)
			ON a.ARKTSOC = n.NOKTSOC AND a.ARCTFATN != 17 --AND a.ARCTCODFAM IN ('CMP','PMQ','PM', 'DIV')
			AND a.ARKTCODART = n.NOCTCODECP AND a.ARKTCOMART = n.NOCTCOMCPT

		LEFT JOIN MXSRVCEGID.PMI.dbo.UARTICLE u with(nolock)
			ON n.NOCTCODECP = u.ARKTCODART AND n.NOCTCOMCPT = u.ARKTCOMART

		JOIN MXSRVCEGID.PMI.dbo.ARTICLE z with(nolock)
			ON z.ARKTCODART = n.NOKTCODPF AND z.ARKTCOMART = n.NOKTCOMPF
			and z.ARCTFATN != 17

		WHERE n.NOKTSOC = '300' AND NOT (n.NOCTCODOPE = '' OR n.NOCTCODOPE IS NULL)
		and RTRIM(n.NOKTCODPF) = UPPER(@part_no) and RTRIM(n.NOKTCOMPF) = UPPER(@part_rev)