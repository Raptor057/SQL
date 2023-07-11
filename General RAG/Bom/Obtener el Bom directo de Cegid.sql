--Obtener el Bom directo de Cegid.
        
--         select top 1
-- 			n.NOKTCODPF,         -- final part code (part number)
-- 			n.NOKTCOMPF,         -- complementary code (part revision)
-- 			RTRIM(z.ARCTCOSFAM), -- part family
-- 			ROW_NUMBER() OVER(PARTITION BY n.NOKTCODPF, n.NOKTCOMPF, n.NOCTCODECP ORDER BY n.NOCTCODECP, n.NOCTCOMCPT, n.NOCTCODOPE) [i],
-- 			RTRIM(n.NOCTCODECP), -- component number
-- 			RTRIM(n.NOCTCOMCPT), -- component revision
-- 			RTRIM(n.NOCTCODOPE), -- operation code (point of use)
-- 			RTRIM(n.NOCTTYPOPE), -- operation type
-- -- 12/17/21 MV: Added column to include the quantity or time required by the operation.
--             --n.NOCNQTECOM,        -- qty/time, decimal
-- 			CAST(n.NOCNQTECOM AS DECIMAL(10, 4)), 
--             n.NOKNLIGNOM,        -- line (operation sequence number)

-- 			RTRIM(a.ARCTCODFAM),          -- component family code
--             a.ARITNATURE,                 -- nature
--             RTRIM(LEFT(a.ARCTLIB01, 50)), -- component description
--             RTRIM(a.ARCTCOSFAM),          -- component family
-- 			u.ARKCRITPAR,
--             u.APKSTDPACK,                  -- standard pack,
--             n.NOCTCODATE -- Workshop Code
-- 		from MXSRVCEGID.PMI.dbo.NOMENC n with(nolock)
-- 		join MXSRVCEGID.PMI.dbo.ARTICLE a with(nolock)
-- 			on a.ARKTSOC = n.NOKTSOC and a.ARCTFATN != 17 --and a.ARCTCODFAM IN ('CMP','PMQ','PM', 'DIV')
-- 			and a.ARKTCODART = n.NOCTCODECP AND a.ARKTCOMART = n.NOCTCOMCPT
-- 		left join MXSRVCEGID.PMI.dbo.UARTICLE u with(nolock)
-- 			on n.NOCTCODECP = u.ARKTCODART AND n.NOCTCOMCPT = u.ARKTCOMART

-- 		join MXSRVCEGID.PMI.dbo.ARTICLE z with(nolock)
-- 			on z.ARKTCODART = n.NOKTCODPF AND z.ARKTCOMART = n.NOKTCOMPF
-- 			and z.ARCTFATN != 17
-- 		where n.NOKTSOC = '300'
--         -- 03-09-22 PMI is case sensitive
--         and RTRIM(n.NOKTCODPF) = UPPER('84970') COLLATE French_CI_AS
-- 		and RTRIM(n.NOKTCOMPF) = UPPER('LA') 
--         and not (n.NOCTCODOPE = '' OR n.NOCTCODOPE IS NULL)
		--EXCEPT

		select
			RTRIM(n.NOKTCODPF) COLLATE SQL_Latin1_General_CP1_CI_AS,         -- final part code (part number)
			RTRIM(n.NOKTCOMPF) COLLATE SQL_Latin1_General_CP1_CI_AS,         -- complementary code (part revision)
			RTRIM(z.ARCTCOSFAM) COLLATE SQL_Latin1_General_CP1_CI_AS, -- part family
			--ROW_NUMBER() OVER(PARTITION BY n.NOKTCODPF, n.NOKTCOMPF, n.NOCTCODECP ORDER BY n.NOCTCODECP, n.NOCTCOMCPT, n.NOCTCODOPE) [i],
			RTRIM(n.NOCTCODECP) COLLATE SQL_Latin1_General_CP1_CI_AS, -- component number
			RTRIM(n.NOCTCOMCPT) COLLATE SQL_Latin1_General_CP1_CI_AS, -- component revision
			RTRIM(n.NOCTCODOPE) COLLATE SQL_Latin1_General_CP1_CI_AS, -- operation code (point of use)
			RTRIM(n.NOCTTYPOPE) COLLATE SQL_Latin1_General_CP1_CI_AS, -- operation type
-- 12/17/21 MV: Added column to include the quantity or time required by the operation.
            --n.NOCNQTECOM,        -- qty/time, decimal
            CAST(n.NOCNQTECOM AS DECIMAL(10, 4)),
			n.NOKNLIGNOM,        -- line (operation sequence number)

			RTRIM(a.ARCTCODFAM) COLLATE SQL_Latin1_General_CP1_CI_AS,          -- component family code
            a.ARITNATURE,                 -- nature
            RTRIM(LEFT(a.ARCTLIB01, 50)) COLLATE SQL_Latin1_General_CP1_CI_AS, -- component description
            RTRIM(a.ARCTCOSFAM),          -- component family
			u.ARKCRITPAR,
            u.APKSTDPACK,                  -- standard pack,
            n.NOCTCODATE -- Workshop Code
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
        and RTRIM(n.NOKTCODPF) = UPPER('GT84915') and RTRIM(n.NOKTCOMPF) = UPPER('LJ')
        and not (n.NOCTCODOPE = '' OR n.NOCTCODOPE IS NULL)
--EXCEPT
	-- 	SELECT top 100 [NOKTCODPF]
    --   ,[NOKTCOMPF]
    --   ,[NOKTCOSFAM]
    --   --,[i]
    --   ,[NOCTCODECP]
    --   ,[NOCTCOMCPT]
    --   ,[NOCTCODOPE]
    --   ,[NOCTTYPOPE]
    --   ,[NOCNQTECOM]
    --   ,[NOKNLIGNOM]
    --   ,[ARCTCODFAM]
    --   ,[ARITNATURE]
    --   ,[ARCTLIB01]
    --   ,[ARCTCOSFAM]
    --   ,[ARKCRITPAR]
    --   ,[APKSTDPACK]
    --   ,[NOCTCODATE] FROM cegid.bom WHERE RTRIM(NOKTCODPF) = UPPER('84970') and RTRIM(NOKTCOMPF) = UPPER('LA')

-- SELECT top 100
--     [NOKTCODPF] COLLATE SQL_Latin1_General_CP1_CI_AS,
--     [NOKTCOMPF] COLLATE SQL_Latin1_General_CP1_CI_AS,
--     [NOKTCOSFAM] COLLATE SQL_Latin1_General_CP1_CI_AS,
--     --[i],
--     [NOCTCODECP] COLLATE SQL_Latin1_General_CP1_CI_AS,
--     [NOCTCOMCPT] COLLATE SQL_Latin1_General_CP1_CI_AS,
--     [NOCTCODOPE] COLLATE SQL_Latin1_General_CP1_CI_AS,
--     [NOCTTYPOPE] COLLATE SQL_Latin1_General_CP1_CI_AS,
--     [NOCNQTECOM],
--     [NOKNLIGNOM],
--     [ARCTCODFAM] COLLATE SQL_Latin1_General_CP1_CI_AS,
--     [ARITNATURE],
--     [ARCTLIB01] COLLATE SQL_Latin1_General_CP1_CI_AS,
--     [ARCTCOSFAM],
--     [ARKCRITPAR],
--     [APKSTDPACK],
--     [NOCTCODATE]
-- FROM cegid.bom
-- WHERE RTRIM(NOKTCODPF) = UPPER('84970') COLLATE SQL_Latin1_General_CP1_CI_AS
--     AND RTRIM(NOKTCOMPF) = UPPER('LA') COLLATE SQL_Latin1_General_CP1_CI_AS;
