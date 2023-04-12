/**
 * Se agregan los tuneles que corresponden por cada linea.
 */

-- para saber si los tuneles existen en la linea, si se agrega un tunel se tiene que agregar en la tabla linepointofuse

SELECT * FROM dbo.LinePointsOfUse WHERE LineCode = 'LO';

-- INSERT INTO dbo.LinePointsOfUse(LineCode, PointOfUseCode, IsDisabled, CanBeLoadedByOperations)
-- VALUES('LT', 'T11', 0, 0), ('LT', 'T12', 0, 0), ('LT', 'T13', 0, 0), ('LT', 'T14', 0, 0),('LT', 'T15', 0, 0);