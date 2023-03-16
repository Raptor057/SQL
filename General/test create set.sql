declare
    @label_no nvarchar(50)='E283139',         -- label number
    @label_id bigint=283139,               -- label id
    @user_input nvarchar(50)='E283139',       -- ui input
    @line_code nvarchar(50)='WB LQ',        -- line code
    @TUNNEL nvarchar(50)='Q01',           -- point of use location
    @NP nvarchar(50)='85621-REAR',               -- final assembly part number
    @MODELO nvarchar(50)='TTI/OWT'           -- model number
;
    set nocount on;

    declare @message nvarchar(max),
        @npx nvarchar(50),          -- component part number
        @lote nvarchar(max),        -- lot number
        @revcc nvarchar(50),        -- revision
        @setid nvarchar(50),        -- new set id
        @old_setid nvarchar(50),    -- active set id
        @line_set_id_offset int,    -- helper value to calculate the new set id
        @str_date nvarchar(50),     -- formatted date
        @tunel nvarchar(50),        -- actual point of use location
        @set_size int,
        @bom_size int
        ;

    declare @ONE_CHARACTER int = 1, @A_CHAR_ASCII_VALUE_OFFSET int = 64;

    set @str_date = format(getdate(), 'dd-MMM-yyyy');

    -- get actual point of use
    select
        @tunel = punto_uso
    from tbl_point_use
    where eti_no=@label_no
    and np_final=@NP
    and (
        left(PUNTO_USO, 2) = 'BM' -- is pump?
        or
        LINEA=right(@line_code, 2)
        );

    if right(left(@user_input, 6), 2) = 'ES' -- is subassembly?
    begin
        -- get subassembly label data
        select @npx = ltrim(rtrim(np1)), @lote = lot1, @revcc = rev1 from dbo.pro_SUBETI where id=@label_id;
    end
    else begin
        -- get assembly label data
        select @npx = ltrim(rtrim(PART_NUMBER)), @lote = lot, @revcc = rev_cc from apps.dbo.pro_eti001 where id=@label_id;
    end

    -- can't continue without part number or lot number
    if len(isnull(@npx, '')) > 0 and len(isnull(@lote, '')) > 0
    begin
        begin transaction;
        begin try
            -- get new line set id
            EXEC dbo.usp_traceability_get_new_set_id @line_code, @setid out;

            -- get active set id
            select top 1 @old_setid = SET_ID from dbo.etis_wb where LINEA=@line_code AND status=0;

            -- copy last set components as the new set
            insert into etis_wb (set_id,eti_no,eti_001,component,rev_cc,lote,fecha,linea,puesto_no,np_final,modelo,need_val,was_val,status)
            select @setid,eti_no,eti_001,component,rev_cc,lote,fecha,linea,puesto_no,np_final,modelo,need_val,was_val,status
            from dbo.Etis_WB where SET_ID = @old_setid and [status]=0;

            -- close active set
            update dbo.Etis_WB set [status]=1 where SET_ID = @old_setid and [status]=0;

            DECLARE @validate_set_size_result INT;
            EXEC @validate_set_size_result = dbo.usp_traceability_validate_set_size
                @set_id = @setid,
                @finish_good_no = @NP,
                @line_code = @line_code,
                @message = @message OUT;

            IF @validate_set_size_result != 0
            BEGIN
                select * from Etis_WB where linea='wb lh' and [status]=0 and SET_ID=@setid;
                ROLLBACK;
                print @message;
                RETURN;
            END

            if dbo.ufn_traceability_check_if_point_of_use_is_shared(@line_code, @TUNNEL) = 1
            begin
                -- remove component loaded in all lines related to the pump
                delete e
                from etis_wb e
                join dbo.pumps_x_lines x
                    on x.is_enabled = 1 and e.linea = x.line_code and x.pump_code = e.puesto_no
                where e.COMPONENT=@npx and e.SET_ID=@setid and e.PUESTO_NO=@TUNNEL;

                -- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                declare @affected_sets table(set_id nvarchar(50), line_code nvarchar(50));

                insert into @affected_sets (set_id, line_code)
                select distinct e.set_id, e.linea
                from etis_wb e
                join dbo.pumps_x_lines x
                    on x.is_enabled = 1 and e.linea = x.line_code and x.pump_code = e.puesto_no
                where e.COMPONENT=@npx and e.STATUS=0 and e.PUESTO_NO=@TUNNEL;
                -- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

                -- 
                update e set e.status = 1
                from etis_wb e
                join dbo.pumps_x_lines x
                    on x.is_enabled = 1 and e.linea = x.line_code and x.pump_code = e.puesto_no
                where e.COMPONENT=@npx and e.STATUS=0 and e.PUESTO_NO=@TUNNEL;


                -- 
                --insert into etis_wb (set_id,eti_no, eti_001, component, rev_cc, lote, fecha, linea, puesto_no, need_val,NP_FINAL,MODELO, source)
                select distinct wb.SET_ID, @label_no, @label_id, @npx, @revcc, @lote, @str_date, x.line_code, @TUNNEL, 0, pu.modelo, wo.client_name, @line_code
                from dbo.pumps_x_lines x
                join apps.dbo.pro_prod_units pu
                    ON pu.comments = x.line_code
                join apps.dbo.pro_production wo
                    ON wo.codew = pu.codew AND wo.is_running = 1 AND wo.is_stoped = 0
                join (
                    select distinct linea, set_id from (
                        select linea, set_id from dbo.Etis_WB where [status] = 0
                        union all
                        select @line_code, @setid -- in case the line is empty
                        union all
                        select line_code, set_id from @affected_sets
                    )t
                ) wb
                    ON wb.linea = x.line_code
                where x.pump_code = @TUNNEL;

            end
            else begin

                delete etis_wb where COMPONENT=@npx AND LINEA=@line_code AND PUESTO_NO=@tunel AND SET_ID=@setid;

                insert into etis_wb (set_id,eti_no, eti_001, component, rev_cc, lote, fecha, linea, puesto_no, need_val,NP_FINAL,MODELO)
                values (@setid, @label_no, @label_id, @npx, @revcc, @lote, @str_date, @line_code, @tunel, 0, @NP, @MODELO);

            end

            print 'ok'
            rollback;

        end try
        begin catch
            rollback;
            print ERROR_MESSAGE();
            return;

        end catch
    end
    else begin
        print 'ETI No Existe en Sistema';
        return;
    end

    print 'OK';
    return;