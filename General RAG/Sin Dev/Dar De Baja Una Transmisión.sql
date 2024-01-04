/*
DB TRAZAB
Este Query sirve para ver las transmiciones escaneadas por contenedor que aun no pertenecen a una master*/
SELECT TOP (1000) * FROM [TRAZAB].[dbo].[Temp_pack_WB]


/*En telesis va el ID de la transmision. este Query se explica solo sirve para dar de baja una tranmision mediante su ID*/
DELETE [TRAZAB].[dbo].[Temp_pack_WB] WHERE telesis = ''