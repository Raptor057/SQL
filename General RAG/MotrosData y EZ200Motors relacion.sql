SELECT md.*,EZM.*
  FROM [gtt].[dbo].[MotorsData] MD
  INNER JOIN [gtt].[dbo].[EZ2000Motors] EZM
  ON MD.SerialNumber = EZM.Motor_number AND MD.DateTimeMotor = CONVERT(datetime, EZM.[Date] + ' ' + EZM.[Time])