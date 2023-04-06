CREATE TABLE #defect_codes (
	code NVARCHAR(50) NOT NULL,
	description NVARCHAR(120),
	department NVARCHAR(50),
	cc_or_cnc NVARCHAR(50)
);

BEGIN TRY

	BULK INSERT #defect_codes
	FROM 'C:\Dev\MXSRVDEV\DefaultCollection\Reporting\Power BI\Defect Codes.csv'
	WITH
	(
		FIRSTROW = 2, -- as 1st one is header
		FIELDTERMINATOR = ',',  --CSV field delimiter
		ROWTERMINATOR = '\n',   --Use to shift the control to next row
		TABLOCK,
		DATAFILETYPE = 'char',
		FORMAT = 'CSV'
	);

	UPDATE #defect_codes SET department = LTRIM(RTRIM(department));
	UPDATE #defect_codes SET department = UPPER(LEFT(department, 1)) + LOWER(RIGHT(department, LEN(department) - 1));

	BEGIN TRANSACTION;

	TRUNCATE TABLE dbo.defect_codes;

	WITH t AS (
		SELECT code, description, department, cc_or_cnc, ROW_NUMBER() OVER(PARTITION BY code ORDER BY code, department) i FROM #defect_codes
		WHERE NULLIF(LTRIM(RTRIM(code)), '') IS NOT NULL
	)
	INSERT INTO dbo.defect_codes
	SELECT LTRIM(RTRIM(code)), LTRIM(RTRIM(description)), department, cc_or_cnc FROM t
	WHERE i = 1
	ORDER BY code;

	COMMIT;

END TRY
BEGIN CATCH
	IF EXISTS(SELECT * FROM sys.sysprocesses WHERE open_tran = 1)
		ROLLBACK;
	PRINT ERROR_MESSAGE();
END CATCH

DROP TABLE #defect_codes;