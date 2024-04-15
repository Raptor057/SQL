--select * from TZ_TBLWBTEST_COUNTERs where NP='389012';

-- select * from apps.dbo.pro_tms where line='MV' and type='MT';
-- select * from dbo.Trazab_WB where Telesis_no='8383315';
-- select * from dbo.Temp_pack_WB where telesis='8383315'
-- select * from dbo.Master_lbl_TMid where TM_id='8383315'

--select * from apps.dbo.pro_production where id_line=37;

-- SELECT * FROM TZ_tblWBtest_counters
-- WHERE id_ssFam = 16 AND NP = '389012'
-- AND dbo.ufn_filter_revision(REV) = dbo.ufn_filter_revision('01');

-- SELECT * FROM TZ_TBLWBTEST_FREQ WHERE cegidSF='PPR';

update apps.dbo.pro_production set current_qty=0 where codew='W07494438'

delete from Temp_pack_WB where num_p='389012'
delete from Master_lbl_TMid where Master_id in (select id from Master_labels_WB where part_num='389012');
delete from Master_labels_WB where part_num='389012'
delete from Tbl_qc_aproved_list where part_num='389012'
delete from TZ_tblWBTest_counters where np='389012';
delete from tbl_picking_WB where Linea='MT MV'

select * from apps.dbo.pro_prod_units where id=2
select * from Etis_WB where linea='WB LJ' and [status]=0