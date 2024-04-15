select * from cegid.bom where NOKTCODPF='85621-10' and NOKTCOMPF='LP' and NOCTCODOPE='P15'

select top 100 * from etis_wb where linea='wb lp' and puesto_no='p15' and fecha='10-Nov-2021' and component='36385' order by SET_ID desc

update Etis_WB set [status]=0 where id=3664463