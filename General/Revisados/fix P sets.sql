with t as (
    select row_number() over(partition by puesto_no, component, rev_cc order by id desc) i, * from Etis_WB where linea='wb lp' and [status]=0 and SET_ID like 'lp2%'
)
delete e
from t
join etis_wb e on e.id = t.id
where i > 1;

select * from Etis_WB where linea='wb lp' and [status]=0