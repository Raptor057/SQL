select
    s.shp_id [Embarque],
    'M' + cast(x.Master_id as varchar) [Master],
    'WB' + x.TM_id [Transmision]
from shipments s
join Master_labels_WB m
    on m.id = s.master_id and m.is_active=1
join Master_lbl_TMid x
    on x.Master_id=m.Id
where s.origen = 'MX'
and s.shp_id=577