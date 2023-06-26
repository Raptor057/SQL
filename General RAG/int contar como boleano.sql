DECLARE @UnitID bigint,
@ComponentID varchar(50)

set @UnitID = 9583187
set @ComponentID = '700U0006609'

--SELECT COUNT(UnitID) FROM ComponentJoining WHERE UnitID = @UnitID and isEnable = 1;
--SELECT COUNT(ComponentID) FROM ComponentJoining WHERE ComponentID = @ComponentID and isEnable = 1;

--select ((SELECT COUNT(UnitID) FROM ComponentJoining WHERE UnitID = @UnitID and isEnable = 1)+(SELECT COUNT(ComponentID) FROM ComponentJoining WHERE ComponentID = @ComponentID and isEnable = 1))

SELECT CASE WHEN ((SELECT COUNT(UnitID) FROM ComponentJoining WHERE UnitID = @UnitID AND isEnable = 1) + (SELECT COUNT(ComponentID) FROM ComponentJoining WHERE ComponentID = @ComponentID AND isEnable = 1)) > 1 THEN 1 ELSE 0 END AS Result