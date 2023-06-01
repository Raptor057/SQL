--SELECT top 1000 * FROM dbo.ARTICLE WHERE ARKTSOC = 300                                                                                                                    

SELECT top 1000 * FROM dbo.UARTICLE WHERE ARKTSOC = 300 AND ARKTCOMART = 'LE'
AND ARKTCODART = '87245'

--ARKTCOMART

SELECT CompNo,CompRev,CompDesc, PointOfUse FROM cegid.ufn_bom('84970', 'LA') ORDER BY PointOfUse, CompNo;