SELECT TOP (1000) 
        SUBSTRING(
        Telesis_no,
        CHARINDEX('[)>06SWB', Telesis_no) + LEN('[)>06SWB'),
        CHARINDEX('P', Telesis_no, CHARINDEX('[)>06SWB', Telesis_no)) - (CHARINDEX('[)>06SWB', Telesis_no) + LEN('[)>06SWB'))
        ) AS UnitID
      ,[Linea]
      ,[no_empleado]
      ,CONVERT(datetime, [fecha_scan] + ' ' + [hora_scan], 0) AS fecha_y_hora
      ,[ETI_no]
      ,[component_number]
      ,[ETI_001]
      ,[Modelo]
      ,[NP_FINAL]
      ,[CMP_REV]
      ,[ETI_status]
      ,[type_testing]
  FROM [TRAZAB].[dbo].[Trazab_Rider] WHERE NP_FINAL = 'GT87145U' AND (fecha_scan = '27-Sep-2023')