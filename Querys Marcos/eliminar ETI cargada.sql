-- eliminar etis cargadas en un tunel

DECLARE @tunel NVARCHAR(50) = 'J06';

DELETE FROM dbo.PointOfUseEtis WHERE PointOfUseCode = @tunel;