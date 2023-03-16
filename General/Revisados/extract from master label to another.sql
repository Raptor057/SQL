DECLARE
    @source BIGINT = 38645,
    @target BIGINT = 38664;

BEGIN TRANSACTION;

UPDATE dbo.Master_labels_WB SET qty = qty + (SELECT qty FROM dbo.Master_labels_WB WHERE Id = @source) WHERE Id = @target;
UPDATE dbo.Master_labels_WB SET qty = 0, is_active = 0 WHERE Id = @source;
UPDATE dbo.Master_lbl_TMid SET Master_id = @target WHERE Master_id = @source;

ROLLBACK;
--COMMIT;