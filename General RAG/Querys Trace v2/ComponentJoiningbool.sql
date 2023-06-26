DECLARE @componentID VARCHAR(50),
@unitID VARCHAR (50)

set @componentID = '700U0006609'
set @unitID = '9583187'

SELECT CASE WHEN ((SELECT COUNT(UnitID) FROM ComponentJoining WHERE UnitID = @unitID AND isEnable = 1) + (SELECT COUNT(ComponentID) FROM ComponentJoining WHERE ComponentID = @componentID AND isEnable = 1)) > 0 THEN 1 ELSE 0 END AS Result

UPDATE ComponentJoining SET isEnable = 0 WHERE UnitID = @unitID AND ComponentID = @componentID

--SELECT ((SELECT COUNT(UnitID) FROM ComponentJoining WHERE UnitID = @unitID AND isEnable = 1) + (SELECT COUNT(ComponentID) FROM ComponentJoining WHERE ComponentID = @componentID AND isEnable = 1))

-- SELECT DISTINCT(COUNT(UnitID)) FROM ComponentJoining WHERE UnitID = @unitID AND isEnable = 1
-- SELECT DISTINCT(COUNT(ComponentID)) FROM ComponentJoining WHERE ComponentID = @componentID AND isEnable = 1
