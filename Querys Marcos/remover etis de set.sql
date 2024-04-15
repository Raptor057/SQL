--exec UspUpdateGamma '85651', ;;

/**
 * Esto se debe de correr al momento que se descuadra el conjunto de componentes activos
 *
 * Reporte de trazabilidad:
 * http://mxsrvapps/reports/report/MFG/Prod/Traza2/Trazabilidad%20Por%20Unidad
 */

declare
    @linea char(2) = 'LB', -- se toma del reporte de trazabilidad
    @unidad bigint = 8821514, -- una pieza de la linea despues del cambio de modelo
    @fecha_de_escaneo datetime = '2022-10-26 18:35', -- fecha de escaneo de la pieza (select * from processhistory where unitid=@unidad and processid='999' and linecode=@linea)
    @numero_de_parte nvarchar(50) = '85651'; -- se toma del reporte de trazabilidad

--update e set e.UtcExpirationTime = @fecha_de_escaneo
select *--e.*
from dbo.UfnUnitComponentsTrazability(@unidad, null) s
left join dbo.gammas g
    on g.PointOfUseCode=s.PointOfUseCode and g.CompNo=s.ComponentNo and g.partno=@numero_de_parte and g.PartRev=@linea
join PointOfUseEtis e
     on e.EtiNo=s.EtiNo and e.UtcUsageTime is not null and e.UtcExpirationTime is null
where g.partno is null;