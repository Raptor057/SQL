/**
 * Se agregan los tuneles que corresponden por cada linea.
 */

-- para saber si los tuneles existen en la linea, si se agrega un tunel se tiene que agregar en la tabla linepointofuse

SELECT * FROM dbo.LinePointsOfUse WHERE LineCode = 'E2';

--E95 E96 E97 E98 y E99

--DELETE LinePointsOfUse WHERE LineCode = 'MW'

  INSERT INTO dbo.LinePointsOfUse(LineCode, PointOfUseCode, IsDisabled, CanBeLoadedByOperations)
  VALUES
('E2', 'E95', 0, 0), 
('E2', 'E96', 0, 0), 
('E2', 'E97', 0, 0),
('E2', 'E98', 0, 0),
('E2', 'E99', 0, 0)