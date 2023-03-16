select distinct
    e.SET_ID,
    e.eti_no,
    e.creation_time,
    e.component,
    t.Telesis_no,
    t.fecha_scan + ' ' + t.hora_scan [scan_time],
    maq.lot,
    e.NP_FINAL
from apps.dbo.pro_eti001 maq with(nolock)
join apps.dbo.pro_eti001 rec with(nolock)
    on rec.lot = 'E' + cast(maq.id as varchar)
join dbo.Etis_WB e with(nolock)
    on (e.component = '120858' or e.component = '120859') and e.linea='WB LP' and e.eti_001 = rec.id
join dbo.Trazab_WB t with(nolock)
    on t.ETI_no = e.SET_ID
where
    (maq.lot like '%M100211201' or maq.lot like '%M100110552' or maq.lot like '%M100110553')
and (maq.part_number = '120858-10M' or maq.part_number = '120859-10M')