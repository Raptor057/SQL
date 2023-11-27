/**
 * Se agregan los tuneles que corresponden por cada linea.
 */

-- para saber si los tuneles existen en la linea, si se agrega un tunel se tiene que agregar en la tabla linepointofuse

SELECT * FROM dbo.LinePointsOfUse WHERE LineCode = 'MW';



--DELETE LinePointsOfUse WHERE LineCode = 'MW'

--  INSERT INTO dbo.LinePointsOfUse(LineCode, PointOfUseCode, IsDisabled, CanBeLoadedByOperations)
--  VALUES
-- ('MX', 'X01', 0, 0), 
-- ('MX', 'X02', 0, 0), 
-- ('MX', 'X03', 0, 0),
-- ('MX', 'X04', 0, 0),
-- ('MX', 'X05', 0, 0),
-- ('MX', 'X06', 0, 0),
-- ('MX', 'X07', 0, 0),
-- ('MX', 'X08', 0, 0),
-- ('MX', 'X09', 0, 0),
-- ('MX', 'X10', 0, 0),
-- ('MX', 'X11', 0, 0),
-- ('MX', 'X12', 0, 0),
-- ('MX', 'X13', 0, 0),
-- ('MX', 'X14', 0, 0),
-- ('MX', 'X15', 0, 0),
-- ('MX', 'X16', 0, 0),
-- ('MX', 'X17', 0, 0),
-- ('MX', 'X18', 0, 0),
-- ('MX', 'X19', 0, 0),
-- ('MX', 'X20', 0, 0),
-- ('MX', 'X21', 0, 0),
-- ('MX', 'X22', 0, 0),
-- ('MX', 'X23', 0, 0),
-- ('MX', 'X24', 0, 0),
-- ('MX', 'X25', 0, 0),
-- ('MX', 'X26', 0, 0),
-- ('MX', 'X27', 0, 0),
-- ('MX', 'X28', 0, 0),
-- ('MX', 'X29', 0, 0),
-- ('MX', 'X30', 0, 0),
-- ('MX', 'X31', 0, 0),
-- ('MX', 'X32', 0, 0),
-- ('MX', 'X33', 0, 0),
-- ('MX', 'X34', 0, 0),
-- ('MX', 'X35', 0, 0),
-- ('MX', 'X36', 0, 0),
-- ('MX', 'X37', 0, 0),
-- ('MX', 'X38', 0, 0),
-- ('MX', 'X39', 0, 0),
-- ('MX', 'X40', 0, 0),
-- ('MX', 'X41', 0, 0),
-- ('MX', 'X42', 0, 0),
-- ('MX', 'X43', 0, 0),
-- ('MX', 'X44', 0, 0),
-- ('MX', 'X45', 0, 0),
-- ('MX', 'X46', 0, 0),
-- ('MX', 'X47', 0, 0),
-- ('MX', 'X48', 0, 0),
-- ('MX', 'X49', 0, 0),
-- ('MX', 'X50', 0, 0)
