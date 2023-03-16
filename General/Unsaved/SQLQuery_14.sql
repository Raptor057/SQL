select * from dbo.Etis_WB where NP_FINAL='85504' and linea='wb lh' and fecha='12-Sep-2022'-- creation_time > '20220912 07:00'
order by creation_time desc;

insert into Etis_WB(SET_ID, eti_no, eti_001, component, rev_cc, lote, fecha, linea, puesto_no, NP_FINAL, modelo, need_val, was_val, [status], creation_time, source, packing_count)
select 'LH258791', e.eti_no, e.eti_001, e.component, e.rev_cc, e.lote, e.fecha, e.linea, e.puesto_no, '85540', e.modelo, e.need_val, e.was_val, 0, e.creation_time, e.source, e.packing_count from cegid.ufn_bom('85504', 'LH') bom
join dbo.Etis_WB e
    on  e.SET_ID='LH258767' and e.component=bom.CompNo and e.puesto_no=bom.PointOfUse

select top 1 * from dbo.Etis_WB where linea='wb lh' and [status]=0