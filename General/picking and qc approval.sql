DECLARE
    @pack_type CHAR = 'C',
    @company INT = 300,
    @part_no VARCHAR(50) = '85681-10',
    @rev VARCHAR(50) = 'Y01A',
    @family VARCHAR(50),
    @sub_family VARCHAR(50),
    @qc_unapproved_pallet_stop_limit INT,
    @period_id INT,
    @picking_period INT,
    @picking_counter INT,
    @picking_sequence INT;
;
SELECT @family = UPPER(RTRIM(ARCTCOSFAM)) FROM MXSRVCEGID.PMI.dbo.ARTICLE WHERE ARKTCODART=@part_no AND ARKTSOC=@company AND ARKTCOMART=@rev;

SELECT
    '@family' = @family;

-- picking
SELECT @period_id = Id, @picking_period = Freq, @sub_family = tipo FROM TZ_TBLWBTEST_FREQ WHERE cegidSF=@family;
SELECT @picking_counter = [Counter], @picking_sequence = tot_test FROM TZ_tblWBtest_counters
    WHERE id_ssFam = @period_id AND NP = @part_no AND REV = CASE WHEN LEFT(@rev, 1) IN ('X', 'Y', '0') THEN LEFT(@rev, 1) ELSE @rev END;

SELECT
    '@sub_family' = @sub_family,
    '@period_id' = @period_id,
    '@picking_period' = @picking_period,
    '@picking_counter' = @picking_counter,
    '@picking_sequence' = @picking_sequence;

-- approvals
SELECT @qc_unapproved_pallet_stop_limit = PARAM_FIN FROM tz_qcparam_app WHERE familia=@sub_family AND PACK_TYPE=@pack_type;

SELECT
    '@qc_unapproved_pallet_stop_limit' = @qc_unapproved_pallet_stop_limit;