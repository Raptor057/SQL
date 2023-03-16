SELECT
    pu.id [Id],
    pu.letter [Code],
    pu.comments [Name],
    pu.Tipo [ProdType],
    pu.Familia [ProdFamily],
    pu.no_oper [RequiredToOperateHeadcount], -- RequiredOnRollHeadcount = RequiredToOperateHeadcount + AbseteeismFactor
    p.part_number [LoadedPartNo],
    p.rev [LoadedPartRev],
    pu.codew [LoadedCodeW],
    p.client_code [ClientId],
    p.client_name [ClientCode],
    p.target_qty [TargetQty],
    packed.qty + tmp_packed.qty [ActualQty],
    p.target_qty - (packed.qty + tmp_packed.qty) [balance],
    packed.qty [PackedQty],
    tmp_packed.qty [ContainerQty]
FROM dbo.pro_prod_units pu
JOIN pro_production p
    ON p.id_line = pu.id AND p.is_stoped=0 AND p.is_running=1 AND p.is_finished=0
CROSS APPLY (
    SELECT SUM(t.qty)
    FROM TRAZAB.dbo.master_labels_wb t
    WHERE t.codew=p.codew
) packed(qty)
CROSS APPLY (
    SELECT COUNT(*)
    FROM TRAZAB.dbo.temp_pack_wb
    WHERE num_p = TRAZAB.dbo.ufn_get_plain_part_no(RTRIM(REPLACE(p.part_number, '-10', '')))
    AND modelo=RTRIM(p.client_name) AND linea='WB ' + pu.letter
) tmp_packed(qty)
WHERE pu.letter = 'LP';