with t as (
select comp_no, comp_rev_2, comp_desc, point_of_use_code from dbo.gamma where part_no = '85540' and part_rev='LB'
except
select comp_no, comp_rev_2, comp_desc, point_of_use_code from dbo.gamma where part_no = '85651' and part_rev='LB'
)
update PointOfUseEtis set UtcExpirationTime=getutcdate() where UtcUsageTime is not null and UtcExpirationTime is null
and PointOfUseCode in (select point_of_use_code from t);

with t as (
    select comp_no, comp_rev_2, comp_desc, point_of_use_code from dbo.gamma where part_no = '85540' and part_rev='LB'
    except
    select comp_no, comp_rev_2, comp_desc, point_of_use_code from dbo.gamma where part_no = '85651' and part_rev='LB'
)
--select *
update x set x.UtcExpirationTime=GETUTCDATE(), Comments='MANUAL'
from PointOfUseEtis x where UtcUsageTime is null and UtcExpirationTime is null
and PointOfUseCode in (select point_of_use_code from t)