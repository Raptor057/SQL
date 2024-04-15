CREATE TABLE #unit_costs (
	code_art NVARCHAR(50) NOT NULL,
	code_compl NVARCHAR(50),
	nature_art NVARCHAR(50),
	libelle_1 NVARCHAR(120),
	libelle_2 NVARCHAR(120),
	familie NVARCHAR(120),
	section NVARCHAR(50),
	cost_mat NVARCHAR(50),
	cost_consu NVARCHAR(50),
	cost_mo NVARCHAR(50),
	cost_subco NVARCHAR(50),
	prvt_s_fg NVARCHAR(50),
	cost_total NVARCHAR(50)
);

BEGIN TRY

	BULK INSERT #unit_costs
	FROM 'C:\Dev\MXSRVDEV\DefaultCollection\Reporting\Power BI\Unit Cost.csv'
	WITH
	(
		FIRSTROW = 2, -- as 1st one is header
		FIELDTERMINATOR = ',',  --CSV field delimiter
		ROWTERMINATOR = '\n',   --Use to shift the control to next row
		TABLOCK,
		DATAFILETYPE = 'char',
		FORMAT = 'CSV'
	);

	delete from #unit_costs where cost_total = '.' or cost_total = 'UP';

	update #unit_costs set cost_total = replace(replace(replace(replace(cost_total, '$', ''), '"', ''), ' ', ''), ',', '');
	update #unit_costs set cost_total = null where cost_total = '' or cost_total = '-';
	update #unit_costs set code_compl = '' where code_compl is null;
	update #unit_costs set
		code_art = LTRIM(RTRIM(code_art)),
		code_compl = LTRIM(RTRIM(code_compl));

	BEGIN TRANSACTION;

	TRUNCATE TABLE dbo.unit_costs;

	INSERT INTO dbo.unit_costs
	SELECT * FROM #unit_costs
	--where code_art='85621'-- isnumeric(cost_total) = 1 and
	ORDER BY cost_total;

	COMMIT;

END TRY
BEGIN CATCH
	IF EXISTS(SELECT * FROM sys.sysprocesses WHERE open_tran = 1)
		ROLLBACK;
	PRINT ERROR_MESSAGE();
END CATCH

DROP TABLE #unit_costs;