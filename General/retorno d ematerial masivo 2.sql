

with t as (
select CompNo, CompRev2, PointOfUse from cegid.ufn_bom('84663', 'LB') -- salio
except
select CompNo, CompRev2, PointOfUse from cegid.ufn_bom('85651', 'LB') -- entro
)
delete from Tbl_Point_use where linea='lb' and ETI_no in (
    select e.eti_no from t
    join Etis_WB e
        on e.component=t.CompNo and e.rev_cc=t.CompRev2 and e.puesto_no=t.PointOfUse and e.[status]=0 and e.linea='wb lb'
)

with t as (
select CompNo, CompRev2, PointOfUse from cegid.ufn_bom('84663', 'LB')
except
select CompNo, CompRev2, PointOfUse from cegid.ufn_bom('85651', 'LB')
)
update e set e.[status]=1
from t
join Etis_WB e
    on e.component=t.CompNo and e.rev_cc=t.CompRev2 and e.puesto_no=t.PointOfUse and e.[status]=0 and e.linea='wb lb'