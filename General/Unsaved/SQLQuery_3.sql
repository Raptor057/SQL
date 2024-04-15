DECLARE
    @incoming_part_no NVARCHAR(50) = '85265',
    @incoming_revision NVARCHAR(50) = 'LB',
    @outgoing_part_no NVARCHAR(50) = '85651',
    @outgoing_revision NVARCHAR(50) = 'LB'
;

EXEC cegid.usp_update_bom '85540', 'LB';

-- select * from dbo.PointOfUseEtis where PointOfUseCode like 'B%'
-- and UtcUsageTime is not null
-- and getdate() between dbo.UfnToLocalTime(UtcUsageTime) and dbo.UfnToLocalTime(isnull(UtcExpirationTime, getutcdate()))
-- order by PointOfUseCode, ComponentNo

-- EXEC cegid.usp_update_bom @incoming_part_no, @incoming_revision;
-- EXEC cegid.usp_update_bom @outgoing_part_no, @outgoing_revision;

-- WITH t AS (
--     SELECT
--         incoming.comp_no [incoming_comp_no], incoming.comp_rev [incoming_revision], incoming.point_of_use_code,
--         outgoing.comp_no [outgoing_comp_no], outgoing.comp_rev [outgoing.revision]
--     FROM dbo.gamma incoming
--     LEFT JOIN dbo.gamma outgoing
--         ON outgoing.part_no = @outgoing_part_no AND outgoing.part_rev = @outgoing_revision
--         AND outgoing.comp_no = incoming.comp_no AND outgoing.comp_rev_2 = incoming.comp_rev_2 AND outgoing.point_of_use_code = incoming.point_of_use_code
--     WHERE incoming.part_no = @incoming_part_no AND incoming.part_rev = @incoming_revision
--     AND outgoing.comp_no IS NULL
--     UNION ALL
--     SELECT
--         incoming.comp_no [incoming_comp_no], incoming.comp_rev [incoming_revision], outgoing.point_of_use_code,
--         outgoing.comp_no [outgoing_comp_no], outgoing.comp_rev [outgoing.revision]
--     FROM dbo.gamma outgoing
--     LEFT JOIN dbo.gamma incoming
--         ON incoming.part_no = @incoming_part_no AND incoming.part_rev = @incoming_revision
--         AND outgoing.comp_no = incoming.comp_no AND outgoing.comp_rev_2 = incoming.comp_rev_2 AND outgoing.point_of_use_code = incoming.point_of_use_code
--     WHERE outgoing.part_no = @outgoing_part_no AND outgoing.part_rev = @outgoing_revision
--     AND incoming.comp_no IS NULL
-- )
-- SELECT DISTINCT * FROM t ORDER BY t.point_of_use_code, t.incoming_comp_no, t.outgoing_comp_no;

-- WITH t AS (
--     SELECT comp_no, comp_rev, comp_desc, point_of_use_code FROM dbo.gamma WHERE part_no = @incoming_part_no AND part_rev = @incoming_revision
--     EXCEPT
--     SELECT comp_no, comp_rev, comp_desc, point_of_use_code FROM dbo.gamma WHERE part_no = @outgoing_part_no AND part_rev = @outgoing_revision
-- )
-- SELECT * FROM t
-- -- LEFT JOIN dbo.PointOfUseEtis e
-- --     ON rtrim(e.ComponentNo) = rtrim(t.comp_no) AND rtrim(e.PointOfUseCode) = rtrim(t.point_of_use_code)
-- --     --AND UtcExpirationTime IS NULL AND UtcUsageTime IS NOT NULL;

-- SELECT * FROM dbo.PointOfUseEtis e
-- WHERE RTRIM(e.ComponentNo) = '00520' AND PointOfUseCode='B09';

--return;

-- outgoing
SELECT comp_no, comp_rev, comp_desc, point_of_use_code FROM dbo.gamma WHERE part_no = @incoming_part_no AND part_rev = @incoming_revision
EXCEPT
SELECT comp_no, comp_rev, comp_desc, point_of_use_code FROM dbo.gamma WHERE part_no = @outgoing_part_no AND part_rev = @outgoing_revision;

-- incoming
-- SELECT comp_no, comp_rev, comp_desc, point_of_use_code FROM dbo.gamma WHERE part_no = @outgoing_part_no AND part_rev = @outgoing_revision
-- EXCEPT
-- SELECT comp_no, comp_rev, comp_desc, point_of_use_code FROM dbo.gamma WHERE part_no = @incoming_part_no AND part_rev = @incoming_revision;