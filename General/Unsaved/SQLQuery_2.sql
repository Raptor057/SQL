SELECT
    'E' + CAST(id AS NVARCHAR) [EtiNo],
    part_number [PartNo],
    qty [Quantity],
    CAST(created_at AS DATE) [CreationDate]
FROM MXSRVTRACA.apps.dbo.pro_eti001
WHERE lot='F6101047931';

SELECT * FROM PointOfUseEtis WHERE EtiNo IN (SELECT
    'E' + CAST(id AS NVARCHAR)
FROM MXSRVTRACA.apps.dbo.pro_eti001
WHERE lot='F6101047931')