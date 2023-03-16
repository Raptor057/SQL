declare @part_no nvarchar(50)='84969-10';

--select t.*
update e set e.[status]=0, e.NP_FINAL='84969-10', e.MODELO='TORO'
from cegid.ufn_bom(@part_no, 'LA') bom
cross apply (
    select top 1 * from dbo.Etis_WB e with(nolock)
    where e.linea='wb la' and e.component=bom.CompNo and e.puesto_no=bom.PointOfUse and e.NP_FINAL=bom.PartNo
    order by id desc
) t
join Etis_WB e on e.ID=t.ID
where t.ID is not null and t.[status]=1;

-- select * from dbo.Tbl_Point_use where linea='la' and is_used=0 and NP_final='84969'

-- select * from dbo.Tbl_Point_use where ETI_no='e356547-t906238'

