85621-10

85621

SELECT TOP 1 * FROM cegid.ufn_bom('85673-10', 'LP');
SELECT * FROM TZ_TBLWBTEST_FREQ WHERE cegidSF = 'ME-1';
SELECT * FROM tz_qcparam_app WHERE familia='PROD ME';

SELECT TOP 1 * FROM cegid.ufn_bom('85621', 'LR');
SELECT * FROM TZ_TBLWBTEST_FREQ WHERE cegidSF = 'ME51';
SELECT * FROM tz_qcparam_app WHERE familia='PROD ME51';


update tbl_qc_aproved_list set is_approved=0 where id=18784