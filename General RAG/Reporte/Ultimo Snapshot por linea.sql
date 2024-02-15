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
 dbo.UfnToLocalTime(UtcTimeStamp) AS [UtcTimeStamp]
FROM
    RankedData
WHERE
    RowNum = 1
    ORDER BY UtcTimeStamp DESC;
