-- SELECT 
--      [SnapShotID]
--     ,[LineCode]
--     ,[UtcTimeStamp]
--   FROM [gtt].[dbo].[ComponentsSnapShot]


-- select DATEADD(HOUR, -12, GETUTCDATE())


WITH RankedData AS (
    SELECT
        SnapShotID,
        LineCode,
        UtcTimeStamp,
        ROW_NUMBER() OVER (PARTITION BY LineCode ORDER BY UtcTimeStamp desc) AS RowNum
    FROM
        [gtt].[dbo].[ComponentsSnapShot]
)
SELECT
    SnapShotID,
    LineCode,
 dbo.UfnToLocalTime(UtcTimeStamp) AS [CstTimeStamp]
FROM
    RankedData
WHERE
    RowNum = 1
    ORDER BY UtcTimeStamp DESC;


--SELECT CONCAT('SnapShot #',(SELECT COUNT(DISTINCT SnapShotID) FROM [gtt].[dbo].[UnitIDShapshotHistory] WHERE LineCode = @lineCode AND PartNo = @partNo AND UtcTimeStamp BETWEEN DATEADD(HOUR, -12, GETUTCDATE()) AND GETUTCDATE() ),' - ','ID: ',(SELECT TOP (1) [SnapShotID] FROM [gtt].[dbo].[ComponentsSnapShot] WHERE LineCode = @lineCode ORDER BY UtcTimeStamp DESC)) AS [SeqSnapshotID]

-- WITH RankedData AS (
--     SELECT
--         SnapShotID,
--         LineCode,
--         UtcTimeStamp,
--         ROW_NUMBER() OVER (PARTITION BY LineCode ORDER BY UtcTimeStamp DESC) AS RowNum
--     FROM
--         [gtt].[dbo].[ComponentsSnapShot]
-- )
-- SELECT
--     SnapShotID,
--     LineCode,
--     dbo.UfnToLocalTime(UtcTimeStamp) AS [CstTimeStamp]
-- FROM
--     RankedData
-- WHERE
--     RowNum = 1
-- ORDER BY
--     LineCode, [CstTimeStamp] DESC;


WITH RankedData AS (
    SELECT
        SnapShotID,
        LineCode,
        UtcTimeStamp,
        ROW_NUMBER() OVER (PARTITION BY LineCode ORDER BY UtcTimeStamp DESC) AS RowNum
    FROM
        [gtt].[dbo].[ComponentsSnapShot]
)
SELECT
    SnapShotID,
    LineCode,
    dbo.UfnToLocalTime(UtcTimeStamp) AS [LocalTime]
FROM
    RankedData
WHERE
    RowNum = 1
ORDER BY
    LineCode, [LocalTime] DESC;

SELECT 
[LineCode]
,[PartNo]
,COUNT(DISTINCT [SnapShotID]) AS [SnapShotID Count]
FROM [gtt].[dbo].[UnitIDShapshotHistory]
WHERE UtcTimeStamp BETWEEN DATEADD(HOUR, -12, GETUTCDATE())  and GETUTCDATE()
GROUP BY [LineCode],[PartNo]
ORDER BY LineCode ASC

SELECT 
DISTINCT [SnapShotID],[LineCode],[PartNo]
FROM [gtt].[dbo].[UnitIDShapshotHistory]
WHERE UtcTimeStamp BETWEEN DATEADD(HOUR, -12, GETUTCDATE())  and GETUTCDATE()
GROUP BY [SnapShotID],[LineCode],[PartNo]
ORDER BY LineCode ASC