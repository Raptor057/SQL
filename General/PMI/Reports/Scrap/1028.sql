ALTER FUNCTION dbo.ufn_get_monthly_scrap(
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
        md.[date]                   [Date],
        LTRIM(RTRIM(M.MVCTCODART))  [Code Art.],
        LTRIM(RTRIM(M.MVCTCOMART))  [Section Ar],
        A.ARCTLIB01                 [Libellé 01],
        CAST(M.MVCJMVT AS DATE)     [Jour Mvt],
        M.MVCTLIB                   [Lib.Mvt],
        M.MVCTGENRE                 [Genre Mvt],
        M.MVCTNOMUTI                [Utilisat.],
        M.MVCTDEPOT                 [Code Dépot],
        -M.MVCNQTE                  [QTY]
    FROM month_days md
    LEFT JOIN dbo.MVTSTO M WITH(NOLOCK)
        ON M.MVITSOC='300'
        AND CAST(M.MVCJMVT AS DATE) = md.date AND M.MVCJMVT = '20210901'
        AND M.MVCTGENRE='M'
        AND M.MVCTTYPE='S'
        AND M.MVCTLIB LIKE '%SC#%'
    LEFT JOIN dbo.ARTICLE A WITH(NOLOCK)
        ON M.MVCTCODART = A.ARKTCODART AND M.MVITSOC = A.ARKTSOC AND M.MVCTCOMART = A.ARKTCOMART