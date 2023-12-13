SELECT 
QEA.id_label,
PE.part_number,
QEA.lot,
PE.REFERENCE,
IIF(QEA.is_approved = 1, 'Aprovado','No Aprovado') as [Estatus de aprovacion],
QEA.comment,
QEA.created_at 
FROM [MXSRVTRACA].[APPS].[dbo].[qty_eti001_approvals] QEA
INNER JOIN [MXSRVTRACA].[APPS].[dbo].[pro_eti001] PE ON PE.id=QEA.id_label
WHERE QEA.comment LIKE '%SKIPLOT%' 
AND QEA.created_at BETWEEN GETDATE()-1 AND GETDATE()  
ORDER BY QEA.id desc