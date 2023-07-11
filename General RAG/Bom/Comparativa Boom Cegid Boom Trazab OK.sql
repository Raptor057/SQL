DECLARE @part_no VARCHAR(50),
@revision VARCHAR(50)

set @part_no = '85540'
set @revision = 'LH'

 SELECT COUNT(*)
 FROM (
        SELECT 
        [NOKTCODPF]
      ,[NOKTCOMPF]
      ,[NOKTCOSFAM]
      ,[i]
      ,[NOCTCODECP]
      ,[NOCTCOMCPT]
      ,[NOCTCODOPE]
      ,[NOCTTYPOPE]
      ,[NOCNQTECOM]
      ,[NOKNLIGNOM]
      ,[ARCTCODFAM]
      ,[ARITNATURE]
      ,[ARCTLIB01]
      ,[ARCTCOSFAM]
      ,[ARKCRITPAR]
      ,[APKSTDPACK]
      ,[NOCTCODATE]
  FROM [TRAZAB].[cegid].[bom] WHERE NOKTCODPF = @part_no and NOKTCOMPF = @revision

EXCEPT

            SELECT
			n.NOKTCODPF COLLATE SQL_Latin1_General_CP1_CI_AS,         -- final part code (part number)
			n.NOKTCOMPF  COLLATE SQL_Latin1_General_CP1_CI_AS,         -- complementary code (part revision)
			RTRIM(z.ARCTCOSFAM) COLLATE SQL_Latin1_General_CP1_CI_AS, -- part family
			ROW_NUMBER() OVER(PARTITION BY n.NOKTCODPF, n.NOKTCOMPF, n.NOCTCODECP ORDER BY n.NOCTCODECP, n.NOCTCOMCPT, n.NOCTCODOPE) [i],
			RTRIM(n.NOCTCODECP) COLLATE SQL_Latin1_General_CP1_CI_AS AS [NOCTCODECP], -- component number
			RTRIM(n.NOCTCOMCPT) COLLATE SQL_Latin1_General_CP1_CI_AS AS [NOCTCOMCPT], -- component revision
			RTRIM(n.NOCTCODOPE) COLLATE SQL_Latin1_General_CP1_CI_AS AS [NOCTCODOPE], -- operation code (point of use)
			RTRIM(n.NOCTTYPOPE) COLLATE SQL_Latin1_General_CP1_CI_AS AS [NOCTTYPOPE], -- operation type (capacity)
-- 12/17/21 MV: Added column to include the quantity or time required by the operation.
            RTRIM(CAST(n.NOCNQTECOM AS DECIMAL(18, 4))) AS [NOCNQTECOM],        -- qty/time, decimal--n.NOCNQTECOM,        -- qty/time, decimal
            n.NOKNLIGNOM,        -- line (operation sequence number)
			RTRIM(a.ARCTCODFAM) COLLATE SQL_Latin1_General_CP1_CI_AS,          -- component family code
            a.ARITNATURE COLLATE SQL_Latin1_General_CP1_CI_AS,                 -- nature
            RTRIM(LEFT(a.ARCTLIB01, 50)) COLLATE SQL_Latin1_General_CP1_CI_AS, -- component description
            RTRIM(a.ARCTCOSFAM) COLLATE SQL_Latin1_General_CP1_CI_AS,          -- component family
			u.ARKCRITPAR COLLATE SQL_Latin1_General_CP1_CI_AS,
            u.APKSTDPACK,                  -- standard pack,
            n.NOCTCODATE COLLATE SQL_Latin1_General_CP1_CI_AS -- Workshop Code
		from MXSRVCEGID.PMI.dbo.NOMENC n with(nolock)
		join MXSRVCEGID.PMI.dbo.ARTICLE a with(nolock)
			on a.ARKTSOC = n.NOKTSOC and a.ARCTFATN != 17 --and a.ARCTCODFAM IN ('CMP','PMQ','PM', 'DIV')
			and a.ARKTCODART = n.NOCTCODECP AND a.ARKTCOMART = n.NOCTCOMCPT
		left join MXSRVCEGID.PMI.dbo.UARTICLE u with(nolock)
			on n.NOCTCODECP = u.ARKTCODART AND n.NOCTCOMCPT = u.ARKTCOMART
		join MXSRVCEGID.PMI.dbo.ARTICLE z with(nolock)
			on z.ARKTCODART = n.NOKTCODPF AND z.ARKTCOMART = n.NOKTCOMPF
			and z.ARCTFATN != 17
		where n.NOKTSOC = '300'
        -- 03-09-22 PMI is case sensitive
        and RTRIM(n.NOKTCODPF) = UPPER(@part_no) and RTRIM(n.NOKTCOMPF) = UPPER(@revision)
        and not (n.NOCTCODOPE = '' OR n.NOCTCODOPE IS NULL)
        		) AS subquery;