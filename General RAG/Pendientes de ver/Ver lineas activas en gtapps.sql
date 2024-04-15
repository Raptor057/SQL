SELECT TOP 1000 * FROM dbo.pro_production 
WHERE 
--id_line = '8' AND codew = 'W08044587' AND 
is_stoped = 0 AND is_running = 1 AND is_finished = 0 ORDER BY last_update_time DESC

