INSERT INTO [gtt].[dbo].[MotorsData]
([Modelo],[SerialNumber],[Volt],[RPM],[DateTimeMotor],[Rev],[LineCode],[re_work],[Bearing_Position],[Arrow_Position],[Hipot_IR],[CW_Speed],[Amperage_CW],[CCW_Speed],[Amperage_CCW],[PTC_Resistance]) 
VALUES ('Test','Test','Test','Test',getdate(),'Test','Test',1,31,28,1.5,6000,5,6300,5,1100)


select * from [gtt].[dbo].[MotorsData] order by id desc

--DELETE [gtt].[dbo].[MotorsData] WHERE Modelo = 'Rework'