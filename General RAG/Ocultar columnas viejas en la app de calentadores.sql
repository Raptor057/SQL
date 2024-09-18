SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER function [dbo].[ufn_get_items](@is_validated BIT)
returns table
as return (
    SELECT ROW_NUMBER() OVER(ORDER BY repair_date DESC, i.id) [seq_no], i.*, s.name [status],
        (select count(*) from items_x_operations where item_id = i.id and closing_status is null and initial_status != '' and initial_status != 'x') [pending_ops]
    FROM dbo.items i
    JOIN dbo.item_statuses s
        ON s.id = i.status_id
    WHERE i.is_validated = @is_validated 
    AND I.UtcTimeStamp IS NOT NULL --Agregado nuevo para no modificar el Frond End
);
GO
