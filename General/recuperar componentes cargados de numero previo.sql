declare
    @codew nvarchar(50) = 'W07153318',
    @curpn nvarchar(50) = '85681-10',
    @oldpn nvarchar(50) = '85621-10',
    @line  nvarchar(50) = 'LP';

update p set p.NP_final=NOKTCODPF, p.codew=@codew
from cegid.bom
join Tbl_Point_use p on p.linea=bom.NOKTCOMPF and p.NP_final=@oldpn and p.is_used=0 and p.Componente=bom.NOCTCODECP and p.Punto_uso=bom.NOCTCODOPE
where NOKTCODPF= @curpn and NOKTCOMPF= @line;

