SELECT
    'E' + CAST(id AS NVARCHAR) [EtiNo],
    part_number [PartNo],
    qty [Quantity],
    CAST(created_at AS DATE) [CreationDate]
FROM apps.dbo.pro_eti001
WHERE lot='B0013144020';

SELECT top 5 * FROM dbo.pro_subeti WHERE eti2 in (
    SELECT
    cast(id as nvarchar)
FROM apps.dbo.pro_eti001
WHERE lot='B0013144020'
)

select top 1 * from APPS.dbo.wh_eti001_transfer tr