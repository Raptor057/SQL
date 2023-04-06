SET DATEFIRST 1;

SELECT e.linea, e.eti_no, e.component, e.lote, c.bin_size, MIN(creation_time) fecha
FROM dbo.Etis_WB e WITH(NOLOCK)
LEFT JOIN dbo.eti_packing_counters c WITH(NOLOCK)
    ON c.eti_no = e.eti_no
WHERE DATEPART(WEEK, e.creation_time) = DATEPART(WEEK, GETDATE()) - 1
AND (e.component = '33088' OR e.component = '33109' OR e.component = '33106')
GROUP BY e.linea, e.eti_no, e.component, e.lote, c.bin_size
ORDER BY fecha;

