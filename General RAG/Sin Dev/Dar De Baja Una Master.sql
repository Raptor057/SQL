/*
DB TRAZAB
Este Query sirve para buscar la master que se quiere dar de baja
*/
SELECT TOP (1000) * FROM [TRAZAB].[dbo].[Master_labels_WB] WHERE Id = ''

/*Este query sirve para dar de baja la master poniendo el ID de la master osea lo que esta despues de la M en la master*/
UPDATE [TRAZAB].[dbo].[Master_labels_WB] SET is_active = 0 WHERE Id = ''