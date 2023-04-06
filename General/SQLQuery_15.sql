SELECT table_schema + '.' + table_name + ' ', table_type
FROM information_schema.tables
ORDER BY table_type, table_name ASC;

select distinct component, lote, fecha from trazab.dbo.Etis_WB with(nolock)
where linea='WB LA' and creation_time >= '2022-09-01'
and (component = '00387' or component = '00312')
order by fecha, component

update pro_prod_units set codew='W07710820', modelo='87245', active_revision='17' where id=5;
select * from pro_production where codew='W07710820';

select * from pro_production where codew='w06921859'

exec trazab.dbo.usp_update_bom_info '85079-10', 'LA'
select * from trazab.cegid.ufn_bom('85079-10', 'LA') where CompNo='13365'