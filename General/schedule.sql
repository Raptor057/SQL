declare
    @from datetime = dateadd(day, -3, getdate()),
    @to   datetime = dateadd(day,  3, getdate());

select
    pu.letter [line_code],
    p.id_line [line_id],
    p.client_name,
    p.part_number,
    p.current_qty,
    p.target_qty,
    p.start_date,
    p.end_date
from dbo.pro_production p
join dbo.pro_prod_units pu
    on pu.id = p.id_line
where
    (@from >= start_date and (p.end_date is null or p.end_date >= @from))
    or
    (@to   >= start_date and (p.end_date is null or p.end_date >= @to  ))
order by start_date;