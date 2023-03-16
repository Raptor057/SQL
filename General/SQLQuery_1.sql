SELECT CompNo, CompRev2, PointOfUse FROM cegid.ufn_bom('85079-10', 'LA') --ORDER BY PointOfUse, CompNo
group by CompNo, CompRev2, PointOfUse having count(*) > 0;