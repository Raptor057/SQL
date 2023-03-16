select
    t.linea, t.eti_no, t.Punto_uso, ISNULL(se.qty, ISNULL(e.qty, ISNULL(tr.qty, -1))) [BinSize]

from dbo.Tbl_Point_use t with(nolock)

LEFT JOIN dbo.pro_subeti se
	ON LEFT(t.eti_no, 2) = 'es' AND ISNUMERIC(RIGHT(t.eti_no, LEN(t.eti_no) - 2)) = 1
	AND se.NP1 = t.Componente AND CAST(se.id AS VARCHAR(50)) = RIGHT(t.eti_no, LEN(t.eti_no) - 2)

LEFT JOIN apps.dbo.wh_eti001_transfer tr WITH(NOLOCK)
	ON LEFT(t.eti_no, 1) = 'e' AND CHARINDEX('-t', t.eti_no) > 0
	AND CAST(tr.id AS VARCHAR(50)) = RIGHT(t.eti_no, LEN(t.eti_no) - CHARINDEX('-t', t.eti_no) - 1)

LEFT JOIN apps.dbo.pro_eti001 e WITH(NOLOCK)
	ON LEFT(t.eti_no, 1) = 'E' AND CHARINDEX('-', t.eti_no) = 0
	AND e.part_number = t.Componente AND ISNUMERIC(RIGHT(t.eti_no, LEN(t.eti_no) - 1)) = 1 AND CAST(e.id AS VARCHAR(50)) = RIGHT(t.eti_no, LEN(t.eti_no) - 1)

where t.is_used=0 and LEFT(t.Punto_uso, 2) != 'BM'

order by t.linea, t.Punto_uso;