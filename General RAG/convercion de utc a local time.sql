    DECLARE @localTime AS DATETIME;
    DECLARE @utcTime as DATETIME;

--set @localTime = GETDATE()
set @utcTime = GETUTCDATE()
    SELECT @localTime = CAST(@utcTime AT TIME ZONE 'UTC' AT TIME ZONE TimeZone AS DATETIME) FROM GlobalSettings;
    --RETURN @localTime;
    select @localTime
    --select * from GlobalSettings
    --SELECT * FROM sys.time_zone_info;
