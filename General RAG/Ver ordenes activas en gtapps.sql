SELECT ppu.letter,pp.id_line,pp.*
FROM [APPS].[dbo].[pro_production] pp
LEFT JOIN [APPS].[dbo].[pro_prod_units] ppu ON pp.id_line = ppu.id WHERE pp.is_running=1 AND pp.is_stoped=0 AND pp.is_finished=0