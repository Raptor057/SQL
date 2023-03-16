use TRAZAB;
GO

select distinct linea, SET_ID /*, component, puesto_no*/, count(*) from dbo.Etis_WB with (nolock)
where [status]=0
group by linea, set_id, component, puesto_no
having count(*) > 1;


--select * from Etis_WB where linea='WB LH' and [status]=0