-- EXEC usp_update_bom_info '84731', 'C'
-- SELECT * FROM cegid.ufn_bom('84731', 'C')

-- EXEC usp_update_bom_info '84731', 'Y01C3'
-- SELECT * FROM cegid.ufn_bom('84731', 'Y01C3')

SELECT PartNo, PartRev, PartFamily, SUM(ReqQty) [ReqQty], CompNo, CompRev, CompDesc
FROM cegid.ufn_bom('84731', 'C')
GROUP BY PartNo, PartRev, PartFamily, CompNo, CompRev, CompDesc;

SELECT PartNo, PartRev, PartFamily, SUM(ReqQty) [ReqQty], CompNo, CompRev, CompDesc
FROM cegid.ufn_bom('84731', 'Y01C3')
GROUP BY PartNo, PartRev, PartFamily, CompNo, CompRev, CompDesc;

SELECT CompNo, CompRev, CompDesc, RIGHT(PointOfUse, 2) FROM cegid.ufn_bom('84731', 'LI')
EXCEPT
SELECT CompNo, CompRev, CompDesc, RIGHT(PointOfUse, 2) FROM cegid.ufn_bom('84731', 'LH');

-- LH = 8
-- LI = 9