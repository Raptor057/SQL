select * from dbo.pro_production where id_line=2 and is_running=1 and is_stoped=0 and is_finished=0

update pro_prod_units set modelo=@part_number, active_revision=@rev_cc, codew=@codew where id=@id_line;