DECLARE
    @line_id INT = 2,
    @part_no NVARCHAR(50) = '85691',
    @part_rev NVARCHAR(50) = 'LB';

DECLARE @classification_id INT = -1;
DECLARE @bom TABLE(comp_no NVARCHAR(50) NOT NULL, comp_rev NVARCHAR(50) NOT NULL, comp_desc NVARCHAR(MAX) NOT NULL, req_qty DECIMAL(19, 4) NOT NULL);

EXEC cegid.usp_update_bom @part_no, @part_rev;

-- insert into point_of_use_mappings(line_id, classification_id, point_of_use_id, component_no, quantity, is_enabled, bin_capacity)
-- select 2, 3, pou.id, bom.CompNo, bom.ReqQty, 1, bom.Capacity from cegid.ufn_bom(@part_no, @part_rev) bom
-- join points_of_use pou on pou.code = bom.PointOfUse

select * from line_points_of_use

return;
INSERT INTO @bom
SELECT comp_no, comp_rev, comp_desc, SUM(req_qty) [req_qty]
FROM dbo.bom
WHERE part_no = @part_no AND part_rev = @part_rev
GROUP BY comp_no, comp_rev, comp_desc;

SELECT TOP 1 @classification_id = c.classification_id
FROM dbo.bom
JOIN dbo.part_number_classifications c
    ON c.classification_name = bom.part_family
WHERE part_no = @part_no AND part_rev = @part_rev;

WITH m AS (
	SELECT ROW_NUMBER() OVER(PARTITION BY component_no ORDER BY component_no) i, *
	FROM point_of_use_mappings
	WHERE line_id = @line_id AND classification_id = @classification_id AND is_enabled = 1
), aux AS (
	SELECT m.i, m.point_of_use_id, m.component_no, m.bin_capacity, m.quantity, CAST(ISNULL(bom.req_qty, -999.0) - m.quantity AS DECIMAL(19, 4)) [remainder]
	FROM m
	LEFT JOIN @bom AS [bom]
        ON bom.comp_no = m.component_no
	WHERE i = 1
	UNION ALL
	SELECT m.i, m.point_of_use_id, m.component_no, m.bin_capacity, m.quantity, CAST(aux.remainder - m.quantity AS DECIMAL(19, 4))
	FROM aux
	JOIN m
		ON m.i = aux.i + 1 AND m.component_no = aux.component_no
)
SELECT pou.code [point_of_use_code], aux.component_no, aux.bin_capacity, aux.quantity--, aux.remainder
FROM aux
JOIN points_of_use pou
	ON pou.id = aux.point_of_use_id
ORDER BY component_no;

--select * from point_of_use_mappings