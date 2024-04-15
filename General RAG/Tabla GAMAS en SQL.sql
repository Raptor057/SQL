/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [PartNo]
      ,[PartRev]
      ,[PartFamily]
      ,[CompNo]
      ,[CompRev]
      ,[PointOfUseCode]
      ,[Capacity]
      ,[Quantity]
      ,[OperationNo]
      ,[Nature]
      ,[CompDesc]
      ,[CompFamilyCode]
      ,[CompFamily]
      ,[StdPackSize]
      ,[WorkshopCode]
  FROM [gtt].[dbo].[Gammas] where PartRev = 'LB' and PartNo = '85540' order by PointOfUseCode asc

  --DELETE FROM dbo.Gammas WHERE PartNo = 'AEM5.614.2101303-1' AND PartRev = 'U1';

  --DELETE FROM dbo.Gammas WHERE PartNo = '85540' AND PartRev = 'LC';