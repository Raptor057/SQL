-- INSERT INTO [dbo].[pro_eti001] (
--     [part_number], [qty], [std_pack], [shift], [lot], [created_at], [created_by], [prod_report_date], rev, rev_cc
-- ) VALUES
-- ('120968', 45, 45, 1, 'TEST', GETDATE(), '005766', GETDATE(), '04', '04'),
-- ('120969', 45, 45, 1, 'TEST', GETDATE(), '005766', GETDATE(), '04', '04'),
-- ('13446PR', 45, 45, 1, 'TEST', GETDATE(), '005766', GETDATE(), '06', '06')
-- ;

select * from pro_eti001 where part_number = '13446PR' and rev='06' and lot='TEST';
update pro_eti001 set [description]='TEST', reference='W07468745', [type]='PM', created_by=21, ref_ext='1000', scale_type='SB', next_op='ALMACEN', machine=1 where id=362654;
--120968	04
select * from pro_machines
select * from pro_eti001 where id=267382

E362654-T913597
select max(id) from TRAZAB.dbo.pro_subeti