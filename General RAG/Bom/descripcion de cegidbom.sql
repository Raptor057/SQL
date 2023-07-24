SELECT TOP (1000) 
        [NOKTCODPF] --Numero de parte.
      ,[NOKTCOMPF] -- Linea
      ,[NOKTCOSFAM]
      ,[i]
      ,[NOCTCODECP] --Componente
      ,[NOCTCOMCPT] --Rev Componente
      ,[NOCTCODOPE] --Tunel
      ,[NOCTTYPOPE] --Tunel Cap
      ,[NOCNQTECOM]
      ,[NOKNLIGNOM]
      ,[ARCTCODFAM]
      ,[ARITNATURE]
      ,[ARCTLIB01] --Descripcion
      ,[ARCTCOSFAM]
      ,[ARKCRITPAR]
      ,[APKSTDPACK]
      ,[NOCTCODATE]
  FROM [TRAZAB].[cegid].[bom] where NOKTCODPF = '85564-10' AND NOKTCOMPF = 'LA'