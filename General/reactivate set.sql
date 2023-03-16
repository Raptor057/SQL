declare @line_code nvarchar(50) = 'WB LZ', @part_no nvarchar(50);
select @part_no = p.part_number from apps.dbo.pro_production p
join apps.dbo.pro_prod_units pu on pu.id = p.id_line
where comments=@line_code;

with t as (
    select top 10000 row_number() over(partition by e.component, e.rev_cc, e.puesto_no order by creation_time desc) x, e.* from dbo.ufn_cegid_get_bom('300', @part_no, right(@line_code, 2)) bom
    join dbo.Etis_WB e with(nolock)
        on linea=@line_code
        and rtrim(e.component) = rtrim(bom.NOCTCODECP) COLLATE French_CI_AS
        and rtrim(e.rev_cc)    = rtrim(bom.NOCTCOMCPT) COLLATE French_CI_AS
        and rtrim(e.puesto_no) = rtrim(bom.NOCTCODOPE) COLLATE French_CI_AS
        and e.creation_time > dateadd(day, -1, getutcdate())
)
select e.*
--update e set e.[status]=0
from t
join dbo.Etis_WB e with(nolock)
    on e.id = t.id
where t.x = 1;