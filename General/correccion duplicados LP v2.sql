with t as (
    select e.id, e.puesto_no, e.component, ROW_NUMBER() over(partition by bom.compno, bom.pointofuse order by e.id desc) i
    from cegid.ufn_bom('85621-10', 'LP') bom
    join Etis_WB e with(nolock)
        on [status]=0 and linea='WB LP' and NP_FINAL='85621-10'
        and e.puesto_no=bom.PointOfUse and e.component=bom.CompNo
)
--select *
update e set e.[status]=1
from t
join Etis_WB e on [status]=0 and linea='WB LP' and NP_FINAL='85621-10' and e.id=t.id
where i >  1;