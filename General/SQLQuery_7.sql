-- exec dbo.UspUpdateGamma '85621-CHREARMX', 'LP';
-- exec dbo.UspUpdateLineGamma 'LP', '85621-CHREARMX', 'LP';

--select * from dbo.LinePointsOfUse where LineCode='lp';
with t as (
    select lote, puesto_no, eti_No, component, min(cast(fecha as datetime)) d, min(cast(fecha as datetime)) d2
    from mxsrvtraca.trazab.dbo.etis_wb with(nolock) where linea='wb lH' and status=0 --and eti_no not in ('E303605-T992706', 'E375079-T993836')
    and puesto_no not in ('BM2', 'BM1')
    group by lote, puesto_no, eti_No, component
), v as (
    select row_number() over(partition by eti_no order by eti_no, puesto_no asc) i, * from t
)
insert into PointOfUseEtis(LotNo, PointOfUseCode, EtiNo, ComponentNo, UtcEffectiveTime, UtcUsageTime)
select distinct v.lote, v.puesto_no, v.eti_no, rtrim(v.component), v.d, v.d2 from v
where i = 1

insert into PointOfUseEtis(LotNo, PointOfUseCode, EtiNo, ComponentNo, UtcEffectiveTime)
select lote, punto_uso, eti_no, componente, cast(fecha + ' ' + hora as datetime)
from mxsrvtraca.trazab.dbo.Tbl_Point_use where linea='lH' and is_used=0 and eti_no collate SQL_Latin1_General_CP1_CI_AS not in (select etino from PointOfUseEtis)
and len(eti_no) < 16
 
delete e
from PointOfUseEtis e
join LinePointsOfUse P
    on p.LineCode='LH'
where e.PointOfUseCode=p.PointOfUseCode