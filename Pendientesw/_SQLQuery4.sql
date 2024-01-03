/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [id]
      ,[is_ok]
      ,[is_locked]
      ,[print_count]
      ,[line]
      ,[type]
      ,[id_reference]
      ,[julian_day]
      ,[year]
      ,[serial]
      ,[id_master_label]
      ,[manual_printed]
      ,[rason_to_print]
      ,[created_at]
      ,[created_by]
      ,[last_scan_date]
      ,[last_scan_by]
      ,[last_location]
      ,[ratio]
      ,[rev]
      ,[station]
      ,[tension_alim]
      ,[intensite]
      ,[vitesse_arbre_g]
      ,[vitesse_arbre_d]
      ,[functest_date]
      ,[functest_status]
      ,[Linea_BRO]
      ,[ft_mata_date]
      ,[ft_mata_status]
      ,[packaging_time]
      ,[serial_code]
      ,[curr_process_no]
  FROM [APPS].[dbo].[pro_tms]
  where serial='85746'