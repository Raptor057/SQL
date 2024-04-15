--insert into Etis_WB (SET_ID, eti_no, eti_001, component, rev_cc, lote, fecha, linea, puesto_no, NP_FINAL, Modelo, need_val, was_val, [status], creation_time, source, packing_count)
select 'LP161348', eti_no, eti_001, component, rev_cc, lote, fecha, linea, puesto_no, '85621-CHREARMX', 'TTI /OWT', 0, 0, 0, getdate(), 'MARCOS', 0
from Etis_WB
where SET_ID='LP22224968736'
and component+puesto_no+(case when left(rev_cc, 1) in ('X', 'Y', '0') then rev_cc else left(rev_cc, 1) end)
not in (
select bom.CompNo+bom.PointOfUse+bom.CompRev2 from cegid.ufn_bom('85621-CHREARMX', 'LP') bom
left join dbo.Etis_WB e
    on linea='wb lp' and status=0 and e.component=bom.CompNo
    and e.puesto_no=bom.PointOfUse
    and case when left(e.rev_cc, 1) in ('X', 'Y', '0') then e.rev_cc else left(e.rev_cc, 1) end = bom.CompRev2
where e.id is null
)

select * from Etis_WB where linea='wb lp' and [status]=0

select top 100 * from Etis_WB where linea='wb lp' and puesto_no='p47' order by creation_time desc

with t as (
    select distinct SET_ID, creation_time from Etis_WB where [status]=1 and NP_FINAL='85621-CHREARMX' and puesto_no='P45'
)
select * from t order by creation_time desc