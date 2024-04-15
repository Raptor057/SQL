 with t as (
    select PointOfUse, CompNo, CompRev2 from cegid.ufn_bom('85409', 'LC')
    except
    select PointOfUse, CompNo, CompRev2 from cegid.ufn_bom('84770', 'LC')
 )
delete p
from t
 join Etis_WB e on e.component=t.CompNo and e.puesto_no=t.PointOfUse and e.SET_ID='LC228757'
 join Tbl_Point_use p on p.Componente=t.CompNo and p.Punto_uso=t.PointOfUse and p.is_used=1 and p.ETI_no=e.eti_no;

 --select top 3 * from dbo.Etis_WB where linea='wb lc' and NP_FINAL='85409' order by id desc