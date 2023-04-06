ALTER FUNCTION dbo.ufn_get_monthly_sales(
    @year INT,
    @month INT
)
RETURNS TABLE
AS
RETURN
    WITH month_days (date) AS (
        SELECT CAST(CAST(@year AS VARCHAR(4)) + '-' + CAST(@month AS NVARCHAR(2)) + '-1' AS DATE)
        UNION ALL
        SELECT DATEADD(DAY, 1, date) FROM month_days WHERE MONTH(DATEADD(DAY, 1, date)) = @month
    )
		SELECT
			md.Date,
            CAST(ECCJDERFA AS DATE) [Date Fact.],
			LCCTCODE [CTA Client],
			ECCTNOM [Intitulé],
			LCCTCODART [Code Artic],
			LCCTREFEXT [Réf.Extern],
			LCCTCOMART [Compl Art],
			LCCTLIB01 [Libelle 1],
			LCCNQTEEXP [Quantité],
			LCCTNOEXP [Num.BL Lg],
			ECCTDERFA [No Facture],
			ECCTVILLE [Ville Livr],
			LCCNVALCDE [Mont. Net],
			'' [Mois Exp.],
			LCCTAFFMAC [Famille],
			'' [Ss Famille],
			'' [Transport],
			'' [Ech.Forcée],
			'' [Date Exp.],
			'' [Délai Ddé],
			'' [Date arret],
			'' [PR Standard],
			'' [Qty x PR Std]
            --,*
		-- 'E', eccjderfa,
		-- CONVERT(DATETIME,ECCJDERFA, 101) AS BillingDate,
		-- C.CLCNGPSX AS Latitude,
		-- C.CLCNGPSY AS Longitude,
		-- LCCTCODE   AS  ClientAccount,
		-- ECCTNOM    AS  ClientName,
		-- LCKTNUMERO AS  ClientOrder,
		-- A.ECKTINDICE AS IndexExp,
		-- LCCTCODART  AS  PartNumber,
		-- ECCTREFCDE  AS  Ref,
		-- LCCTCOMART  AS  Rev,
		-- LCCNPUNET AS UnitPrice,
		-- LCCTLIB01   AS  Description,
		-- LCCTTYPE AS DocumentType,
		-- CASE LCCTTYPE WHEN 2 THEN -LCCNQTEEXP ELSE LCCNQTEEXP END AS  Qty,
		-- ECCTDERBL   AS BLNumber,
		-- ECCTDERFA   AS Invoice,
		-- A.ECCTVILLIV AS Destination,
		-- CONVERT(DATETIME,LCCJCRE,101) AS ExpeditionDate,
		-- DATEPART(MONTH, CONVERT(DATETIME,LCCJCRE,101)) AS ExpeditionMonth,
		-- CASE LCCTTYPE WHEN 2 THEN -LCCNVALCDE ELSE LCCNVALCDE END AS NetAmount,
		-- ECCTREFCDE AS Reference,
		-- LCCTAFFMAC AS Family,
		-- '' AS SubFamily,
		-- LCCTFATN AS CodeFamily,
		-- ECCTTRANPO AS Carrier
		FROM month_days md
		LEFT JOIN (
			SELECT * FROM LEXPCLI
        	INNER JOIN EEXPCLI A ON LEXPCLI.LCKTSOC = A.ECKTSOC AND LEXPCLI.LCKTNUMERO = A.ECKTNUMERO AND LEXPCLI.LCKTPSF = A.ECKTINDICE 
			--INNER JOIN CLIENT C ON C.CLKTCODE=LCCTCODE AND C.CLKTSOC=LCKTSOC
			WHERE LEXPCLI.LCKTSOC='300' -- GTMX
		) t
		ON CAST(t.ECCJDERFA AS DATE) = md.date AND t.ECCJDERFA = '20210901'
