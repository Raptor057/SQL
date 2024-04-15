SELECT TOP (1000) [IdpartNo]
      ,[ModeloID]
      ,[PartNoGT]
      ,[Pack_Type_GT]
      ,[Revision]
      ,[MASTER_TYPE]
      ,[MASTER_COPIES]
      ,[LEVEL_COPIES]
      ,[HUP_FORMAT]
  FROM [TRAZAB].[dbo].[PartNo] where PartNoGT in ('GT87129','GT87140','GT87145','GT87146','GT87148')

  UPDATE PartNo set LEVEL_COPIES = 2 where PartNoGT in ('GT87129','GT87140','GT87145','GT87146','GT87148')