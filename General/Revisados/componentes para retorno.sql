with t as (
    select SeqNo, CompNo, CompRev, PointOfUse from cegid.ufn_bom('84915', 'LH')
    except
    select SeqNo, CompNo, CompRev, PointOfUse from cegid.ufn_bom('85618', 'LH')
)
select * from t join Etis_WB e on e.linea='WB LH' and [status]=0 and e.component=t.CompNo and e.rev_cc = t.CompRev and e.puesto_no=t.PointOfUse;