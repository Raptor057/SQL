-- select APKSKIPLOT,* from UARTICLE 
-- WHERE APKSKIPLOT  IN ('0','1','2','3') 
-- and ARKTCODART IN ('34920'
-- ,'15086'
-- ,'44023'
-- ,'33082'
-- ,'33082'
-- ,'35231'
-- ,'34233'
-- ,'37533')

SELECT top 1 RTRIM(APKSKIPLOT) AS [SKIPLOT],* FROM UARTICLE 
WHERE ARKTCODART like ('%36096%') AND ARKTCOMART like ('%B%')



--para fabien
--update UARTICLE SET APKSKIPLOT = '' WHERE ARKTCODART like ('%36096%') AND ARKTCOMART like ('%B%')

--INSERT INTO UARTICLE (ARKTSOC, ARKTCODART, ARKTCOMART) VALUES ('300','36096','B')

