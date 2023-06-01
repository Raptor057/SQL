SELECT TOP (1000) [SubAssemblyID]
      ,[LineCode]
      ,[WorkOrderCode]
      ,[ComponentNo]
      ,[Revision]
      ,[Quantity]
      ,[IsDisabled]
      ,[UtcCreationTime]
  FROM [gtt].[dbo].[SubAssemblies] order by SubAssemblyID DESC