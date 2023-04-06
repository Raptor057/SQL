declare @linea nvarchar(50) = 'wb lp', @puesto nvarchar(50) = 'LP1';

declare @tmp table (
	[ID] [bigint] NOT NULL,
	[SET_ID] [varchar](max) NULL,
	[eti_no] [varchar](50) NOT NULL,
	[eti_001] [bigint] NOT NULL,
	[component] [varchar](20) NOT NULL,
	[rev_cc] [varchar](5) NOT NULL,
	[lote] [varchar](max) NOT NULL,
	[fecha] [varchar](50) NOT NULL,
	[linea] [varchar](20) NOT NULL,
	[puesto_no] [varchar](5) NOT NULL,
	[NP_FINAL] [varchar](20) NOT NULL,
	[MODELO] [varchar](20) NOT NULL,
	[need_val] [bit] NULL,
	[was_val] [bit] NULL,
	[status] [bit] NULL,
	[creation_time] [datetime] NOT NULL,
    [source] NVARCHAR(50),
    [packing_count] INT
);

declare @last_set_id nvarchar(50);

insert into @tmp
select * from dbo.Etis_WB with(nolock)
where linea = @linea and status = 0 and left(SET_ID, 3) = @puesto;

select top 1 @last_set_id = set_id from @tmp where id = (select max(id) from @tmp);

delete from @tmp where SET_ID != @last_set_id;

with t as (
    select row_number() over(partition by eti_no order by id desc) i, * from @tmp
)
delete x
from t join @tmp x on x.ID = t.ID and t.i > 1;

with t as (
    select row_number() over(partition by component, puesto_no order by id desc) i, * from @tmp
)
delete x
from t join @tmp x on x.ID = t.ID and t.i > 1;

--select * from @tmp order by component;
--return;

begin transaction;

update dbo.Etis_WB set status = 1
where linea = @linea and status = 0 and left(SET_ID, 3) = @puesto;

delete from dbo.Etis_WB where SET_ID = @last_set_id;

INSERT INTO [dbo].[Etis_WB]
        ([SET_ID]
        ,[eti_no]
        ,[eti_001]
        ,[component]
        ,[rev_cc]
        ,[lote]
        ,[fecha]
        ,[linea]
        ,[puesto_no]
        ,[NP_FINAL]
        ,[MODELO]
        ,[need_val]
        ,[was_val]
        ,[status]
        ,[creation_time], source, packing_count)

    SELECT [SET_ID]
        ,[eti_no]
        ,[eti_001]
        ,[component]
        ,[rev_cc]
        ,[lote]
        ,[fecha]
        ,[linea]
        ,[puesto_no]
        ,[NP_FINAL]
        ,[MODELO]
        ,[need_val]
        ,[was_val]
        ,[status]
        ,[creation_time], [source], [packing_count] FROM @tmp;

-- select * from dbo.Etis_WB with(nolock)
-- where linea = @linea and status = 0;


-- select linea, SET_ID, component, puesto_no, count(*)
-- from dbo.Etis_WB with (nolock)
-- where [status]=0
-- group by linea, SET_ID, component, puesto_no
-- having count(*) > 1;

select linea, count(*)
from dbo.Etis_WB with (nolock)
where [status]=0
group by linea;

rollback;

-- update Etis_WB set status = 0 where set_id='LO29560'
-- select * from Etis_WB where set_id='LO29560'

-- select max(set_id) from Etis_WB with(nolock) where linea=@linea;

-- select top 1000 * from Etis_WB where linea='wb lo' order by id desc

-- seleccionar todos
-- borrar todos a exception del set mas nuevo (set_id)
-- ordernar por las mas nuevas [eti_no] y eliminar repetidas
-- eliminar numeros de parte repetidos en el mismo tunel [component] y [puesto]
-- cerrar todos los sets
-- borrar el set mas nuevo y despues insertar lo que resulto de lo filtrado