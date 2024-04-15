--exec UspUpdateGamma '85651', 'LB'
with x as (
    select t.PointOfUseCode, t.ComponentNo from dbo.UfnUnitComponentsTrazability(8821514, null) t
    left join Gammas g on
        g.partno = '85651' and partrev='LB' and
        g.PointOfUseCode = t.PointOfUseCode and g.CompNo = t.ComponentNo
    where g.PartNo is null
)
--update e set e.UtcExpirationTime = '2022-10-25 14:08' 
select *
from x
join PointOfUseEtis e
    on e.ComponentNo=x.ComponentNo and x.PointOfUseCode=e.PointOfUseCode and e.UtcExpirationTime is null and e.UtcUsageTime is not null

exec UspUpdateGamma '85691','LA'
exec UspUpdateLineGamma 'LA', '85691','LA'

truncate table 