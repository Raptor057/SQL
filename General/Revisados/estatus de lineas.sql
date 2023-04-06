with t as (
    select l.letter [line], l.comments [line_code], p.part_number, p.rev, count(b.i) [gama_size]
    from apps.dbo.pro_prod_units l
    join apps.dbo.pro_production p
        on p.codew=l.codew and p.is_running=1 and p.is_stoped=0
    left join cegid.bom b
        on b.NOKTCODPF=dbo.ufn_get_plain_part_no(rtrim(p.part_number)) and b.NOKTCOMPF=l.letter
    group by l.letter, l.comments, p.part_number, p.rev
)
select * from t
cross apply (
    select count(*)
    from dbo.Etis_WB with (nolock)
    where [status]=0 and linea=t.line_code
)z(active_set_size);