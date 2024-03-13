DECLARE @UnitID bigint
SET @UnitID = NULL

SELECT 
[ID]
      ,[WB]
      ,[DATE]
      ,[RESULTAT]
        ,CASE WHEN [RESULTAT] = 1 THEN 'OK'
        WHEN [RESULTAT] <> 1 THEN 'NO OK'
        END AS ResultatText
      ,[COUR_VIDE_MAV]
      ,[VIT_G_VIDE_MAV]
      ,[VIT_D_VIDE_MAV]
      ,[COUR_CHARGE_MAV]
      ,[VIT_G_CHARGE_MAV]
      ,[VIT_D_CHARGE_MAV]
      ,[VIRAGE_G]
      ,[COUR_VIDE_MAR]
      ,[VIT_G_VIDE_MAR]
      ,[VIT_D_VIDE_MAR]
      ,[COUR_CHARGE_MAR]
      ,[VIT_G_CHARGE_MAR]
      ,[VIT_D_CHARGE_MAR]
      ,[VIRAGE_D]
      ,[FORCE_L_VIDE]
      ,[DISTANCE_L_VIDE]
      ,[FORCE_C_FREIN]
      ,[DISTANCE_C_FREIN]
      ,[COUPLE_C_FREIN]
      ,[DEFAUT]
      ,[DIST_BRAKE]
      ,[PANIC_BRAKE_TORK]
      ,[AUTO_BRAKE_TORK]
      ,[SWITCH_CONTROL]
      ,[TYPE]
      ,[REFERENCE]
      ,[RETOUR_POSITION_ORIGINE]
      ,[FORCE_A_16mm]
      ,[FORCE_A_5mm]
FROM [MXSRVTRACA].[APPS].[dbo].[pro_tms_functional_test_results] 
WHERE
    (@UnitID IS NULL OR WB = @UnitID)
    AND WB != 0
ORDER BY id DESC;