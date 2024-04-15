-- SELECT TOP (1000) [NOKTCODPF]
--       ,[NOKTCOMPF]
--       ,[NOKTCOSFAM]
--       ,[i]
--       ,[NOCTCODECP]
--       ,[NOCTCOMCPT]
--       ,[NOCTCODOPE]
--       ,[NOCTTYPOPE]
--       ,[NOCNQTECOM]
--       ,[NOKNLIGNOM]
--       ,[ARCTCODFAM]
--       ,[ARITNATURE]
--       ,[ARCTLIB01]
--       ,[ARCTCOSFAM]
--       ,[ARKCRITPAR]
--       ,[APKSTDPACK]
--       ,[NOCTCODATE]
--   FROM [TRAZAB].[cegid].[bom] where NOKTCODPF = 'GT84720U' AND NOKTCOMPF = 'LJ'

  --delete cegid.bom where NOKTCODPF = 'GT84915' AND NOKTCOMPF = 'LJ'

  SELECT CASE WHEN (SELECT COUNT([NOKTCODPF]) AS [COUNT Boom] FROM [TRAZAB].[cegid].[bom] WHERE NOKTCODPF = 'GT84915' AND NOKTCOMPF = 'LJ') > 0 THEN 1 ELSE 0 END AS Result