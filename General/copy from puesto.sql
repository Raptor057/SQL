insert into Etis_WB(
    SET_ID,
    eti_no,
    eti_001,
    component,
    rev_cc,
    lote,
    fecha,
    linea,
    puesto_no,
    NP_FINAL,
    MODELO,
    need_val,
    was_val,
    [status],
    creation_time
)
select top 100
    SET_ID,
    eti_no,
    eti_001,
    component,
    rev_cc,
    lote,
    fecha,
    linea,
    'P09',
    NP_FINAL,
    MODELO,
    need_val,
    was_val,
    [status],
    GETDATE()
from Etis_WB
where 0=status and linea='wb lp' and puesto_no = 'P01'