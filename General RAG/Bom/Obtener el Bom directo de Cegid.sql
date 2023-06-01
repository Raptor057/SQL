--Obtener el Bom directo de Cegid.
        
        select
			n.NOKTCODPF,         -- final part code (part number)
			n.NOKTCOMPF,         -- complementary code (part revision)
			RTRIM(z.ARCTCOSFAM), -- part family
			ROW_NUMBER() OVER(PARTITION BY n.NOKTCODPF, n.NOKTCOMPF, n.NOCTCODECP ORDER BY n.NOCTCODECP, n.NOCTCOMCPT, n.NOCTCODOPE) [i],
			RTRIM(n.NOCTCODECP), -- component number
			RTRIM(n.NOCTCOMCPT), -- component revision
			RTRIM(n.NOCTCODOPE), -- operation code (point of use)
			RTRIM(n.NOCTTYPOPE), -- operation type
-- 12/17/21 MV: Added column to include the quantity or time required by the operation.
            n.NOCNQTECOM,        -- qty/time, decimal
            n.NOKNLIGNOM,        -- line (operation sequence number)

			RTRIM(a.ARCTCODFAM),          -- component family code
            a.ARITNATURE,                 -- nature
            RTRIM(LEFT(a.ARCTLIB01, 50)), -- component description
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
        and RTRIM(n.NOKTCODPF) = UPPER('84970') and RTRIM(n.NOKTCOMPF) = UPPER('LA')
        and not (n.NOCTCODOPE = '' OR n.NOCTCODOPE IS NULL);