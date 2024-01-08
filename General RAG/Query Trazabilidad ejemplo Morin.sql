SELECT top 100 PH.*,LP.*, PUE.*, lps.* from ProcessHistory PH
FULL JOIN LinePointsOfUse LP ON PH.LineCode = lp.LineCode 
FULL JOIN PointOfUseEtis pue ON pue.PointOfUseCode = lp.PointOfUseCode
FULL JOIN LineProductionSchedule lps ON lps.LineCode = lp.LineCode
WHERE PH.ProcessID = 999 AND PH.LineCode = 'LO' AND PH.UnitID = '10274250' AND PH.UtcTimeStamp >= lps.UtcEffectiveTime AND PH.UtcTimeStamp <= lps.UtcExpirationTime


order by PH.UtcTimeStamp desc

