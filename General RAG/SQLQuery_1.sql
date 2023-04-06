--Las etiquetas escaneadas / cargadas 
--Vhttps://www.w3schools.com/sql/sql_update.asp

 select top 100 *  FROM PointOfUseEtis

SELECT * from PointOfUseEtis WHERE EtiNo LIKE ('E383072-T988089')

--UPDATE PointOfUseEtis SET UtcExpirationTime = GETDATE() WHERE ID = '12360'
SELECT * from PointOfUseEtis WHERE EtiNo LIKE ('E383072-T988089')

select * FROM LineGamma where UtcEffectiveTime BETWEEN ('2022-02-01 00:00:00.000') and (GETDATE()) and LineCode LIKE ('LA') ORDER by UtcEffectiveTime DESC

select * from ProcessHistory WHERE UtcTimeStamp BETWEEN ('2022-02-01 00:00:00.000') and (GETDATE()) and LineCode LIKE ('LA') ORDER BY UtcTimeStamp DESC


SELECT * FROM bom

SELECT * FROM gamma

SELECT * FROM Gammas


--Creo que este QWERY es el bueno solo falta buscar el lote
SELECT * FROM LineGamma WHERE LineCode LIKE('LA') AND UtcEffectiveTime BETWEEN ('2022-02-01 00:00:00.000') and (GETDATE())AND PartNo LIKE('85256-10')

SELECT * FROM LineGamma  WHERE LineCode LIKE ('LA') and PartNo LIKE ('%85256%')ORDER BY UtcEffectiveTime DESC

SELECT * FROM LineHeadcountHistory

SELECT * FROM LineModelCapabilities

SELECT * from SubAssemblies WHERE UtcCreationTime BETWEEN ('2022-02-01 00:00:00.000') and (GETDATE())

SELECT  top 100 * FROM Master_labels_WB ORDER BY fecha DESC

SELECT * FROM Tbl_Point_use

SELECT CAST(table_name as varchar)  FROM INFORMATION_SCHEMA.TABLES



SELECT DISTINCT linea from Etis_WB

SELECT DISTINCT rev_cc from Etis_WB

--Esta esta buena solo falta agregar el resto de la info de febrero en adelante
select * FROM Etis_WB where NP_FINAL LIKE ('%85256-10%') and component like ('00387') ORDER BY creation_time ASC


--Investigar mas a detalle
SELECT * FROM Master_labels_WB WHERE line LIKE('%LA') and part_num LIKE ('85256-10')

SELECT * FROM Master_lbl_TMid

SELECT * FROM Etis_WB WHERE component LIKE ('00387') and linea LIKE ('%LA')

SELECT DISTINCT NOKTCOMPF from cegid.bom

SELECT convert(datetime, fecha, 103) FROM Etis_WB

SELECT GETDATE()

Select * FROM Tbl_events_log
Select * FROM PartNo
Select * FROM Modelos
Select * FROM Tz_tbllineOper
Select * FROM Mtto
Select * FROM TZ_tblregoper
Select * FROM warehouse_locations
Select * FROM Usos
Select * FROM Temp_pack
Select * FROM pumps_x_lines
Select * FROM Temp_pack_WB_LP_12_15
--Select * FROM Tbl_checkin_TG
--Select * FROM Table
Select * FROM TZ_tblWBTest_Freq
Select * FROM TZ_tbl_checks_TG
Select * FROM TZ_tblWBTest_counters
Select * FROM Tele_Trazab
Select * FROM tbl_rmnc
Select * FROM test_counters
Select * FROM tbl_trat_ship
Select * FROM Groups_Mails
Select * FROM tbl_line_pcs_hr
Select * FROM Temp_pack_WB_tmp_84915_262
Select * FROM Tbl_Banco_Velocidad
--Select * FROM bom
Select * FROM tbl_mesort
Select * FROM eti_packing_counters
Select * FROM Master_lbl_TMid
Select * FROM Tbl_SET_ETIS_ID
Select * FROM tbl_loc
Select * FROM Tbl_requis
Select * FROM recupera_eti
Select * FROM TZ_tbl_picking
Select * FROM TZ_Tbl_Cartlst
Select * FROM changeover_logs
Select * FROM Trazab_Rider
Select * FROM TZ_tbl_adjust_tunel_hist
Select * FROM TZ_tblmolding_issues
Select * FROM Tbl_moldes
Select * FROM product_line
Select * FROM Trazab_Defwb
Select * FROM CONSTANTS
Select * FROM Trazab_WB
Select * FROM line_set_mappings
Select * FROM cod_area
Select * FROM TZ_tbl_kanban_moldeo
Select * FROM Tbl_line_pcs_hr_np
Select * FROM Temp_pack_WB
Select * FROM pcmx
Select * FROM Master_labels
Select * FROM Tbl_timecontrol
Select * FROM Master_labels_WB
Select * FROM Tbl_qc_aproved_list
Select * FROM pro_subeti
Select * FROM line_points_of_use
Select * FROM Tbl_Fac135
Select * FROM points_of_use
Select * FROM Tmp_shipments
Select * FROM Tbl_User_roles
Select * FROM shipments
Select * FROM cod_oper
Select * FROM Tbl_User_roles_list
Select * FROM Tbl_shipments_id
Select * FROM Tbl_events_loc
Select * FROM TZ_tblcortos
Select * FROM Etis_WB
Select * FROM Etis_WB_Backup_220505
Select * FROM cod_defe
Select * FROM TZ_QCParam_App
Select * FROM tbl_picking_WB
Select * FROM tbl_NPWH
Select * FROM tool_life_PMQ
Select * FROM TBL_RMNC_ETI
Select * FROM Corona_Plasma
Select * FROM tz_tbl_line_pcs_hr
Select * FROM Tbl_Point_use

SELECT * FROM test_counters
