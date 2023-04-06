select * from dbo.Etis_WB where linea='WB LP' and status = 0 and SET_ID like 'LP1%'

update dbo.Etis_WB set [status]=0 where SET_ID='LP165239'

LP165246
LP165239
LP165238

select SET_ID from dbo.Etis_WB
where linea='WB LP' and SET_ID like 'LP1%' and fecha='11-Oct-2021'
group by set_id
order by SET_ID DESC