--select * from dbo.Etis_WB where linea='wb lh' and [status]=0;
-- 85595 > GT85595 > 85540

-- update dbo.Tbl_Point_use set linea='LH' where linea='010' and is_used=0
-- union all
select * from dbo.Tbl_Point_use where ETI_no='e371592-t953736';
return;
-- update dbo.Tbl_Point_use set
--     NP_final='85540',
--     codew='W07603947',
--     linea='010',
--     Orden='072806',
--     Linea_Orden='010-072806'
-- where
--     linea='lh' and is_used=0 and NP_final='85595';

select * from APPS.dbo.pro_production where codew='W07603947'